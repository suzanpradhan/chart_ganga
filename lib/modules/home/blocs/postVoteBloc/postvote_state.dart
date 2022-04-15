part of 'postvote_bloc.dart';

abstract class PostvoteState extends Equatable {
  const PostvoteState();

  @override
  List<Object> get props => [];
}

class PostvoteInitial extends PostvoteState {}

class PostVoteLoadingState extends PostvoteState {}

class PostVoteSuccessState extends PostvoteState {
  final PostModel postModel;
  const PostVoteSuccessState({required this.postModel});

  @override
  List<Object> get props => [postModel];
}

class PostVoteFailedState extends PostvoteState {
  final String message;
  const PostVoteFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
