import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/widgets/pofile_widget.dart';
import 'package:sport_app/locator_service.dart';

import '../../../../common/main_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            leading: IconButton(
                splashRadius: 18,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.chevron_left)),
            backgroundColor: MainColors.mainBlack,
            title: Text(
              'Profile',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            actions: [],
          ),
        ),
        body: ProfileBody(),
      );
    
  }
}
