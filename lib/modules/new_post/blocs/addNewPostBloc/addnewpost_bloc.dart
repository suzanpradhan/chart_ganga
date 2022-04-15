import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/new_post/models/add_new_post_model.dart';
import 'package:chart_ganga/modules/posts/repos/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'addnewpost_event.dart';
part 'addnewpost_state.dart';

class AddnewpostBloc extends Bloc<AddnewpostEvent, AddnewpostState> {
  PostRepo _postRepo = PostRepo();
  AddnewpostBloc() : super(AddnewpostInitial()) {
    on<AddnewpostEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddNewPostAttemptEvent>(
        (event, emit) => addNewPostAttemptMapped(event, emit));
  }

  addNewPostAttemptMapped(
      AddNewPostAttemptEvent event, Emitter<AddnewpostState> emit) async {
    emit(AddNewPostLoadingState());
    if (event.addNewPostModel.image == null) {
      emit(AddNewPostValidationErrorState(
          message: "Please select a cover iamge for the post."));
    } else if (event.addNewPostModel.title == null ||
        event.addNewPostModel.title == "") {
      emit(AddNewPostValidationErrorState(message: "Title is required."));
    } else if (event.addNewPostModel.categoryId == null ||
        event.addNewPostModel.categoryId == 0) {
      emit(AddNewPostValidationErrorState(message: "Select a category."));
    }

    try {
      bool status =
          await _postRepo.createNewPost(addNewPostModel: event.addNewPostModel);
      if (status) {
        emit(AddNewPostSuccessState());
      } else {
        emit(AddNewPostFailedState(message: "Failed trying to post!"));
      }
    } catch (e) {
      emit(AddNewPostFailedState(message: e.toString()));
    }
  }
}
