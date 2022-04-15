part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginFormSubmit extends LoginEvent {
  final UserModel userModel;

  const LoginFormSubmit({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

class UsernameValidate extends LoginEvent {
  final String? username;
  final LoginFormErrorState? errorState;
  const UsernameValidate({this.username, this.errorState});
  @override
  List<Object?> get props => [username, errorState];
}

class PasswordValidate extends LoginEvent {
  final String? password;
  final LoginFormErrorState? errorState;
  const PasswordValidate({this.password, this.errorState});

  @override
  List<Object?> get props => [password, errorState];
}
