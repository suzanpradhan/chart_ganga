part of 'getfeedpost_bloc.dart';

abstract class GetfeedpostEvent extends Equatable {
  const GetfeedpostEvent();

  @override
  List<Object> get props => [];
}

class GetTrendingPostsEvent extends GetfeedpostEvent {}

class GetPostsByCategoryEvent extends GetfeedpostEvent {
  final CategoryModel categoryModel;
  const GetPostsByCategoryEvent({required this.categoryModel});

  @override
  List<Object> get props => [categoryModel];
}
