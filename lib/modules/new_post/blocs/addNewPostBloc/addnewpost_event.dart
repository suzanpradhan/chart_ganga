part of 'addnewpost_bloc.dart';

abstract class AddnewpostEvent extends Equatable {
  const AddnewpostEvent();

  @override
  List<Object> get props => [];
}

class AddNewPostAttemptEvent extends AddnewpostEvent {
  final AddNewPostModel addNewPostModel;
  const AddNewPostAttemptEvent({required this.addNewPostModel});

  @override
  List<Object> get props => [addNewPostModel];
}
