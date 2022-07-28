import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/common/app_localizations.dart';
import 'package:sport_app/common/main_colors.dart';
import 'package:sport_app/common/main_images.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_state.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_state.dart';
import 'package:sport_app/main_navigation.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MainBloc>(context).add(GetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<MainBloc, MainState>(listener: (context, state) {
      if (state is MainUserFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(  SnackBar(content: Text(AppLocalizations.of(context).translate("Unknown_User")!)));
      } else if (state is UnAuthenticated) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            MainNavigation.auth, (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      if (state is MainIsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MainIsLoaded) {
        final gender = state.user.isMale == true
            ? MainImages.mainMan
            : MainImages.mainWomen;
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Center(
                child: Container(
                  height: height * 0.50,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: innerHeight * 0.72,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(65),
                                color: MainColors.mainBlack,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 118, 118, 118)
                                        .withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(3, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                 const SizedBox(
                                    height: 80,
                                  ),
                                  Text(
                                    state.user.name,
                                    style: const TextStyle(
                                      color: MainColors.mainWhite,
                                      fontFamily: 'Poppins',
                                      fontSize: 37,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                 const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate("Age")!,
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontFamily: 'Poppins',
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            state.user.age.round().toString(),
                                            style: const TextStyle(
                                              color: MainColors.mainWhite,
                                              fontFamily: 'Poppins',
                                              fontSize: 25,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 8,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate("Weight")!,
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontFamily: 'Poppins',
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            state.user.weight
                                                .round()
                                                .toString(),
                                            style: const TextStyle(
                                              color: MainColors.mainWhite,
                                              fontFamily: 'Poppins',
                                              fontSize: 25,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                child: Image.asset(
                                  gender,
                                  width: innerWidth * 0.45,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: height * 0.1,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(65),
                    color: MainColors.mainBlack,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 71, 71, 71).withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(3, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context).translate("Email")!,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontFamily: 'Poppins',
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          state.user.email.toString(),
                          style:  const TextStyle(
                            color: MainColors.mainWhite,
                            fontFamily: 'Poppins',
                            fontSize: 25,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: height * 0.1,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(65),
                    color: MainColors.mainBlack,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 71, 71, 71).withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(3, 5),
                      ),
                    ],
                  ),
                  child: IconButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AuthenticationSignOut());
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            MainNavigation.auth,
                            (Route<dynamic> route) => false);
                      },
                      icon: const Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ),
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
