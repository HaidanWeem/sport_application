import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_event.dart';

class SignInModel extends ChangeNotifier {
  final formKeySignIn = GlobalKey<FormState>();

  //Gender
  bool male = false;
  bool female = false;
  //

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

  String? validateEmail() {
    if (login.text.isEmpty) {
      return 'Email is required';
    } else if (!login.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? validatePassword() {
    if (password.text.isEmpty) {
      return 'Password is required';
    } else if (password.text.length < 8) {
      return 'Password is too short. Must be 8 characters';
    } else {
      return null;
    }
  }
}

class SignUpModel extends ChangeNotifier {
  final formKeySignUp = GlobalKey<FormState>();

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

  String? validateName() {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (name.text.isEmpty) {
      return 'Name is required';
    } else if (!_nameExp.hasMatch(name.text)) {
      return 'Please enter alphabetical characters';
    } else {
      return null;
    }
  }

  String? validateEmail() {
    if (login.text.isEmpty) {
      return 'Email is required';
    } else if (!login.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? validatePassword() {
    if (password.text.isEmpty) {
      return 'Password is required';
    } else if (password.text.length < 8) {
      return 'Password is too short. Must be 8 characters';
    } else if (password.text != confirmPassword.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }
}
