class QuestionsModel {
  String? id;
  int? index;
  String? question;
  int? answer;
  List<Choices>? choices;
  String? image;

  QuestionsModel(
      {this.id,
      this.index,
      this.question,
      this.answer,
      this.choices,
      this.image});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
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
