import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/features/sport_app/domain/usecases/auth/join_to_account.dart';
import 'package:sport_app/features/sport_app/domain/usecases/auth/sign_up_account.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/login_bloc/auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final JoinToAccount joinToAccount;
  final SignUpAccount signUpAccount;

  AuthenticationBloc({required this.joinToAccount, required this.signUpAccount})
      : super(UnAuthenticated()) {
    on<SignInStarted>(
      (event, emit) async {
        emit(AuthenticationIsLoading());
        try {
          await joinToAccount
              .call(AuthParams(email: event.email, password: event.password));
          emit(AuthenticationSuccess());
        } catch (e) {
          emit(AuthenticationFailure(error: e.toString()));
          emit(UnAuthenticated());
        }
      },
    );
    on<SignUpStarted>((event, emit) async {
      emit(AuthenticationIsLoading());
      try {
        await signUpAccount.call(RegisterParams(
          email: event.email,
          password: event.password,
          name: event.name,
          age: event.age,
          weight: event.weight,
        ));
        emit(AuthenticationSuccess());
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<AuthenticationSignOut>(
      (event, emit) async {
        emit(AuthenticationIsLoading());
        await joinToAccount.signOut();
        emit(UnAuthenticated());
      },
    );
  }
}
