import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_consulting_challenger/presenter/bloc/bloc.dart';
import 'package:wl_consulting_challenger/presenter/ui/task_page.dart';
import 'core/di/injection_dependencie.dart' as di;
import 'presenter/ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<TaskBloc>()
            ..add(LoadTasksEvent()), // Dispara o evento inicial
        ),
      ],
      child: MaterialApp(
        title: 'Desafio',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          cardTheme: const CardTheme(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        home: TaskPage(),
      ),
    );
  }
}
