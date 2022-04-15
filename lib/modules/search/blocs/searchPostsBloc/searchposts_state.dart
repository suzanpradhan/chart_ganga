part of 'searchposts_bloc.dart';

abstract class SearchpostsState extends Equatable {
  const SearchpostsState();

  @override
  List<Object> get props => [];
}

class SearchpostsInitial extends SearchpostsState {}

class SearchPostsLoadingState extends SearchpostsState {}

class SearchPostsSuccessState extends SearchpostsState {
  final List<PostModel> listOfPosts;
  const SearchPostsSuccessState({required this.listOfPosts});

  @override
  List<Object> get props => [listOfPosts];
}

class SearchPostsFailedState extends SearchpostsState {
  final String message;
  const SearchPostsFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
