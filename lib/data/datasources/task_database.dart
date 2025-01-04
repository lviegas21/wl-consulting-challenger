import '../../domain/entities/entities.dart';

abstract class TaskDatabase {
  Future<void> addTask(TaskEntity task);
  Future<List<TaskEntity>> getAllTasks();
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int id);
}
