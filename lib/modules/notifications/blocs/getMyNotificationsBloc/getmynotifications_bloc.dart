import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/notifications/models/notification_model.dart';
import 'package:chart_ganga/modules/notifications/repos/notification_repo.dart';
import 'package:equatable/equatable.dart';

part 'getmynotifications_event.dart';
part 'getmynotifications_state.dart';

class GetmynotificationsBloc
    extends Bloc<GetmynotificationsEvent, GetmynotificationsState> {
  NotificationRepo _notificationRepo = NotificationRepo();
  GetmynotificationsBloc() : super(GetmynotificationsInitial()) {
    on<GetmynotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetMyNotificationsAttemptEvent>(
        (event, emit) => getMyNotificationsMapped(event, emit));
  }

  getMyNotificationsMapped(GetMyNotificationsAttemptEvent event,
      Emitter<GetmynotificationsState> emit) async {
    try {
      emit(GetMyNotificationsLoadingState());
      List<NotificationModel> data =
          await _notificationRepo.getMyNotifications();
      emit(GetMyNotificationsSuccessState(listOfNotifications: data));
    } catch (e) {
      emit(GetMyNotificationsFailedState(message: e.toString()));
    }
  }
}
