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
      margin: const EdgeInsets.only(bottom: 8),
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (value) => onToggleCompleted(value!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          title: Text(
            task.title ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          trailing: const Icon(Icons.more_horiz, color: Colors.grey),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(72, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  task.description ?? 'No description',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
