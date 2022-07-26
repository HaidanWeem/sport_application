import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure{
  final String message;
  ServerFailure.printMessageFromServer(this.message) {
    print(message);
  }
}

class CacheFailure extends Failure {}


class UnknownFailure extends Failure{
  final String message;
  UnknownFailure.printMessageFromServer(this.message) {
    print(message);
  }
}
