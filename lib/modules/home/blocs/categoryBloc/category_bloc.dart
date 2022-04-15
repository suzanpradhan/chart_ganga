import 'package:bloc/bloc.dart';
import 'package:chart_ganga/modules/home/models/category_model.dart';
import 'package:chart_ganga/modules/home/repos/category_repo.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepo _categoryRepo = CategoryRepo();
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllCategoryEvent>((event, emit) => getAllCategoryMapped(event, emit));
    on<GetAllCategoryForNewPostEvent>(
        (event, emit) => getAllCategoryForNewPostMapped(event, emit));
  }

  getAllCategoryMapped(
      GetAllCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(GetAllCategoryLoadingState());
      List<CategoryModel> data = await _categoryRepo.getAllCategories();
      List<CategoryModel> categoryListWithTrending = [
            CategoryModel(id: 0, name: "Trending"),
          ] +
          data;
      emit(GetAllCategorySuccessState(categoryList: categoryListWithTrending));
    } catch (e) {
      emit(GetAllCategoryFailedState(message: e.toString()));
    }
  }

  getAllCategoryForNewPostMapped(
      GetAllCategoryForNewPostEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(GetAllCategoryLoadingState());
      List<CategoryModel> data = await _categoryRepo.getAllCategories();
      List<CategoryModel> categoryListWithDummy = [
            CategoryModel(id: 0, name: "Select a category"),
          ] +
          data;
      emit(GetAllCategorySuccessState(categoryList: categoryListWithDummy));
    } catch (e) {
      emit(GetAllCategoryFailedState(message: e.toString()));
    }
  }
}
