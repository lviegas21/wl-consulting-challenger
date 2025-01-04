import '../../domain/entities/entities.dart';

// Eventos
abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class CompletedTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  DeleteTaskEvent(this.id);
}

class UpdateNavigationIndexEvent extends TaskEvent {
  final int index;

  UpdateNavigationIndexEvent(this.index);
}

class SearchTaskEvent extends TaskEvent {
  final String query;

  SearchTaskEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadMoreTasksEvent extends TaskEvent {
  final int offset;
  final int limit;

  LoadMoreTasksEvent({required this.offset, required this.limit});
}
