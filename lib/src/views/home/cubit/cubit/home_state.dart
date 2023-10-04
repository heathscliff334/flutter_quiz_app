part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final ErrorState error;
  HomeError(this.error);
}

class HomeListSuccess extends HomeState {
  final List<TopicModel> data;
  HomeListSuccess(this.data);
}
