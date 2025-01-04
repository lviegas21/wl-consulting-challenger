import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/task_bloc.dart';
import '../task_event.dart';
import '../task_state.dart';
import '../widget/task_card_widget.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskNavigationState && state.currentIndex == 0) {
            return _buildTaskList(context, state.tasks);
          } else if (state is TaskLoadedState) {
            return _buildTaskList(context, state.tasks);
          } else if (state is TaskErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, List<TaskEntity> tasks) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt_outlined,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'You have no task listed.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create tasks to achieve more.',
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
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            'Welcome, John.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "You've got ${tasks.length} tasks to do.",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TaskCard(
                  task: task,
                  onToggleCompleted: (isCompleted) {
                    context.read<TaskBloc>().add(
                          UpdateTaskEvent(
                              task.copyWith(isCompleted: isCompleted)),
                        );
                  },
                  onDelete: () {
                    context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
