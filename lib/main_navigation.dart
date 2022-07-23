import 'package:flutter/material.dart';
import 'package:sport_app/features/sport_app/domain/entities/user.dart';
import 'package:sport_app/features/sport_app/presentation/pages/home_screen.dart';
import 'package:sport_app/features/sport_app/presentation/pages/login_screen.dart';
import 'package:sport_app/features/sport_app/presentation/pages/registration_screen.dart';

abstract class MainNavigation {
  static const String auth = 'auth';
  static const String signUp = 'signUp';
  static const String homePage = 'homePage';
}

class MainRoutes {
  final initialRoute = MainNavigation.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigation.auth: (context) => const LoginScreen(),
    MainNavigation.signUp: (context) => const RegistrationScreen(),
    MainNavigation.homePage: (context) => const HomeScreen(),
  };

}


