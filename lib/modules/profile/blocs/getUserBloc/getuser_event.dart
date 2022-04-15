part of 'getuser_bloc.dart';

abstract class GetuserEvent extends Equatable {
  const GetuserEvent();

  @override
  List<Object> get props => [];
}

class GetUserAttemptEvent extends GetuserEvent {}
