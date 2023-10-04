class TopicModel {
  String? topicName;
  List<Questions>? questions;

  TopicModel({this.topicName, this.questions});

  TopicModel.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicName'] = topicName;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  int? index;
  String? question;
  int? answer;
  int? userAnswer;
  List<Choices>? choices;
  String? image;

  Questions(
      {this.id,
      this.index,
      this.question,
      this.answer,
      this.userAnswer,
      this.choices,
      this.image});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    index = json['index'];
    question = json['question'];
    answer = json['answer'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(Choices.fromJson(v));
      });
    }
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['index'] = index;
    data['question'] = question;
    data['answer'] = answer;
    if (choices != null) {
      data['choices'] = choices!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    return data;
  }
}

class Choices {
  int? choiceId;
  String? choice;

  Choices({this.choiceId, this.choice});

  Choices.fromJson(Map<String, dynamic> json) {
    choiceId = json['choiceId'];
    choice = json['choice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['choiceId'] = choiceId;
    data['choice'] = choice;
    return data;
  }
}
