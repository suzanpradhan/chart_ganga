import 'package:bloc/bloc.dart';
import 'package:chart_ganga/models/user_model.dart';
import 'package:chart_ganga/modules/auth/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final TextEditingController usernameController;
  final TextEditingController passowrdController;
  final TextEditingController emailController;
  final AuthRepo _authRepo = AuthRepo();
  RegisterBloc(
      {required this.emailController,
      required this.passowrdController,
      required this.usernameController})
      : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<UsernameValidate>((event, emit) => validateUsername(
        emit: emit, username: event.username, errorState: event.errorState));
    on<EmailValidate>((event, emit) => validateEmailAddress(
        emit: emit,
        emailAddress: event.emailAddress,
        errorState: event.errorState));
    on<PasswordValidate>((event, emit) => validatePassword(
        emit: emit, password: event.password, errorState: event.errorState));
    on<RegisterFormSubmitted>((event, emit) =>
        attemptRegister(emit: emit, userModel: event.userModel));
  }

  validateUsername(
      {String? username,
      RegisterFormErrorState? errorState,
      required Emitter<RegisterState> emit}) {
    if (username == null || username == "") {
      emit(RegisterFormErrorState(
          emailAddressError:
              (errorState != null) ? errorState.emailAddressError : null,
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must have at least 8 characters."));
    } else if (username.contains(" ")) {
      emit(RegisterFormErrorState(
          emailAddressError:
              (errorState != null) ? errorState.emailAddressError : null,
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username should not have spaces."));
    } else if (username.startsWith(RegExp(r'[A-Z]'))) {
      emit(RegisterFormErrorState(
          emailAddressError:
              (errorState != null) ? errorState.emailAddressError : null,
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must start with lowercase."));
    } else if (username.startsWith(RegExp(r'[0-9]'))) {
      emit(RegisterFormErrorState(
          emailAddressError:
              (errorState != null) ? errorState.emailAddressError : null,
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must start with a alphabet."));
    } else if (username.length < 8) {
      emit(RegisterFormErrorState(
          emailAddressError:
              (errorState != null) ? errorState.emailAddressError : null,
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: "Username must have at least 8 characters."));
    } else {
      if (errorState != null) {
        if (errorState.passwordError == null &&
            errorState.emailAddressError == null &&
            usernameController.text != "" &&
            passowrdController.text != "") {
          emit(RegisterFormValidated());
        } else {
          emit(RegisterFormErrorState(
              emailAddressError: errorState.emailAddressError,
              passwordError: errorState.passwordError,
              usernameError: null));
        }
      } else if (usernameController.text != "" &&
          emailController.text != "" &&
          passowrdController.text != "") {
        emit(RegisterFormValidated());
      }
    }
  }

  validateEmailAddress(
      {String? emailAddress,
      RegisterFormErrorState? errorState,
      required Emitter<RegisterState> emit}) {
    if (emailAddress == null ||
        emailAddress == "" ||
        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(emailAddress)) {
      emit(RegisterFormErrorState(
          passwordError: (errorState != null) ? errorState.passwordError : null,
          usernameError: (errorState != null) ? errorState.usernameError : null,
          emailAddressError: "Enter a valid email address."));
    } else {
      if (errorState != null) {
        if (errorState.usernameError == null &&
            errorState.passwordError == null &&
            usernameController.text != "" &&
            passowrdController.text != "") {
          emit(RegisterFormValidated());
        } else {
          emit(RegisterFormErrorState(
              passwordError: errorState.passwordError,
              usernameError: errorState.usernameError,
              emailAddressError: null));
        }
      } else if (usernameController.text != "" &&
          emailController.text != "" &&
          passowrdController.text != "") {
        emit(RegisterFormValidated());
      }
    }
  }

  validatePassword(
      {String? password,
      RegisterFormErrorState? errorState,
      required Emitter<RegisterState> emit}) {
    if (password == null || password == "" || password.length < 6) {
      emit(RegisterFormErrorState(
          emailAddressError:
              (errorState != null) ? errorState.emailAddressError : null,
          usernameError: (errorState != null) ? errorState.usernameError : null,
          passwordError: "Password must have at least 6 characters."));
    } else {
      if (errorState != null) {
        if (errorState.usernameError == null &&
            errorState.emailAddressError == null &&
            usernameController.text != "" &&
            passowrdController.text != "") {
          emit(RegisterFormValidated());
        } else {
          emit(RegisterFormErrorState(
              emailAddressError: errorState.emailAddressError,
              usernameError: errorState.usernameError,
              passwordError: null));
        }
      } else if (usernameController.text != "" &&
          emailController.text != "" &&
          passowrdController.text != "") {
        emit(RegisterFormValidated());
      }
    }
  }

  attemptRegister(
      {required UserModel userModel,
      required Emitter<RegisterState> emit}) async {
    emit(RegisterAttemptLoadingState());
    try {
      UserModel userWithToken =
          await _authRepo.registerService(userModel: userModel);
      emit(const UserRegisteredState(
          message:
              "You have been registered. Login to continue your account."));
    } catch (e) {
      print("here");
      emit(UserRegisterFailedState(message: e.toString()));
      emit(RegisterFormValidated());
    }
  }
}
