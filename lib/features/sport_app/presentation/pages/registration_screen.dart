import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/common/app_localizations.dart';
import 'package:sport_app/features/sport_app/presentation/provider/provider_auth/provider_auth.dart';
import 'package:sport_app/features/sport_app/presentation/widgets/signup_widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        title: Text(
          AppLocalizations.of(context).translate("Sign_Up")!,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<SignUpModel>(
          create: (_) => SignUpModel(), child: RegistrationBodyWidget()),
    );
  }
}
