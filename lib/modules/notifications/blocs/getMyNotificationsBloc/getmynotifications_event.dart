part of 'getmynotifications_bloc.dart';

abstract class GetmynotificationsEvent extends Equatable {
  const GetmynotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetMyNotificationsAttemptEvent extends GetmynotificationsEvent {}
