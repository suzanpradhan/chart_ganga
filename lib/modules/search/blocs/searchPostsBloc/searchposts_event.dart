part of 'searchposts_bloc.dart';

abstract class SearchpostsEvent extends Equatable {
  const SearchpostsEvent();

  @override
  List<Object> get props => [];
}

class SearchPostsAttemptEvent extends SearchpostsEvent {
  final String value;
  const SearchPostsAttemptEvent({required this.value});

  @override
  List<Object> get props => [value];
}
