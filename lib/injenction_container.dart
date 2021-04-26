import 'package:get_it/get_it.dart';
import 'package:hagglex/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:hagglex/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:hagglex/feature/auth/domain/repository/auth_repository.dart';
import 'package:hagglex/feature/auth/presantation/cubit/login_cubit.dart';

import 'feature/auth/domain/usecases/login.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => LoginCubit(login: sl()));

  // Use cases
  sl.registerLazySingleton(() => Login(authRepository: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  //! External Service
  // sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
