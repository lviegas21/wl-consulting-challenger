import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final Function(bool) onToggleCompleted;
  final VoidCallback onDelete;

  const TaskCard({
    required this.task,
    required this.onToggleCompleted,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => onToggleCompleted(value!),
        ),
        title: Text(
          task.title ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          task.description ?? '',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.grey),
          onPressed: () {
            // Ações adicionais, como editar ou compartilhar
          },
        ),
        onTap: () {
          // Ação ao tocar no card
        },
      ),
    );
  }
}
