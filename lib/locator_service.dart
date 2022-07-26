import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sport_app/core/platform/network_info.dart';
import 'package:sport_app/features/sport_app/data/datasources/auth_datasources/remote_datasource.dart';
import 'package:sport_app/features/sport_app/data/datasources/home_datasources/remote_datasource.dart';
import 'package:sport_app/features/sport_app/data/repositories/repositories_impl.dart';
import 'package:sport_app/features/sport_app/domain/repositories/repositories.dart';
import 'package:sport_app/features/sport_app/domain/usecases/auth/join_to_account.dart';
import 'package:sport_app/features/sport_app/domain/usecases/auth/sign_up_account.dart';
import 'package:sport_app/features/sport_app/domain/usecases/home_page/get_current_user.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
      () => AuthenticationBloc(joinToAccount: sl(), signUpAccount: sl()));
  
  sl.registerFactory(
      () => MainBloc(getCurrentUser: sl()));

  // Usecases
  sl.registerLazySingleton(() => JoinToAccount(sl()));

  sl.registerLazySingleton(() => SignUpAccount(sl()));

  sl.registerLazySingleton(() => GetUser(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: sl(), fireBaseAuthDataSource: sl()));

  sl.registerLazySingleton<HomeRepository>(() =>
      HomeRepositoryImpl(networkInfo: sl(), homeDataSource: sl()));

  sl.registerLazySingleton<FireBaseAuthDataSource>(
      () => FireBaseAuthDataSourceImpl());

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
