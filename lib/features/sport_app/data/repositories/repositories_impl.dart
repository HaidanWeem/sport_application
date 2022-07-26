import 'package:either_dart/either.dart';
import 'package:sport_app/core/error/auth_error/auth_exception.dart';
import 'package:sport_app/core/error/auth_error/auth_failure.dart';
import 'package:sport_app/core/error/exception.dart';
import 'package:sport_app/core/error/failure.dart';
import 'package:sport_app/core/platform/network_info.dart';
import 'package:sport_app/features/sport_app/data/datasources/auth_datasources/remote_datasource.dart';
import 'package:sport_app/features/sport_app/data/datasources/home_datasources/remote_datasource.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';
import 'package:sport_app/features/sport_app/domain/entities/user.dart';
import '../../domain/repositories/repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FireBaseAuthDataSource fireBaseAuthDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.networkInfo, required this.fireBaseAuthDataSource});

  @override
  Future<Either<Failure, MainUser>> joinToAccount(
      String email, String password) async {
    return await _formAuth(() {
      return fireBaseAuthDataSource.joinToAccount(email, password);
    });
  }

  @override
  Future<Either<Failure, MainUser>> signUpAccount(
      String email, String password, String name,
      double age, double weight, bool isMale) async {
    return await _formAuth(() {
      return fireBaseAuthDataSource.signUpAccount(email, password, name, age, weight, isMale);
    });
  }

  Future<Either<Failure, MainUser>> _formAuth(
      Future<MainUser> Function() formAuth) async {
    if (await networkInfo.IsConnected) {
      try {
        final user = await formAuth();
        return Right(user);
      } on AuthUnknownException catch (e) {
        throw AuthUnknownFailure.messageFromServer(e.toString());
      }
    } else {
      throw ServerFailure.printMessageFromServer('No internet connection');
    }
  }

  Stream<MainUser?> get currentUser => fireBaseAuthDataSource.currentUser;

  @override
  Future<String?> retrieveUserName(MainUser user) {
    return fireBaseAuthDataSource.retrieveUserName(user);
  }

  Future<void> signOut() async {
    await fireBaseAuthDataSource.signOut();
  }
}

 class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(
      {required this.homeDataSource, required this.networkInfo});

  Future<Either<Failure, CurrentUser>> getUser() async {
     if (await networkInfo.IsConnected) {
      try {
        final user = await homeDataSource.getUser();
        return Right(user);
      } on UnknownException catch (error) {
        throw UnknownFailure.printMessageFromServer(error.toString());
      }
    } else {
      throw ServerFailure.printMessageFromServer('No internet connection');
    }
  }
  }


