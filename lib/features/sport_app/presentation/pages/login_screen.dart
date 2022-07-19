import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/features/sport_app/presentation/provider/provider_auth/provider_auth.dart';
import 'package:sport_app/features/sport_app/presentation/widgets/login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SignInModel>(
          create: (_) => SignInModel(),
          child: LoginBodyWidget()),
    );
  }
}
