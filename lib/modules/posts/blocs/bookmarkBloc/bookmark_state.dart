part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class AddToBookmarkLoadingState extends BookmarkState {}

class AddToBookmarkSuccessState extends BookmarkState {
  final bool isBookmarked;
  const AddToBookmarkSuccessState({required this.isBookmarked});

  @override
  List<Object> get props => [isBookmarked];
}

class AddToBookmarkFailedState extends BookmarkState {
  final String message;
  const AddToBookmarkFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
