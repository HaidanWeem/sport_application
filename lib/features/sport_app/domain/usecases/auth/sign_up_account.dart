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
    return await authRepository.signUpAccount(params.email, params.password, params.name, params.age, params.weight);
  }

  Stream<MainUser?> get currentUser => authRepository.currentUser;
}

class RegisterParams extends Equatable {
  final String email, password, name;
  final double age,  weight;
  RegisterParams({required this.name,required this.age, required this.weight, required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
