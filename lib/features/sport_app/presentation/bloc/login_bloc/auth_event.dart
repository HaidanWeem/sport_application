import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInStarted extends AuthenticationEvent {
  final String email;
  final String password;

  SignInStarted(this.email, this.password);
  @override
  List<Object> get props => [];
}

class SignUpStarted extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  final double age;
  final double weight;
  final bool isMale;

  SignUpStarted(this.email, this.password, this.name, this.age, this.weight, this.isMale);
  @override
  List<Object> get props => [];
}

class AuthenticationSignOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
