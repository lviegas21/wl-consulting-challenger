import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/task_bloc.dart';
import '../task_event.dart';
import '../task_state.dart';
import '../widgets/task_card_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.9) {
      _isLoadingMore = true;
      final currentState = context.read<TaskBloc>().state;
      if (currentState is TaskLoadedState && currentState.hasMoreItems) {
        context.read<TaskBloc>().add(
              LoadMoreTasksEvent(
                offset: currentState.tasks.length,
                limit: TaskBloc.pageSize,
              ),
            );
      }
      _isLoadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskNavigationState && state.currentIndex == 0) {
            return _buildTaskList(context, state.tasks);
          } else if (state is TaskLoadedState) {
            return _buildTaskList(context, state.tasks);
          } else if (state is TaskLoadingMoreState) {
            return _buildTaskList(context, state.currentTasks,
                isLoadingMore: true);
          } else if (state is TaskErrorState) {
            return Center(child: Text('Erro: ${state.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, List<TaskEntity> tasks,
      {bool isLoadingMore = false}) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt_outlined,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Você não tem tarefas listadas.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Crie tarefas para alcançar mais.',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            'Bem-vindo, John.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Você tem ${tasks.length} tarefas para fazer.",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: tasks.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == tasks.length) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final task = tasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TaskCard(
                  task: task,
                  onToggleCompleted: (isCompleted) {
                    context.read<TaskBloc>().add(
                          UpdateTaskEvent(
                              task.copyWith(isCompleted: isCompleted)),
                        );
                  },
                  onDelete: () {
                    context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
