part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileAttempt extends UpdateProfileEvent {
  final ProfileModel profileModel;
  const UpdateProfileAttempt({required this.profileModel});

  @override
  List<Object> get props => [profileModel];
}
