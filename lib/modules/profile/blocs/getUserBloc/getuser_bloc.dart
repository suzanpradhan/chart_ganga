import 'package:bloc/bloc.dart';
import 'package:chart_ganga/models/user_model.dart';
import 'package:chart_ganga/modules/auth/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'getuser_event.dart';
part 'getuser_state.dart';

class GetuserBloc extends Bloc<GetuserEvent, GetuserState> {
  AuthRepo _authRepo = AuthRepo();
  GetuserBloc() : super(GetuserInitial()) {
    on<GetuserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUserAttemptEvent>(
        (event, emit) => getUserAttemptEventMapped(event, emit));
  }

  getUserAttemptEventMapped(
      GetUserAttemptEvent event, Emitter<GetuserState> emit) async {
    try {
      emit(GetUserLoadingState());
      UserModel userModel = await _authRepo.getUser();
      emit(GetUserSuccessState(user: userModel));
    } catch (e) {
      emit(GetUserFailedState(message: e.toString()));
    }
  }
}
