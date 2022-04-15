part of 'getprofileposts_bloc.dart';

abstract class GetprofilepostsState extends Equatable {
  const GetprofilepostsState();

  @override
  List<Object> get props => [];
}

class GetprofilepostsInitial extends GetprofilepostsState {}

class GetProfilePostsLoadingState extends GetprofilepostsState {}

class GetProfilePostsSuccessState extends GetprofilepostsState {
  final List<PostModel> listOfPosts;
  const GetProfilePostsSuccessState({required this.listOfPosts});

  @override
  List<Object> get props => [listOfPosts];
}

class GetProfilePostsFailedState extends GetprofilepostsState {
  final String message;

  const GetProfilePostsFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class GetMySavedPostsSuccessState extends GetprofilepostsState {
  final List<BookmarkModel> listOfSavedPosts;
  const GetMySavedPostsSuccessState({required this.listOfSavedPosts});

  @override
  List<Object> get props => [listOfSavedPosts];
}

class GetMySavedPostsFailedState extends GetprofilepostsState {
  final String message;

  const GetMySavedPostsFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
