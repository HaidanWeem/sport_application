import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/provider/provider_home/provider_home.dart';
import 'package:sport_app/features/sport_app/presentation/widgets/home_widget.dart';
import 'package:sport_app/locator_service.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (context) => sl<MainBloc>()),
      ],
      child: ChangeNotifierProvider<Home>(
        create: (context) => Home(),
        child: const HomeScreenBody()),
    );
  }
}

