import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vquiz_app/src/models/error_state.dart';
import 'package:vquiz_app/src/services/network/topics_service.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final TopicsService _topicsService = TopicsService();
  void getTopicList() async {
    emit(HomeLoading());
    try {
      // final _data = await _homeRepository.getUserDetailsWithSessionAndKey(
      //     userId: userId, homeRequest: homeRequest);
      print("getTopicList()");
      final _data = await _topicsService.fetchTopics();
      _data.fold(
        (l) => emit(HomeError(l)),
        (r) {
          emit(HomeListSuccess(r));
        },
      );
    } catch (e) {
      var error = ErrorState(message: e.toString());
      emit(HomeError(error));
    }
  }
}
