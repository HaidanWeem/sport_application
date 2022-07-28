import 'package:flutter/material.dart';
import 'package:sport_app/common/app_localizations.dart';
import 'package:sport_app/features/sport_app/presentation/widgets/pofile_widget.dart';
import '../../../../common/main_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: AppBar(
            leading: IconButton(
                splashRadius: 18,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.chevron_left)),
            backgroundColor: MainColors.mainBlack,
            title: Text(
              AppLocalizations.of(context).translate("Profile")!,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            actions: [],
          ),
        ),
        body: const ProfileBody(),
      );
    
  }
}
