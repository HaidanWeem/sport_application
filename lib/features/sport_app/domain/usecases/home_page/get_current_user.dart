import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_app/core/usecases/usecases.dart';
import 'package:sport_app/features/sport_app/domain/entities/user.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/repositories.dart';

class GetUser extends UseCase<void, GetUserParams> {
  final HomeRepository homeRepository;

  GetUser(this.homeRepository);

  Future<Either<Failure, CurrentUser>> call(GetUserParams params) async {
    return await homeRepository.getUser();
  }
}

class GetUserParams extends Equatable {

  @override
  List<Object> get props => [];
}
