part of 'get_profile_bloc.dart';

abstract class GetProfileEvent extends Equatable {
  const GetProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileAttempt extends GetProfileEvent {}
