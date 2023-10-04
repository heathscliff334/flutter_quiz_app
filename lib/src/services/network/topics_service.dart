import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:vquiz_app/src/models/error_state.dart';
import 'package:vquiz_app/src/views/topics/models/questions_model.dart';
import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

class TopicsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<ErrorState, List<TopicModel>>> fetchTopics() async {
    try {
      final querySnapshot = await _firestore.collection('topics').get();
      // inspect(querySnapshot.docs);
      // final DocumentReference docRef =
      //     _firestore.collection('topics').doc('tz56LtEgOmDJNtSsOFv7');
      // inspect(docRef);
      // await docRef.update({
      //   'questions': animalQuestions,
      // });

      // await docRef.set({
      //   'questions': countryQuestions,
      // }, SetOptions(merge: true));
      // var collection = _firestore.collection('topics');
      // inspect(collection);
      // collection
      //     .doc('RW2XxsoXj94509X6mp2h')
      //     .update({'questions': animalQuestions}) // <-- Nested value
      //     .then((_) => print('Success'))
      //     .catchError((error) => print('Failed: $error'));

      // final topics = querySnapshot.docs
      //     .map((doc) => doc.data()['topicName'] as String)
      //     .toList();
      final topics = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<TopicModel> parseTopics(List<dynamic> topicsData) {
        return topicsData.map((json) => TopicModel.fromJson(json)).toList();
      }

      final topicData = parseTopics(topics);
      // inspect(topics);
      // inspect(topics);
      // inspect(topicData);

      return right(topicData);
    } catch (e) {
      // Handle errors, e.g., network issues or Firestore rules violations
      print('Error fetching topics: $e');
      var error = ErrorState(message: e.toString());
      return left(error);
    }
  }

  Future<Either<ErrorState, QuestionsModel>> fetchQuestions(String id) async {
    try {
      final querySnapshot = await _firestore.collection('questions').get();
      final topics = querySnapshot.docs
          .map((doc) => doc.data()['name'] as String)
          .toList();
      return right(QuestionsModel());
    } catch (e) {
      // Handle errors, e.g., network issues or Firestore rules violations
      print('Error fetching topics: $e');
      var error = ErrorState(message: e.toString());
      return left(error);
    }
  }
}
