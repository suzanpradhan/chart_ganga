part of 'withdraw_bloc.dart';

abstract class WithdrawEvent extends Equatable {
  const WithdrawEvent();

  @override
  List<Object> get props => [];
}

class WithdrawAttempt extends WithdrawEvent {
  final String amount;
  final String id;
  final bool isPaytm;

  const WithdrawAttempt(
      {required this.amount, required this.id, required this.isPaytm});
  @override
  List<Object> get props => [amount, id, isPaytm];
}
