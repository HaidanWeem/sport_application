import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_app/core/usecases/usecases.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/repositories.dart';

class JoinToAccount extends UseCase<void, AuthParams> {
  final AuthRepository authRepository;

  JoinToAccount(this.authRepository);

  Future<Either<Failure, MainUser>> call(AuthParams params) async {
    return await authRepository.joinToAccount(params.email, params.password);
  }

  Stream<MainUser?> get currentUser => authRepository.currentUser;

  Future<String?> retrieveUserName(MainUser user) {
    return authRepository.retrieveUserName(user);
  }

  Future<void> signOut() async {
    await authRepository.signOut();
  }
}

class AuthParams extends Equatable {
  final String email, password;

  AuthParams({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
