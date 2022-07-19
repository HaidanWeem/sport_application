import 'package:equatable/equatable.dart';
import 'package:sport_app/core/error/auth_error/auth_failure.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationIsLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String? displayName;
  const AuthenticationSuccess({this.displayName});

  @override
  List<Object?> get props => [displayName];
}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure({required this.error}) {
    print(error);
  }

  @override
  List<Object?> get props => [error];
}
