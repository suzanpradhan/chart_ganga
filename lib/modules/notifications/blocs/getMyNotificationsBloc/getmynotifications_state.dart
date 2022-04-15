part of 'getmynotifications_bloc.dart';

abstract class GetmynotificationsState extends Equatable {
  const GetmynotificationsState();

  @override
  List<Object> get props => [];
}

class GetmynotificationsInitial extends GetmynotificationsState {}

class GetMyNotificationsLoadingState extends GetmynotificationsState {}

class GetMyNotificationsSuccessState extends GetmynotificationsState {
  final List<NotificationModel> listOfNotifications;

  const GetMyNotificationsSuccessState({required this.listOfNotifications});

  @override
  List<Object> get props => [listOfNotifications];
}

class GetMyNotificationsFailedState extends GetmynotificationsState {
  final String message;

  const GetMyNotificationsFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
