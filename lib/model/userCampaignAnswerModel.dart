class UserCampaignAnswerModel {
  List<Data>? data;

  UserCampaignAnswerModel({this.data});

  UserCampaignAnswerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? question;
  List<Answer>? answer;
  String? answerType;
  String? userAnswer;

  Data({this.question, this.answer, this.answerType, this.userAnswer});

  Data.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
    answerType = json['answer_type'];
    userAnswer = json['user_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    data['answer_type'] = this.answerType;
    data['user_answer'] = this.userAnswer;
    return data;
  }
}

class Answer {
  String? key;

  Answer({this.key});

  Answer.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}
