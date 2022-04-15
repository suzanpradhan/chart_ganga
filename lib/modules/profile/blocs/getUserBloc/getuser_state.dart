part of 'getuser_bloc.dart';

abstract class GetuserState extends Equatable {
  const GetuserState();

  @override
  List<Object> get props => [];
}

class GetuserInitial extends GetuserState {}

class GetUserLoadingState extends GetuserState {}

class GetUserSuccessState extends GetuserState {
  final UserModel user;
  const GetUserSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserFailedState extends GetuserState {
  final String message;
  const GetUserFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
