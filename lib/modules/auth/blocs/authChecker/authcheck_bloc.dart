import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/auth/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'authcheck_event.dart';
part 'authcheck_state.dart';

class AuthcheckBloc extends Bloc<AuthcheckEvent, AuthcheckState> {
  final AuthRepo _authRepo = AuthRepo();
  AuthcheckBloc() : super(AuthcheckInitial()) {
    on<AuthcheckEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AuthCheckaAttempt>(
        (event, emit) => authenticateAttempt(event: event, emit: emit));
  }

  authenticateAttempt(
      {required AuthCheckaAttempt event,
      required Emitter<AuthcheckState> emit}) async {
    if (await _authRepo.autoAuthenticationAttempt()) {
      emit(Authenticated(message: ""));
    } else {
      emit(AuthenticationFailed(message: ""));
    }
  }
}
