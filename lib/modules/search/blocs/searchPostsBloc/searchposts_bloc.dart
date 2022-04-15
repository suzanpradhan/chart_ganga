import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:chart_ganga/modules/posts/repos/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'searchposts_event.dart';
part 'searchposts_state.dart';

class SearchpostsBloc extends Bloc<SearchpostsEvent, SearchpostsState> {
  PostRepo _postRepo = PostRepo();
  SearchpostsBloc() : super(SearchpostsInitial()) {
    on<SearchpostsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SearchPostsAttemptEvent>(
        (event, emit) => getSearchPostsEventMapped(event, emit));
  }

  getSearchPostsEventMapped(
      SearchPostsAttemptEvent event, Emitter<SearchpostsState> emit) async {
    try {
      emit(SearchPostsLoadingState());
      List<PostModel> data = await _postRepo.searchPosts(value: event.value);
      emit(SearchPostsSuccessState(listOfPosts: data));
    } catch (e) {
      emit(SearchPostsFailedState(message: e.toString()));
    }
  }
}
