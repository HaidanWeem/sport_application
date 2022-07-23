import 'package:either_dart/either.dart';
import 'package:sport_app/core/error/auth_error/auth_exception.dart';
import 'package:sport_app/core/error/auth_error/auth_failure.dart';
import 'package:sport_app/core/error/failure.dart';
import 'package:sport_app/core/platform/network_info.dart';
import 'package:sport_app/features/sport_app/data/datasources/auth_datasources/remote_datasource.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';
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
      String age, String weight) async {
    return await _formAuth(() {
      return fireBaseAuthDataSource.signUpAccount(email, password, name, age, weight);
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
      throw ServerFailure();
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