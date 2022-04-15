part of 'getfeedpost_bloc.dart';

abstract class GetfeedpostState extends Equatable {
  const GetfeedpostState();

  @override
  List<Object> get props => [];
}

class GetfeedpostInitial extends GetfeedpostState {}

class GetFeedPostLoadingState extends GetfeedpostState {}

class GotFeedPostSuccessState extends GetfeedpostState {
  final List<PostModel> listOfPosts;

  const GotFeedPostSuccessState({required this.listOfPosts});

  @override
  List<Object> get props => [listOfPosts];
}

class GetFeedPostFailedState extends GetfeedpostState {
  final String message;

  const GetFeedPostFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
