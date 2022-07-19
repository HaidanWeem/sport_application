import 'package:sport_app/core/error/failure.dart';

class LoginInUseException extends Failure {}

class InvalidEmailException extends Failure {}

class UserNotFoundException extends Failure {}

class InvalidPasswordException extends Failure {}

class AuthUnknownException extends Failure {}