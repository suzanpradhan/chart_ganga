part of 'postvote_bloc.dart';

abstract class PostvoteEvent extends Equatable {
  const PostvoteEvent();

  @override
  List<Object> get props => [];
}

class AddVoteAttemptEvent extends PostvoteEvent {
  final int vote;
  final int postId;
  const AddVoteAttemptEvent({required this.vote, required this.postId});

  @override
  List<Object> get props => [vote, postId];
}
