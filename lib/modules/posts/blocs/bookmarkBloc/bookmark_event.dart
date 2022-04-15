part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class AddToBookmarkAttemptEvent extends BookmarkEvent {
  final int postId;
  const AddToBookmarkAttemptEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
