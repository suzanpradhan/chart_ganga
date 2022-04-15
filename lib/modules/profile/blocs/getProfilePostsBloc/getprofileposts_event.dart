part of 'getprofileposts_bloc.dart';

abstract class GetprofilepostsEvent extends Equatable {
  const GetprofilepostsEvent();

  @override
  List<Object> get props => [];
}

class GetMyPostsAttemptEvent extends GetprofilepostsEvent {}

class GetSavedPostsAttemptEvent extends GetprofilepostsEvent {}
