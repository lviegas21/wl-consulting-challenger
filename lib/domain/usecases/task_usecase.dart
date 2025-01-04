import 'package:wl_consulting_challenger/domain/entities/task_entity.dart';

import '../repositories/repositories.dart';

class TaskUsecase {
  final TaskRepository taskRepository;

  TaskUsecase({required this.taskRepository});

  Future<List<TaskEntity>> getAll() async {
    return await taskRepository.getAllTask();
  }

  Future<void> add(TaskEntity task) async {
    return await taskRepository.addTask(task);
  }

  Future<void> delete(int id) async {
    return await taskRepository.deleteTask(id);
  }

  Future<void> update(TaskEntity task) async {
    return await taskRepository.updateTask(task);
  }

  Future<List<TaskEntity>> getPaginated(int offset, int limit) async {
    return await taskRepository.getTasksPaginated(offset, limit);
  }
}
