import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_event.dart';
import 'package:sport_app/main_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello world'),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationSignOut());
              Navigator.of(context).pushNamedAndRemoveUntil(
                  MainNavigation.auth, (Route<dynamic> route) => false);
            },
            child: Icon(
              Icons.quiz_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
