import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/core/error/failure.dart';
import 'package:sport_app/features/sport_app/domain/usecases/home_page/get_current_user.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_event.dart';
import 'package:sport_app/features/sport_app/presentation/bloc/main_bloc/main_state.dart';

const SERVER_FAILURE_ERROR = 'Server Failure';
const UNKNOWN_FAILURE_ERROR = 'Unknown Failure';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetUser getCurrentUser;

  MainBloc({required this.getCurrentUser})
      : super(InitMain()) {
        
    _mapFailureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return SERVER_FAILURE_ERROR;
        case UnknownFailure:
          return UNKNOWN_FAILURE_ERROR;
        default:
          return 'Unexpected Error';
      }
    }

    on<GetCurrentUser>(
      (event, emit) async {
        emit(MainIsLoading());
        try {
          final currentUser = await getCurrentUser.call(GetUserParams());
          currentUser.fold(
              (failure) =>
                  emit(MainUserFailure(error: _mapFailureToMessage(failure))),
              (user) => emit(MainIsLoaded(user: user)));
        } catch (e) {
          emit(MainUserFailure(error: e.toString()));
          emit(InitMain());
        }
      },
    );
  }
}
