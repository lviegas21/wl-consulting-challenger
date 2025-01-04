import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/bloc.dart';
import '../task_event.dart';
import '../task_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              onChanged: (value) {
                context.read<TaskBloc>().add(SearchTaskEvent(value));
              },
              decoration: InputDecoration(
                hintText: 'Design projects',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                suffixIcon: Icon(Icons.close, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskNavigationState && state.currentIndex == 2) {
                  return _buildSearchResults(state.tasks);
                } else if (state is TaskSearchState) {
                  return _buildSearchResults(state.searchResults);
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<TaskEntity> tasks) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No result found.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          leading: Icon(
            task.isCompleted! ? Icons.check_circle : Icons.circle_outlined,
            color: Colors.grey[400],
          ),
          title: Text(
            task.title!,
            style: TextStyle(
              decoration: task.isCompleted! ? TextDecoration.lineThrough : null,
              color: task.isCompleted! ? Colors.grey[400] : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
