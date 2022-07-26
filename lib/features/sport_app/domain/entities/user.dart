import 'package:equatable/equatable.dart';

class CurrentUser extends Equatable {
  final String name;
  final String email;
  final double age;
  final double weight;
  final bool isMale;

  CurrentUser({
    required this.isMale,
    required this.name,
    required this.email,
    required this.age,
    required this.weight,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
      name: json["Name"],
      email: json["Email"],
      age: json["Age"],
      weight: json["Weight"],
      isMale: json["IsMale"],
      );

  @override
  List<Object?> get props => [name, email, age, weight];
}
