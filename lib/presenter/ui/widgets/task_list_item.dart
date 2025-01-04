import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';

class TaskListItem extends StatelessWidget {
  final TaskEntity task;
  final Function(bool)? onToggleCompleted;
  final VoidCallback? onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    this.onToggleCompleted,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          task.isCompleted! ? Icons.check_circle : Icons.circle_outlined,
          color: Colors.grey[400],
        ),
        title: Text(
          task.title!,
          style: TextStyle(
            decoration: task.isCompleted! ? TextDecoration.lineThrough : null,
            color: task.isCompleted! ? Colors.grey[400] : Colors.black,
          ),
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red[300],
                ),
                onPressed: onDelete,
              )
            : null,
        onTap: onToggleCompleted != null
            ? () => onToggleCompleted!(!task.isCompleted!)
            : null,
      ),
    );
  }
}
