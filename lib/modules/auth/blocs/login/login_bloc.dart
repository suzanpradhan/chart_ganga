import 'package:bloc/bloc.dart';
import 'package:chart_ganga/models/user_model.dart';
import 'package:chart_ganga/modules/auth/repos/auth_repo.dart';
import 'package:chart_ganga/modules/auth/services/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TextEditingController usernameController;
  final TextEditingController passowrdController;
  final AuthRepo _authRepo = AuthRepo();

  LoginBloc(
      {required this.passowrdController, required this.usernameController})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<UsernameValidate>((event, emit) => validateUsername(
        username: event.username, errorState: event.errorState, emit: emit));
    on<PasswordValidate>((event, emit) => validatePassword(
        password: event.password, errorState: event.errorState, emit: emit));
    on<LoginFormSubmit>(
        (event, emit) => attemptLogin(userModel: event.userModel, emit: emit));
  }

  validateUsername(
      {String? username,
      LoginFormErrorState? errorState,
      required Emitter<LoginState> emit}) {
    if (username == null || username == "") {
      emit(LoginFormErrorState(
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must have at least 8 characters."));
    } else if (username.contains(" ")) {
      emit(LoginFormErrorState(
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username should not have spaces."));
    } else if (username.startsWith(RegExp(r'[A-Z]'))) {
      emit(LoginFormErrorState(
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must start with lowercase."));
    } else if (username.startsWith(RegExp(r'[0-9]'))) {
      emit(LoginFormErrorState(
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must start with a alphabet."));
    } else if (username.length < 8) {
      emit(LoginFormErrorState(
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must have at least 8 characters."));
    } else {
      if (errorState != null) {
        if (errorState.passwordError == null &&
            usernameController.text != "" &&
            passowrdController.text != "") {
          emit(LoginFormValidated());
        } else {
          emit(LoginFormErrorState(
              passwordError: errorState.passwordError, usernameError: null));
        }
      } else if (usernameController.text != "" &&
          passowrdController.text != "") {
        emit(LoginFormValidated());
      }
    }
  }

  validatePassword(
      {String? password,
      LoginFormErrorState? errorState,
      required Emitter<LoginState> emit}) {
    if (password == null || password == "" || password.length < 6) {
      emit(LoginFormErrorState(
          usernameError: (errorState != null) ? errorState.usernameError : null,
          passwordError: "Password must have at least 6 characters."));
    } else {
      if (errorState != null) {
        if (errorState.usernameError == null &&
            usernameController.text != "" &&
            passowrdController.text != "") {
          emit(LoginFormValidated());
        } else {
          emit(LoginFormErrorState(
              usernameError: errorState.usernameError, passwordError: null));
        }
      } else if (usernameController.text != "" &&
          passowrdController.text != "") {
        emit(LoginFormValidated());
      }
    }
  }

  attemptLogin(
      {required UserModel userModel, required Emitter<LoginState> emit}) async {
    emit(LoginAttemptLoadingState());
    try {
      UserModel userWithToken =
          await _authRepo.loginService(userModel: userModel);
      if (userWithToken.accessToken != null) {
        final isSavedTokenLocally = await SecureStorage()
            .storeTokenLocally(token: userWithToken.accessToken!);
        emit(const UserLoggedInState(message: "Logged in successfully."));
      } else {
        emit(UserLoggedInFailedState(message: "Server Error!"));
      }
    } catch (e) {
      print("here");
      emit(UserLoggedInFailedState(message: e.toString()));
      emit(LoginFormValidated());
    }
  }
}
