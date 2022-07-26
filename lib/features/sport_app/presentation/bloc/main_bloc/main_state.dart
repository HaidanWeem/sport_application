


import 'package:equatable/equatable.dart';
import 'package:sport_app/features/sport_app/domain/entities/user.dart';

abstract class MainState extends Equatable {
   @override
  List<Object?> get props => [];
}

class InitMain extends MainState {
  @override
  List<Object?> get props => [];
}


class MainIsLoading extends MainState {
  @override
  List<Object?> get props => [];
}

class MainIsLoaded extends MainState {
  final CurrentUser user;

  MainIsLoaded({required this.user});

  @override
  List<Object?> get props => [];
}
class MainUserFailure extends MainState {
  final String error;
  @override
  List<Object?> get props => [];

  MainUserFailure({required this.error}) {
    print(error);
  }
}