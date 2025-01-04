import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/task_bloc.dart';
import '../task_event.dart';

class TaskCreateModal extends StatelessWidget {
  const TaskCreateModal({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "O que você tem em mente?",
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Row(
            children: [
              Icon(Icons.edit_outlined, color: Colors.grey[400], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Adicione uma nota...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _handleCreateTask(
                context,
                titleController.text,
                descriptionController.text,
              ),
              child: Text(
                "Criar",
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCreateTask(
    BuildContext context,
    String title,
    String description,
  ) {
    final trimmedTitle = title.trim();
    final trimmedDescription = description.trim();

    if (trimmedTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, adicione um título para a tarefa'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<TaskBloc>().add(
          AddTaskEvent(
            TaskEntity(
              id: null,
              title: trimmedTitle,
              description: trimmedDescription,
              isCompleted: false,
            ),
          ),
        );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tarefa criada com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
