import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitialState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskLoadingState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskLoadedState extends TaskState {
  final List<TaskEntity> tasks;

  const TaskLoadedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskCompletedState extends TaskState {
  final List<TaskEntity> tasks;

  const TaskCompletedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskSucessState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskErrorState extends TaskState {
  final String error;

  const TaskErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class TaskCreateModeState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskNavigationState extends TaskState {
  final int currentIndex;
  final List<TaskEntity> tasks;

  const TaskNavigationState(this.currentIndex, {this.tasks = const []});

  @override
  List<Object?> get props => [currentIndex, tasks];
}

class TaskSearchState extends TaskState {
  final List<TaskEntity> searchResults;
  final String query;

  const TaskSearchState(this.searchResults, this.query);

  @override
  List<Object?> get props => [searchResults, query];
}
