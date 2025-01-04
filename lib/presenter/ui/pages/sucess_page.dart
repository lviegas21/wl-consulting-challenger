import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../task_event.dart';
import '../task_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/task_list_item.dart';

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
          }

          final tasks = state is TaskNavigationState
              ? state.tasks.where((task) => task.isCompleted == true).toList()
              : state is TaskLoadedState
                  ? state.tasks
                      .where((task) => task.isCompleted == true)
                      .toList()
                  : [];

          if (tasks.isEmpty) {
            return const EmptyState(
              icon: Icons.check_circle_outline,
              message: 'Nenhuma tarefa concluída ainda.',
              submessage: 'Complete tarefas para vê-las aqui.',
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tarefas Concluídas',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      for (var task in tasks) {
                        context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                      }
                    },
                    child: Text(
                      'Excluir todas',
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
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskListItem(
                      task: task,
                      onDelete: () {
                        context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
