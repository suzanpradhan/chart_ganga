part of 'get_profile_bloc.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoadingState extends GetProfileState {}

class GetProfileSuccessState extends GetProfileState {
  final ProfileModel profileModel;
  const GetProfileSuccessState({required this.profileModel});

  @override
  List<Object> get props => [profileModel];
}

class GetProfileFailedState extends GetProfileState {
  final String message;
  const GetProfileFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
