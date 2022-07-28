import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/common/app_localizations.dart';
import 'package:sport_app/common/main_colors.dart';
import 'package:sport_app/common/theme/login_theme.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_state.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/provider/provider_auth/provider_auth.dart';
import 'package:sport_app/main_navigation.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          Navigator.of(context).pushReplacementNamed(MainNavigation.homePage);
        } else if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)
                  .translate("Something_went_wrong")!)));
        }
      },
      builder: (context, state) {
        if (state is AuthenticationIsLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 180.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is UnAuthenticated) {
          return SafeArea(
            child: Form(
              key: context.read<SignInModel>().formKeySignIn,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textWidget(),
                      const TextFieldLogin(),
                      const TextFieldPassword(),
                      const ButtonSignInWidget(),
                      const ButtonSignUpWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else
          return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget textWidget() {
    return const Center(
      child: Text(
        'SporteLite',
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) =>
            context.read<SignInModel>().validateEmail(context),
        controller: context.read<SignInModel>().login,
        decoration: InputDecoration(
          helperText: AppLocalizations.of(context).translate("Email_format")!,
          labelText: AppLocalizations.of(context).translate("Email")!,
          labelStyle: const TextStyle(
            color: MainColors.mainBlack,
          ),
          enabledBorder: LoginTheme.borderDefault,
          focusedBorder: LoginTheme.borderDefault,
          errorBorder: LoginTheme.borderError,
          focusedErrorBorder: LoginTheme.borderError,
        ),
      ),
    );
  }
}

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextFormField(
        validator: (value) =>
            context.read<SignInModel>().validatePassword(context),
        controller: context.read<SignInModel>().password,
        obscureText: context.watch<SignInModel>().isHideCharacters,
        decoration: InputDecoration(
          helperText: AppLocalizations.of(context)
              .translate("Password_must_be_8_or_more_characters")!,
          labelText: AppLocalizations.of(context).translate("Password")!,
          suffixIcon: IconButton(
            icon: Icon(context.read<SignInModel>().isHideCharacters == false
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              context.read<SignInModel>().isVisibilityPassword();
            },
            color: (context.read<SignInModel>().isHideCharacters == false
                ? Colors.red
                : Colors.grey),
          ),
          labelStyle: const TextStyle(
            color: MainColors.mainBlack,
          ),
          enabledBorder: LoginTheme.borderDefault,
          focusedBorder: LoginTheme.borderDefault,
          errorBorder: LoginTheme.borderError,
          focusedErrorBorder: LoginTheme.borderError,
        ),
      ),
    );
  }
}

class ButtonSignInWidget extends StatelessWidget {
  const ButtonSignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              MainColors.mainBlack,
            ),
            overlayColor: MaterialStateProperty.all<Color>(Colors.white10)),
        onPressed: () {
          context.read<SignInModel>().signIn(context);
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate("Get_Started")!,
              style: const TextStyle(
                color: MainColors.mainWhite,
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonSignUpWidget extends StatelessWidget {
  const ButtonSignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(MainColors.mainWhite),
            overlayColor: MaterialStateProperty.all<Color>(
              MainColors.mainBlack,
            )),
        onPressed: () {
          Navigator.of(context).pushNamed(MainNavigation.signUp);
        },
        child: Center(
          child: Text(
            AppLocalizations.of(context).translate("Sign_Up")!,
            style: const TextStyle(
              color: MainColors.mainBlack,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
