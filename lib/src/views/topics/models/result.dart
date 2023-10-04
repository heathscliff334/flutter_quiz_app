import 'package:vquiz_app/src/views/topics/models/topic_model.dart';

class Result {
  final int correctAnswer;
  final int questionLength;
  List<Questions>? questions;
  Result(
      {required this.correctAnswer,
      required this.questionLength,
      required this.questions});
}
