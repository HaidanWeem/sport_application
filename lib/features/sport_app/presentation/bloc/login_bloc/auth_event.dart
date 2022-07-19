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

  SignUpStarted(this.email, this.password);
  @override
  List<Object> get props => [];
}

class AuthenticationSignedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}