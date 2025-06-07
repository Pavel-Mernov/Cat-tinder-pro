import 'package:cat_tinder_pro/data/databases/cat_table.dart';
import 'package:cat_tinder_pro/domain/connection_listeners/connection_listener.dart';
import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/liked_cats_bloc/liked_cats_bloc.dart';
import 'package:cat_tinder_pro/presentation/blocs/connection_blocs/connection_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/datasources/cat_remote_data_source.dart';
import '../../data/repositories/cat_repository_impl.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../presentation/blocs/cat_blocs/cat_bloc/cat_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<CatRemoteDataSource>(
    () => CatRemoteDataSource(dio: getIt()),
  );

  getIt.registerLazySingleton<ConnectionListener>(() => ConnectionListener());

  final initialConnection = await getIt<ConnectionListener>().checkConnection();

  getIt.registerLazySingleton<ConnectionBloc>(
    () => ConnectionBloc(initialConnection),
  );

  final version = 3;
  final path = await getDatabasesPath();
  final dbName = "cats_$version.db";

  final catTable =
      await CatTable(path, dbName, version: version, dbName: 'cats').initDb();

  getIt.registerLazySingleton<CatTable>(() => catTable);

  getIt.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(
      remoteDataSource: getIt(),
      database: getIt(),
      connectionListener: getIt(),
    ),
  );

  getIt.registerFactory<CatBloc>(
    () => CatBloc(repository: getIt<CatRepository>()),
  );

  getIt.registerLazySingleton(
    () => LikedCatsBloc(repository: getIt<CatRepository>()),
  );
}
