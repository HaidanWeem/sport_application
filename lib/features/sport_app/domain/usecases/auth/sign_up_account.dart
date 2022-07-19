import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_app/core/usecases/usecases.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/repositories.dart';

class SignUpAccount extends UseCase<void, RegisterParams> {
  final AuthRepository authRepository;

  SignUpAccount(this.authRepository);

  Future<Either<Failure, MainUser>> call(RegisterParams params) async {
    return await authRepository.signUpAccount(params.email, params.password);
  }
}

class RegisterParams extends Equatable {
  final String email, password;
  RegisterParams({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
