import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/task_bloc.dart';
import '../task_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/task_create_modal.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          final tasks = state is TaskNavigationState
              ? state.tasks
              : state is TaskLoadedState
                  ? state.tasks
                  : [];

          if (tasks.isEmpty) {
            return EmptyState(
              icon: Icons.task_alt_outlined,
              message: 'Você não tem tarefas listadas.',
              submessage: 'Crie tarefas para alcançar mais.',
              action: ElevatedButton.icon(
                onPressed: () => _showCreateTaskModal(context),
                icon: const Icon(Icons.add),
                label: const Text('Criar tarefa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Bem-vindo, John.',
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
                  "Você tem ${tasks.length} tarefas para fazer.",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _showCreateTaskModal(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Criar tarefa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCreateTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const TaskCreateModal(),
    );
  }
}
