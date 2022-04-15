import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/home/models/category_model.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:chart_ganga/modules/posts/repos/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'getfeedpost_event.dart';
part 'getfeedpost_state.dart';

class GetfeedpostBloc extends Bloc<GetfeedpostEvent, GetfeedpostState> {
  PostRepo _postRepo = PostRepo();
  GetfeedpostBloc() : super(GetfeedpostInitial()) {
    on<GetfeedpostEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetTrendingPostsEvent>(
        (event, emit) => getTrendingPostEventMapped(event, emit));

    on<GetPostsByCategoryEvent>(
        (event, emit) => getPostsbyCategoryMapped(event, emit));
  }

  getTrendingPostEventMapped(
      GetTrendingPostsEvent event, Emitter<GetfeedpostState> emit) async {
    try {
      emit(GetFeedPostLoadingState());
      List<PostModel> data = await _postRepo.getTrendingPosts();
      emit(GotFeedPostSuccessState(listOfPosts: data));
    } catch (e) {
      emit(GetFeedPostFailedState(message: e.toString()));
    }
  }

  getPostsbyCategoryMapped(
      GetPostsByCategoryEvent event, Emitter<GetfeedpostState> emit) async {
    try {
      emit(GetFeedPostLoadingState());
      List<PostModel> data =
          await _postRepo.getPostsByCategory(category: event.categoryModel.id!);
      emit(GotFeedPostSuccessState(listOfPosts: data));
    } catch (e) {
      emit(GetFeedPostFailedState(message: e.toString()));
    }
  }
}
