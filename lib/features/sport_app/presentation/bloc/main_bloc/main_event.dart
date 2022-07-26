import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentUser extends MainEvent {
  @override
  List<Object> get props => [];
}