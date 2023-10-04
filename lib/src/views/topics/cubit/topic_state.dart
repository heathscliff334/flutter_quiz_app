part of 'topic_cubit.dart';

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicLoading extends TopicState {}

class TopicError extends TopicState {
  final ErrorState error;
  TopicError(this.error);
}

class TopicListSuccess extends TopicState {
  final List<TopicModel> data;
  TopicListSuccess(this.data);
}
