import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        Navigator.of(context).pushNamedAndRemoveUntil(MainNavigation.homePage,(Route<dynamic> route) => false);
      } else if (state is AuthenticationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong: Registration failure')));
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
              children: [
                TextFieldNameWidget(),
                TextFieldEmailWidget(),
                SliderAgeWidget(),
                SliderWeightWidget(),
                TextFieldPasswordWidget(),
                TextFieldConfirmPasswordWidget(),
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
            'Age',
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Slider(
          activeColor: Colors.black,
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
            'Weight',
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Slider(
          activeColor: Colors.black,
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
      padding: const EdgeInsets.all(24.0),
      child: TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        validator: (value) => context.read<SignUpModel>().validateName(),
        controller: context.read<SignUpModel>().name,
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle: TextStyle(color: Colors.black),
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
      padding: const EdgeInsets.all(24.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) => context.read<SignUpModel>().validateEmail(),
        controller: context.read<SignUpModel>().login,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blueGrey,
          ),
          suffixIcon: IconButton(
            onPressed: () => context.read<SignUpModel>().deleteEmailField(),
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.black),
          helperText: 'Email format: test@test.com',
          helperStyle: TextStyle(
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
      padding: const EdgeInsets.all(24.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) => context.read<SignUpModel>().validatePassword(),
        obscureText: context.watch<SignUpModel>().isHideCharacters,
        controller: context.read<SignUpModel>().password,
        decoration: InputDecoration(
          prefixIcon: Icon(
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
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black),
          helperText: 'Password must be 8 or more characters',
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
      padding: const EdgeInsets.all(24.0),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        validator: (value) => context.read<SignUpModel>().validatePassword(),
        obscureText: context.watch<SignUpModel>().isHideCharacters,
        controller: context.read<SignUpModel>().confirmPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.password,
            color: Colors.blueGrey,
          ),
          labelText: 'Confirm Password',
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: LoginTheme.borderDefault,
          focusedBorder: LoginTheme.borderDefault,
          errorBorder: LoginTheme.borderError,
          focusedErrorBorder: LoginTheme.borderError,
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
      padding: const EdgeInsets.all(24.0),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.white10)),
        onPressed: () {
          context.read<SignUpModel>().signUp(context);
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              'Get Started!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
