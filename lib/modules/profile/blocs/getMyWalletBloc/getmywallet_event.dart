part of 'getmywallet_bloc.dart';

abstract class GetmywalletEvent extends Equatable {
  const GetmywalletEvent();

  @override
  List<Object> get props => [];
}

class GetMyWalletAttemptEvent extends GetmywalletEvent {}
