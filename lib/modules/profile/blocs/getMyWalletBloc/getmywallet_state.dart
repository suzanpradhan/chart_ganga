part of 'getmywallet_bloc.dart';

abstract class GetmywalletState extends Equatable {
  const GetmywalletState();

  @override
  List<Object> get props => [];
}

class GetmywalletInitial extends GetmywalletState {}

class GetMyWalletLoadingState extends GetmywalletState {}

class GetMyWalletSuccessState extends GetmywalletState {
  final WalletModel wallet;
  const GetMyWalletSuccessState({required this.wallet});

  @override
  List<Object> get props => [wallet];
}

class GetMyWalletFailedState extends GetmywalletState {
  final String message;
  const GetMyWalletFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
