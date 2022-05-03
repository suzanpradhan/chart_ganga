part of 'withdraw_bloc.dart';

abstract class WithdrawState extends Equatable {
  const WithdrawState();

  @override
  List<Object> get props => [];
}

class WithdrawInitial extends WithdrawState {}

class WithdrawLoadingState extends WithdrawState {}

class WithdrawSuccessState extends WithdrawState {
  final String message;
  const WithdrawSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class WithdrawFailedState extends WithdrawState {
  final String message;
  const WithdrawFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
