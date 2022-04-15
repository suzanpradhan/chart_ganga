import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/posts/repos/post_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  PostRepo _postRepo = PostRepo();
  BookmarkBloc() : super(BookmarkInitial()) {
    on<BookmarkEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddToBookmarkAttemptEvent>(
        (event, emit) => addToBookmarkEventMapped(event, emit));
  }

  addToBookmarkEventMapped(
      AddToBookmarkAttemptEvent event, Emitter<BookmarkState> emit) async {
    try {
      emit(AddToBookmarkLoadingState());
      bool isBookmarked = await _postRepo.bookmarkAttempt(postId: event.postId);
      emit(AddToBookmarkSuccessState(isBookmarked: isBookmarked));
    } catch (e) {
      emit(AddToBookmarkFailedState(message: e.toString()));
    }
  }
}
