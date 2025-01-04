import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/bloc.dart';
import '../task_event.dart';
import '../task_state.dart';

class SucessPage extends StatelessWidget {
  const SucessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskNavigationState && state.currentIndex == 3) {
            return _buildTaskSucessList(context, state.tasks);
          } else if (state is TaskErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTaskSucessList(BuildContext context, List<TaskEntity> tasks) {
    final completedTasks =
        tasks.where((task) => task.isCompleted == true).toList();

    if (completedTasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No completed tasks yet.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete tasks to see them here.',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Completed Tasks',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                // Add delete all completed tasks functionality
                for (var task in completedTasks) {
                  context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                }
              },
              child: Text(
                'Delete all',
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final task = completedTasks[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: Colors.grey[400],
                  ),
                  title: Text(
                    task.title!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red[300],
                    ),
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
