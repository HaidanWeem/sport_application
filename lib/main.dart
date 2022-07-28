import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/common/app_localizations.dart';
import 'package:sport_app/common/main_colors.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/pages/home_screen.dart';
import 'package:sport_app/features/sport_app/presentation/pages/login_screen.dart';
import 'package:sport_app/locator_service.dart';
import 'package:sport_app/main_navigation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigation = MainRoutes();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) => sl<AuthenticationBloc>()),
        BlocProvider<MainBloc>(create: (context) => sl<MainBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SporteLite',
        theme: ThemeData(
          scaffoldBackgroundColor: MainColors.mainWhite,
        ),
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ua', 'UA'),
          const Locale('ru', 'RU')
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
        routes: navigation.routes,
      ),
    );
  }
}
