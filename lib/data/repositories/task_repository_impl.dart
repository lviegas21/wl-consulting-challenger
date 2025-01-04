import 'package:wl_consulting_challenger/domain/entities/task_entity.dart';

import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatabase taskDatabase;

  TaskRepositoryImpl({required this.taskDatabase});

  @override
  Future<void> addTask(TaskEntity task) async {
    await taskDatabase.addTask(task);
  }

  @override
  Future<void> deleteTask(int id) async {
    await taskDatabase.deleteTask(id);
  }

  @override
  Future<List<TaskEntity>> getAllTask() async {
    return await taskDatabase.getAllTasks();
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await taskDatabase.updateTask(task);
  }
}
