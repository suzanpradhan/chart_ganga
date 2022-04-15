import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/posts/models/bookmark_model.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:chart_ganga/modules/posts/repos/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'getprofileposts_event.dart';
part 'getprofileposts_state.dart';

class GetprofilepostsBloc
    extends Bloc<GetprofilepostsEvent, GetprofilepostsState> {
  PostRepo _postRepo = PostRepo();
  GetprofilepostsBloc() : super(GetprofilepostsInitial()) {
    on<GetprofilepostsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetMyPostsAttemptEvent>(
        (event, emit) => getMyPostsEventMapped(event, emit));
    on<GetSavedPostsAttemptEvent>(
        (event, emit) => getMySavedPostsEventMapped(event, emit));
  }

  getMyPostsEventMapped(
      GetMyPostsAttemptEvent event, Emitter<GetprofilepostsState> emit) async {
    try {
      emit(GetProfilePostsLoadingState());
      List<PostModel> data = await _postRepo.getMyPosts();
      emit(GetProfilePostsSuccessState(listOfPosts: data));
    } catch (e) {
      emit(GetProfilePostsFailedState(message: e.toString()));
    }
  }

  getMySavedPostsEventMapped(GetSavedPostsAttemptEvent event,
      Emitter<GetprofilepostsState> emit) async {
    try {
      emit(GetProfilePostsLoadingState());
      List<BookmarkModel> data = await _postRepo.getSavedPosts();
      emit(GetMySavedPostsSuccessState(listOfSavedPosts: data));
    } catch (e) {
      emit(GetMySavedPostsFailedState(message: e.toString()));
    }
  }
}
