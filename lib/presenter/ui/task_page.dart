import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_consulting_challenger/presenter/ui/pages/create_page.dart';
import 'package:wl_consulting_challenger/presenter/ui/pages/list_page.dart';
import 'package:wl_consulting_challenger/presenter/ui/pages/search_page.dart';
import 'package:wl_consulting_challenger/presenter/ui/pages/sucess_page.dart';

import '../bloc/bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import 'widget/app_bar_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskErrorState) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return _buildWidgetIndex(context);
            }
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildWidgetIndex(BuildContext context) {
    List<Widget> widgets = [
      ListPage(),
      CreatePage(),
      SearchPage(),
      SucessPage(),
    ];

    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      int currentIndex = 0;
      if (state is TaskNavigationState) {
        currentIndex = state.currentIndex;
      }
      return widgets[currentIndex];
    });
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is TaskNavigationState) {
          currentIndex = state.currentIndex;
        }

        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              label: 'Todo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done_all),
              label: 'Done',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            context.read<TaskBloc>().add(UpdateNavigationIndexEvent(index));
          },
        );
      },
    );
  }
}
