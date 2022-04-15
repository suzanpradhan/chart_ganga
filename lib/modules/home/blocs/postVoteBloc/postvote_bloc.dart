import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:chart_ganga/modules/posts/repos/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'postvote_event.dart';
part 'postvote_state.dart';

class PostvoteBloc extends Bloc<PostvoteEvent, PostvoteState> {
  PostRepo _postRepo = PostRepo();
  PostvoteBloc() : super(PostvoteInitial()) {
    on<PostvoteEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddVoteAttemptEvent>(
        (event, emit) => addPostVoteEventMapped(event, emit));
  }

  addPostVoteEventMapped(
      AddVoteAttemptEvent event, Emitter<PostvoteState> emit) async {
    try {
      emit(PostVoteLoadingState());
      PostModel postModel =
          await _postRepo.postVote(voteType: event.vote, postId: event.postId);
      emit(PostVoteSuccessState(postModel: postModel));
    } catch (e) {
      emit(PostVoteFailedState(message: e.toString()));
    }
  }
}
