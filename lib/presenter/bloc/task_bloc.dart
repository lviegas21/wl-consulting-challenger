import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_consulting_challenger/domain/usecases/usecases.dart';
import '../ui/ui.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUsecase usecase;

  TaskBloc({required this.usecase}) : super(TaskInitialState()) {
    on<CompletedTaskEvent>(_onLoadCompletedTasks);
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<UpdateNavigationIndexEvent>(_onUpdateNavigationIndex);
    on<SearchTaskEvent>(_onSearchTasks);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final tasks = await usecase.getAll();
      final currentState = state;
      if (currentState is TaskNavigationState) {
        emit(TaskNavigationState(currentState.currentIndex, tasks: tasks));
      } else {
        emit(TaskLoadedState(tasks));
      }
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  Future<void> _onLoadCompletedTasks(
      CompletedTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final tasks = await usecase.getAll();
      final completedTasks =
          tasks.where((task) => task.isCompleted == true).toList();
      emit(TaskCompletedState(completedTasks));
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await usecase.add(event.task);
      final tasks = await usecase.getAll();
      final currentState = state;
      if (currentState is TaskNavigationState) {
        emit(TaskNavigationState(currentState.currentIndex, tasks: tasks));
      } else {
        emit(TaskLoadedState(tasks));
      }
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await usecase.update(event.task);
      final tasks = await usecase.getAll();
      final currentState = state;
      if (currentState is TaskNavigationState) {
        emit(TaskNavigationState(currentState.currentIndex, tasks: tasks));
      } else {
        emit(TaskLoadedState(tasks));
      }
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await usecase.delete(event.id);
      final tasks = await usecase.getAll();
      final currentState = state;
      if (currentState is TaskNavigationState) {
        emit(TaskNavigationState(currentState.currentIndex, tasks: tasks));
      } else {
        emit(TaskLoadedState(tasks));
      }
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  void _onUpdateNavigationIndex(
      UpdateNavigationIndexEvent event, Emitter<TaskState> emit) async {
    try {
      final tasks = await usecase.getAll();
      emit(TaskNavigationState(event.index, tasks: tasks));
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  Future<void> _onSearchTasks(
      SearchTaskEvent event, Emitter<TaskState> emit) async {
    if (event.query.isEmpty) {
      final currentState = state;
      if (currentState is TaskNavigationState) {
        emit(TaskNavigationState(currentState.currentIndex, tasks: []));
      } else {
        emit(TaskSearchState([], event.query));
      }
      return;
    }

    try {
      final tasks = await usecase.getAll();
      final searchResults = tasks.where((task) => 
        task.title!.toLowerCase().contains(event.query.toLowerCase()) ||
        (task.description != null && 
         task.description!.toLowerCase().contains(event.query.toLowerCase()))
      ).toList();
      
      final currentState = state;
      if (currentState is TaskNavigationState) {
        emit(TaskNavigationState(currentState.currentIndex, tasks: searchResults));
      } else {
        emit(TaskSearchState(searchResults, event.query));
      }
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }
}
