import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/profile/models/wallet_model.dart';
import 'package:chart_ganga/modules/profile/repos/wallet_repo.dart';
import 'package:equatable/equatable.dart';

part 'getmywallet_event.dart';
part 'getmywallet_state.dart';

class GetmywalletBloc extends Bloc<GetmywalletEvent, GetmywalletState> {
  WalletRepo _walletRepo = WalletRepo();
  GetmywalletBloc() : super(GetmywalletInitial()) {
    on<GetmywalletEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetMyWalletAttemptEvent>(
        (event, emit) => getMyWalletEventMapped(event, emit));
  }

  getMyWalletEventMapped(
      GetMyWalletAttemptEvent event, Emitter<GetmywalletState> emit) async {
    try {
      emit(GetMyWalletLoadingState());
      WalletModel walletModel = await _walletRepo.getWallet();
      emit(GetMyWalletSuccessState(wallet: walletModel));
    } catch (e) {
      emit(GetMyWalletFailedState(message: e.toString()));
    }
  }
}
