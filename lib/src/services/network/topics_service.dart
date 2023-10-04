import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:vquiz_app/src/models/error_state.dart';
import 'package:vquiz_app/src/services/utils/print_log.dart';

import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

class TopicsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<ErrorState, List<TopicModel>>> fetchTopics() async {
    try {
      final querySnapshot = await _firestore.collection('topics').get();

      final topics = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<TopicModel> parseTopics(List<dynamic> topicsData) {
        return topicsData.map((json) => TopicModel.fromJson(json)).toList();
      }

      final topicData = parseTopics(topics);

      return right(topicData);
    } catch (e) {
      PrintLog().printError('Error fetching topics: $e');
      var error = ErrorState(message: e.toString());
      return left(error);
    }
  }
}
