import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/common/app_localizations.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_event.dart';

class SignInModel extends ChangeNotifier {
  final formKeySignIn = GlobalKey<FormState>();

  

  bool isHideCharacters = true;
  final login = TextEditingController();
  final password = TextEditingController();

  void signIn(BuildContext context) {
    if (formKeySignIn.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(SignInStarted(login.text, password.text));
    }
  }

  void isVisibilityPassword() {
    isHideCharacters = !isHideCharacters;
    notifyListeners();
  }

  String? validateEmail(BuildContext context) {
    if (login.text.isEmpty) {
      return AppLocalizations.of(context).translate("Email_is_required");
    } else if (!login.text.contains('@')) {
      return AppLocalizations.of(context).translate("Invalid_email_address");
    } else {
      return null;
    }
  }

  String? validatePassword(BuildContext context) {
    if (password.text.isEmpty) {
      return AppLocalizations.of(context).translate("Password_is_required");
    } else if (password.text.length < 8) {
      return  AppLocalizations.of(context).translate("Password_is_too_short._Must_be_8_characters");
    } else {
      return null;
    }
  }
}

class SignUpModel extends ChangeNotifier {
  final formKeySignUp = GlobalKey<FormState>();

  //Gender
  bool _isMale = true;

  bool get isMale => this._isMale;

  set isMale(bool value) {
    this._isMale = value;
    notifyListeners();
  }

  get color => _isMale ? Colors.blue : Colors.pink;
  get maleColor => _isMale ? Colors.blue : Colors.grey;
  get femaleColor => _isMale ? Colors.grey : Colors.pink;
  //

  double ageValue = 1;
  double weightValue = 1.0;

  bool isHideCharacters = true;
  final name = TextEditingController();
  final login = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void signUp(BuildContext context) {
    if (formKeySignUp.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignUpStarted(
          login.text,
          password.text,
          name.text,
          ageValue,
          weightValue,
          _isMale,
        ),
      );
    }
  }

  void onChangedAgeValue(double value) {
    ageValue = value;
    notifyListeners();
  }

  void onChangedWeightValue(double value) {
    weightValue = value;
    notifyListeners();
  }

  void isVisibilityPassword() {
    isHideCharacters = !isHideCharacters;
    notifyListeners();
  }

  void deleteEmailField() {
    if (login.text != '') {
      login.text = '';
      notifyListeners();
    }
  }

  String? validateName(BuildContext context) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (name.text.isEmpty) {
      return AppLocalizations.of(context).translate("Name_is_required");
    } else if (!_nameExp.hasMatch(name.text)) {
      return AppLocalizations.of(context).translate("Please_enter_alphabetical_characters");
    } else {
      return null;
    }
  }

  String? validateEmail(BuildContext context) {
    if (login.text.isEmpty) {
      return AppLocalizations.of(context).translate("Email_is_required");
    } else if (!login.text.contains('@')) {
      return AppLocalizations.of(context).translate("Invalid_email_address");
    } else {
      return null;
    }
  }

  String? validatePassword(BuildContext context) {
    if (password.text.isEmpty) {
      return AppLocalizations.of(context).translate("Password_is_required");
    } else if (password.text.length < 8) {
      return AppLocalizations.of(context).translate("Password_is_too_short._Must_be_8_characters");
    } else if (password.text != confirmPassword.text) {
      return AppLocalizations.of(context).translate("Password_does_not_match");
    } else {
      return null;
    }
  }
}
