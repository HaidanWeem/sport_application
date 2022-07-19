import 'package:either_dart/either.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';
import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, MainUser>> joinToAccount(
      String email, String password);
  Future<Either<Failure, MainUser>> signUpAccount(
      String email, String password);
  Stream<MainUser?> get currentUser;
  Future<String?> retrieveUserName(MainUser user);
  Future<void> signOut();
}
