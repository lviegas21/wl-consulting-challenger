import '../../domain/entities/entities.dart';

abstract class TaskDatabase {
  Future<void> addTask(TaskEntity task);
  Future<List<TaskEntity>> getAllTasks();
  Future<List<TaskEntity>> getTasksPaginated(int offset, int limit);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int id);
}
