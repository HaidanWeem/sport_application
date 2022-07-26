import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/common/main_colors.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_state.dart';
import 'package:sport_app/features/sport_app/presentation/provider/provider_home/provider_home.dart';

import '../../../../main_navigation.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MainBloc>(context).add(GetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainUserFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Unknown User')));
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationSignOut());

          Navigator.of(context).pushNamedAndRemoveUntil(
              MainNavigation.auth, (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        if (state is MainIsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MainIsLoaded) {
          context.read<Home>().user = state.user;
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  
                },
                child: Icon(Icons.menu_rounded),
              ),
              backgroundColor: MainColors.mainBlack,
              title: Text(
                'SportleLite',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(26),
                ),
              ),
              actions: [AppBarProfileButtonWidget()],
            ),
            body: TextHelloWidget(),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class AppBarProfileButtonWidget extends StatelessWidget {
  const AppBarProfileButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        backgroundColor: MainColors.mainWhite,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(MainNavigation.profile);
            },
            splashColor: Colors.white10,
            child: Icon(
              Icons.person,
              color: MainColors.mainBlack,
            ),
          ),
        ),
      ),
    );
  }
}

class TextHelloWidget extends StatelessWidget {
  TextHelloWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<Home>().user;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, ' + user.name,
                style: TextStyle(fontSize: 30, fontFamily: 'Poppins')),
          ],
        ),
      ),
    );
  }
}
