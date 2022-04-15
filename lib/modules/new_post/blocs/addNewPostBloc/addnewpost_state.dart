part of 'addnewpost_bloc.dart';

abstract class AddnewpostState extends Equatable {
  const AddnewpostState();

  @override
  List<Object> get props => [];
}

class AddnewpostInitial extends AddnewpostState {}

class AddNewPostLoadingState extends AddnewpostState {}

class AddNewPostSuccessState extends AddnewpostState {}

class AddNewPostValidationErrorState extends AddnewpostState {
  final String message;
  const AddNewPostValidationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddNewPostFailedState extends AddnewpostState {
  final String message;
  const AddNewPostFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
