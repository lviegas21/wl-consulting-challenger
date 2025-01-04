import '../entities/entities.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTask();
  Future<List<TaskEntity>> getTasksPaginated(int offset, int limit);
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int id);
}
