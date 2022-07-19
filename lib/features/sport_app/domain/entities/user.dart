import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final int age;
  final int weight;

  User({
    required this.name,
    required this.email,
    required this.age,
    required this.weight,
  });

  @override
  List<Object?> get props => [name, email, age, weight];
}
