import 'package:sport_app/core/error/failure.dart';

class AuthServerFailure extends Failure {
  final String message;

  AuthServerFailure.printMessageFromServer(this.message) {
    print(message);
  }

  // AuthServerFailure(this.message) {
  //   getMessageError();
  // }

  // Widget getMessageError() {
  //   return Text(message);
  // }
}

class AuthCacheFailure extends Failure {}

class AuthUnknownFailure extends Failure {
  final String message;

  AuthUnknownFailure.messageFromServer(this.message) {
    print(message);
  }
}
