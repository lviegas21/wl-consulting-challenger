import 'package:get_it/get_it.dart';

import '../../data/datasources/datasources.dart';
import '../../data/repositories/repositories.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/usecases/usecases.dart';
import '../../presenter/bloc/bloc.dart';
import '../database/database.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Registro do TaskBloc
  sl.registerFactory(
    () => TaskBloc(
      usecase: sl(),
    ),
  );

  // Registro do TaskUsecase
  sl.registerLazySingleton(() => TaskUsecase(taskRepository: sl()));

  // Registro do TaskRepository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(taskDatabase: sl()),
  );

  // Registro do TaskDatabase
  sl.registerLazySingleton<TaskDatabase>(() => TaskDatabaseImpl());
}
