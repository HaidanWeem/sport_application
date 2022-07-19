import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sport_app/core/platform/network_info.dart';
import 'package:sport_app/features/sport_app/data/datasources/auth_datasources/remote_datasource.dart';
import 'package:sport_app/features/sport_app/data/repositories/repositories_impl.dart';
import 'package:sport_app/features/sport_app/domain/repositories/repositories.dart';
import 'package:sport_app/features/sport_app/domain/usecases/auth/join_to_account.dart';
import 'package:sport_app/features/sport_app/domain/usecases/auth/sign_up_account.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
      () => AuthenticationBloc(joinToAccount: sl(), signUpAccount: sl()));

  // Usecases
  sl.registerLazySingleton(() => JoinToAccount(sl()));

  sl.registerLazySingleton(() => SignUpAccount(sl()));

  // Repository

  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: sl(), fireBaseAuthDataSource: sl()));

  sl.registerLazySingleton<FireBaseAuthDataSource>(
      () => FireBaseAuthDataSourceImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
