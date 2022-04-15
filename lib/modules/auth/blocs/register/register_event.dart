part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class UsernameValidate extends RegisterEvent {
  final String? username;
  final RegisterFormErrorState? errorState;
  const UsernameValidate({this.username, this.errorState});
  @override
  List<Object?> get props => [username, errorState];
}

class EmailValidate extends RegisterEvent {
  final String? emailAddress;
  final RegisterFormErrorState? errorState;
  const EmailValidate({this.emailAddress, this.errorState});
  @override
  List<Object?> get props => [emailAddress, errorState];
}

class PasswordValidate extends RegisterEvent {
  final String? password;
  final RegisterFormErrorState? errorState;
  const PasswordValidate({this.password, this.errorState});

  @override
  List<Object?> get props => [password, errorState];
}

class RegisterFormSubmitted extends RegisterEvent {
  final UserModel userModel;

  const RegisterFormSubmitted({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}
