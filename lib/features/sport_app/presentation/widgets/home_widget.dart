import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/common/main_colors.dart';
import 'package:sport_app/common/main_images.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_state.dart';
import 'package:sport_app/features/sport_app/presentation/elements/home_elements.dart';
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
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Unknown User')));
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
            drawer: Drawer(
              child: SelectDropList(
                context.read<Home>().optionItemSelected,
                context.read<Home>().dropListModel,
                (optionItem) 
                  => context.watch<Home>().choseLanguage(optionItem),
              ),
            ),
            appBar: AppBar(
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHelloWidget(),
                LevelsSport(),
              ],
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class LevelsSport extends StatelessWidget {
  const LevelsSport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          right: 16,
          left: 16,
        ),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: 3,
          itemExtent: 180,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Stack(children: [
                  Ink.image(
                    image: AssetImage('asset/images/levelsport.jpg'),
                    fit: BoxFit.cover,
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                  Center(
                    child: Text(
                      'Beginner',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MainColors.mainWhite,
                          fontSize: 24,
                          fontFamily: 'Poppins'),
                    ),
                  )
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppBarProfileButtonWidget extends StatelessWidget {
  const AppBarProfileButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gender = context.read<Home>().user.isMale == true
        ? MainImages.mainMan
        : MainImages.mainWomen;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        foregroundImage: AssetImage(gender),
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, ' + user.name + '!',
                style: TextStyle(fontSize: 26, fontFamily: 'Poppins')),
            Text('Chose what type of training you want',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Poppins', color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black, width: 2),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           )
//                         ]),
//                     clipBehavior: Clip.hardEdge,
//                     child: Row(
//                       children: [
//                         Image(image: AssetImage(MainImages.mainMan)),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 16),
//                               Text(
//                                 'dd',
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 15),
//                               ),
//                               const SizedBox(height: 5),
//                               Text('dd',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w500)),
//                               const SizedBox(height: 5),
//                               Text(
//                                 'dd',
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontFamily: 'Raleway',
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               const SizedBox(height: 18),
//                               Text(
//                                 'dd',
//                                 style: const TextStyle(
//                                     fontFamily: 'Raleway',
//                                     fontWeight: FontWeight.w600),
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(10),
//                       onTap: () => {},
//                     ),
//                   )
//                 ],
//               ),
//             );
