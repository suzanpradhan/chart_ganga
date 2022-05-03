import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/checkout/repos/withdraw_repo.dart';
import 'package:equatable/equatable.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  WithdrawRepo _withdrawRepo = WithdrawRepo();
  WithdrawBloc() : super(WithdrawInitial()) {
    on<WithdrawEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<WithdrawAttempt>((event, emit) => withdrawAttemptMapped(event, emit));
  }

  withdrawAttemptMapped(
      WithdrawAttempt event, Emitter<WithdrawState> emit) async {
    try {
      emit(WithdrawLoadingState());
      String message = await _withdrawRepo.withdraw(
          amount: event.amount, id: event.id, isPatym: event.isPaytm);
      emit(WithdrawSuccessState(message: message));
    } catch (e) {
      emit(WithdrawFailedState(message: e.toString()));
    }
  }
}
