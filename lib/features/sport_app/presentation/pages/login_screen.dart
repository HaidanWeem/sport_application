import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/provider/provider_auth/provider_auth.dart';
import 'package:sport_app/features/sport_app/presentation/widgets/login_widget.dart';
import 'package:sport_app/locator_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => sl<AuthenticationBloc>(),
      child: Scaffold(
        body: ChangeNotifierProvider<SignInModel>(
            create: (_) => SignInModel(),
            child: const LoginBodyWidget()),
      ),
    );
  }
}
