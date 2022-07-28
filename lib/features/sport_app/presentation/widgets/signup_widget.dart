import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/common/app_localizations.dart';
import 'package:sport_app/common/main_colors.dart';
import 'package:sport_app/common/theme/login_theme.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_state.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:sport_app/features/sport_app/presentation/provider/provider_auth/provider_auth.dart';
import 'package:sport_app/main_navigation.dart';

class RegistrationBodyWidget extends StatelessWidget {
  RegistrationBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationSuccess) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            MainNavigation.homePage, (Route<dynamic> route) => false);
      } else if (state is AuthenticationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)
                .translate("Registration_failure")!)));
      }
    }, builder: (context, state) {
      if (state is AuthenticationIsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is UnAuthenticated) {
        print('UnAuthenticated');
      }
      return SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: context.read<SignUpModel>().formKeySignUp,
            child: Column(
              children: const [
                TextFieldNameWidget(),
                TextFieldEmailWidget(),
                SliderAgeWidget(),
                SliderWeightWidget(),
                TextFieldPasswordWidget(),
                TextFieldConfirmPasswordWidget(),
                PickGenderWidget(),
                ButtonSignUpWidget(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SliderAgeWidget extends StatelessWidget {
  const SliderAgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            AppLocalizations.of(context).translate("Age")!,
            style: const TextStyle(
              color: MainColors.mainBlack,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Slider(
          activeColor: MainColors.mainBlack,
          max: 100,
          inactiveColor: Colors.grey,
          divisions: 100,
          label: context.watch<SignUpModel>().ageValue.round().toString(),
          value: context.watch<SignUpModel>().ageValue,
          onChanged: (double value) {
            context.read<SignUpModel>().onChangedAgeValue(value);
          },
        ),
      ],
    );
  }
}

class SliderWeightWidget extends StatelessWidget {
  const SliderWeightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            AppLocalizations.of(context).translate("Weight")!,
            style: const TextStyle(
              color: MainColors.mainBlack,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Slider(
          activeColor: MainColors.mainBlack,
          max: 200,
          inactiveColor: Colors.grey,
          divisions: 200,
          label: context.watch<SignUpModel>().weightValue.round().toString(),
          value: context.watch<SignUpModel>().weightValue,
          onChanged: (double value) {
            context.read<SignUpModel>().onChangedWeightValue(value);
          },
        ),
      ],
    );
  }
}

class TextFieldNameWidget extends StatelessWidget {
  const TextFieldNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 18.0, bottom: 18, left: 24, right: 24),
      child: TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        validator: (value) => context.read<SignUpModel>().validateName(context),
        controller: context.read<SignUpModel>().name,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate("Name")!,
          labelStyle: const TextStyle(color: MainColors.mainBlack),
          enabledBorder: LoginTheme.borderDefault,
          focusedBorder: LoginTheme.borderDefault,
          errorBorder: LoginTheme.borderError,
          focusedErrorBorder: LoginTheme.borderError,
        ),
      ),
    );
  }
}

class TextFieldEmailWidget extends StatelessWidget {
  const TextFieldEmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 18.0, bottom: 18, left: 24, right: 24),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) =>
            context.read<SignUpModel>().validateEmail(context),
        controller: context.read<SignUpModel>().login,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.blueGrey,
          ),
          suffixIcon: IconButton(
            onPressed: () => context.read<SignUpModel>().deleteEmailField(),
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
          labelText: AppLocalizations.of(context).translate("Email"),
          labelStyle: const TextStyle(color: MainColors.mainBlack),
          helperText: AppLocalizations.of(context).translate("Email_format"),
          helperStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: LoginTheme.borderDefault,
          focusedBorder: LoginTheme.borderDefault,
          errorBorder: LoginTheme.borderError,
          focusedErrorBorder: LoginTheme.borderError,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class TextFieldPasswordWidget extends StatelessWidget {
  const TextFieldPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 18.0, bottom: 18, left: 24, right: 24),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) =>
            context.read<SignUpModel>().validatePassword(context),
        obscureText: context.watch<SignUpModel>().isHideCharacters,
        controller: context.read<SignUpModel>().password,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.password,
            color: Colors.blueGrey,
          ),
          suffixIcon: IconButton(
            icon: Icon(context.read<SignUpModel>().isHideCharacters == false
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              context.read<SignUpModel>().isVisibilityPassword();
            },
            color: (context.read<SignUpModel>().isHideCharacters == false
                ? Colors.red
                : Colors.grey),
          ),
          labelText: AppLocalizations.of(context).translate("Password"),
          labelStyle: const TextStyle(color: MainColors.mainBlack),
          helperText: AppLocalizations.of(context)
              .translate("Password_must_be_8_or_more_characters"),
          enabledBorder: LoginTheme.borderDefault,
          focusedBorder: LoginTheme.borderDefault,
          errorBorder: LoginTheme.borderError,
          focusedErrorBorder: LoginTheme.borderError,
        ),
      ),
    );
  }
}

class TextFieldConfirmPasswordWidget extends StatelessWidget {
  const TextFieldConfirmPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 18.0, bottom: 18, left: 24, right: 24),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        validator: (value) =>
            context.read<SignUpModel>().validatePassword(context),
        obscureText: context.watch<SignUpModel>().isHideCharacters,
        controller: context.read<SignUpModel>().confirmPassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.password,
            color: Colors.blueGrey,
          ),
          labelText: AppLocalizations.of(context).translate("Confirm_Password"),
          labelStyle: const TextStyle(color: MainColors.mainBlack),
          enabledBorder: LoginTheme.borderDefault,
          focusedBorder: LoginTheme.borderDefault,
          errorBorder: LoginTheme.borderError,
          focusedErrorBorder: LoginTheme.borderError,
        ),
      ),
    );
  }
}

class PickGenderWidget extends StatelessWidget {
  const PickGenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        // MALE
        Expanded(
          child: Consumer<SignUpModel>(
            builder: (context, genderProvider, _) => GestureDetector(
              onTap: () {
                genderProvider.isMale = true;
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: genderProvider.maleColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("Male")!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: genderProvider.maleColor,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Consumer<SignUpModel>(
            builder: (context, genderProvider, _) => GestureDetector(
              onTap: () {
                genderProvider.isMale = false;
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: genderProvider.femaleColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("Female")!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: genderProvider.femaleColor,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}

class ButtonSignUpWidget extends StatelessWidget {
  const ButtonSignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 18.0, bottom: 18, left: 24, right: 24),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(MainColors.mainBlack),
            overlayColor: MaterialStateProperty.all<Color>(Colors.white10)),
        onPressed: () {
          context.read<SignUpModel>().signUp(context);
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate("Get_Started")!,
              style: const TextStyle(
                  color: MainColors.mainWhite,
                  fontFamily: 'Poppins',
                  fontSize: 18,),
            ),
          ),
        ),
      ),
    );
  }
}
