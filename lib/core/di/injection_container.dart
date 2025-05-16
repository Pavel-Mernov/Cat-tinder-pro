import 'package:cat_tinder_pro/domain/usecases/like_cat.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/cat_remote_data_source.dart';
import '../../data/repositories/cat_repository_impl.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../domain/usecases/get_random_cat.dart';
import '../../presentation/blocs/cat_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<CatRemoteDataSource>(
    () => CatRemoteDataSource(dio: getIt()),
  );

  getIt.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<GetRandomCat>(
    () => GetRandomCat(repository: getIt()),
  );

  getIt.registerLazySingleton<LikeCat>(
    () => LikeCat(repository: getIt()),
  );

  getIt.registerFactory<CatBloc>(() => CatBloc(
    getRandomCat : getIt(),
    likeCat: getIt() 
    ));
}
