part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class GetAllCategoryLoadingState extends CategoryState {}

class GetAllCategorySuccessState extends CategoryState {
  final List<CategoryModel> categoryList;

  const GetAllCategorySuccessState({required this.categoryList});

  @override
  List<Object> get props => [categoryList];
}

class GetAllCategoryFailedState extends CategoryState {
  final String message;
  const GetAllCategoryFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
