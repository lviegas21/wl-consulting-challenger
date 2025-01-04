import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wl_consulting_challenger/domain/entities/task_entity.dart';
import 'package:wl_consulting_challenger/domain/repositories/task_repository.dart';
import 'package:wl_consulting_challenger/domain/usecases/task_usecase.dart';
import 'package:wl_consulting_challenger/presenter/bloc/task_bloc.dart';
import 'package:wl_consulting_challenger/presenter/ui/task_event.dart';
import 'package:wl_consulting_challenger/presenter/ui/task_state.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskUsecase taskUsecase;
  late TaskBloc taskBloc;
  late MockTaskRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(
      const TaskEntity(
        id: 1,
        title: 'Tarefa Exemplo',
        description: 'Descrição Exemplo',
        isCompleted: false,
      ),
    );
  });

  setUp(() {
    mockRepository = MockTaskRepository();
    taskUsecase = TaskUsecase(taskRepository: mockRepository);
    taskBloc = TaskBloc(usecase: taskUsecase);
  });

  tearDown(() {
    taskBloc.close();
  });

  group('Testes de Gerenciamento de Tarefas', () {
    final task = TaskEntity(
      id: 1,
      title: 'Tarefa de Teste',
      description: 'Descrição de Teste',
      isCompleted: false,
    );

    test('deve emitir [TaskLoadingState, TaskLoadedState] quando LoadTasksEvent é adicionado', () async {
      // Arrange
      when(() => mockRepository.getAllTask())
          .thenAnswer((_) async => [task]);

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoadingState>(),
          isA<TaskLoadedState>().having((state) => state.tasks, 'tarefas', [task]),
        ]),
      );

      // Act
      taskBloc.add(LoadTasksEvent());
    });

    test('deve emitir [TaskLoadingState, TaskErrorState] quando LoadTasksEvent falha', () async {
      // Arrange
      when(() => mockRepository.getAllTask())
          .thenThrow(Exception('Erro ao carregar tarefas'));

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoadingState>(),
          isA<TaskErrorState>().having((state) => state.error, 'erro', 'Exception: Erro ao carregar tarefas'),
        ]),
      );

      // Act
      taskBloc.add(LoadTasksEvent());
    });

    test('deve emitir [TaskLoadedState] quando AddTaskEvent é adicionado', () async {
      // Arrange
      when(() => mockRepository.addTask(any()))
          .thenAnswer((_) async {});
      when(() => mockRepository.getAllTask())
          .thenAnswer((_) async => [task]);

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoadedState>().having((state) => state.tasks, 'tarefas', [task]),
        ]),
      );

      // Act
      taskBloc.add(AddTaskEvent(task));
    });

    test('deve emitir [TaskLoadedState] quando UpdateTaskEvent é adicionado', () async {
      // Arrange
      when(() => mockRepository.updateTask(any()))
          .thenAnswer((_) async {});
      when(() => mockRepository.getAllTask())
          .thenAnswer((_) async => [task.copyWith(isCompleted: true)]);

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoadedState>().having(
            (state) => state.tasks.first.isCompleted,
            'tarefa completada',
            true,
          ),
        ]),
      );

      // Act
      taskBloc.add(UpdateTaskEvent(task.copyWith(isCompleted: true)));
    });

    test('deve emitir [TaskLoadedState] quando DeleteTaskEvent é adicionado', () async {
      // Arrange
      when(() => mockRepository.deleteTask(any()))
          .thenAnswer((_) async {});
      when(() => mockRepository.getAllTask())
          .thenAnswer((_) async => []);

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoadedState>().having(
            (state) => state.tasks,
            'lista de tarefas vazia',
            isEmpty,
          ),
        ]),
      );

      // Act
      taskBloc.add(DeleteTaskEvent(1));
    });

    test('deve emitir estados corretos ao buscar tarefas', () async {
      // Arrange
      when(() => mockRepository.getAllTask())
          .thenAnswer((_) async => [task]);

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskSearchState>().having(
            (state) => state.searchResults,
            'resultados da busca',
            [task],
          ).having(
            (state) => state.query,
            'termo de busca',
            'Test',
          ),
        ]),
      );

      // Act
      taskBloc.add(SearchTaskEvent('Test'));
    });

    test('deve emitir [TaskLoadingMoreState, TaskLoadedState] quando LoadMoreTasksEvent é adicionado', () async {
      // Arrange
      final initialTasks = [task];
      final moreTasks = [
        TaskEntity(
          id: 2,
          title: 'Tarefa de Teste 2',
          description: 'Descrição de Teste 2',
          isCompleted: false,
        ),
      ];

      when(() => mockRepository.getAllTask())
          .thenAnswer((_) async => initialTasks);
      when(() => mockRepository.getTasksPaginated(any(), any()))
          .thenAnswer((_) async => moreTasks);

      // Inicializar o estado
      taskBloc.emit(TaskLoadedState(initialTasks));

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoadingMoreState>()
              .having((state) => state.currentTasks, 'tarefas atuais', initialTasks),
          isA<TaskLoadedState>()
              .having((state) => state.tasks, 'todas as tarefas', [...initialTasks, ...moreTasks])
              .having((state) => state.hasMoreItems, 'tem mais itens', false),
        ]),
      );

      // Act
      taskBloc.add(LoadMoreTasksEvent(offset: initialTasks.length, limit: 10));
    });

    test('deve emitir [TaskLoadingMoreState, TaskErrorState] quando LoadMoreTasksEvent falha', () async {
      // Arrange
      final initialTasks = [task];
      when(() => mockRepository.getAllTask())
          .thenAnswer((_) async => initialTasks);
      when(() => mockRepository.getTasksPaginated(any(), any()))
          .thenThrow(Exception('Erro ao carregar mais tarefas'));

      // Inicializar o estado
      taskBloc.emit(TaskLoadedState(initialTasks));

      // Assert Later
      expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskLoadingMoreState>()
              .having((state) => state.currentTasks, 'tarefas atuais', initialTasks),
          isA<TaskErrorState>()
              .having((state) => state.error, 'erro', 'Exception: Erro ao carregar mais tarefas'),
        ]),
      );

      // Act
      taskBloc.add(LoadMoreTasksEvent(offset: initialTasks.length, limit: 10));
    });
  });
}