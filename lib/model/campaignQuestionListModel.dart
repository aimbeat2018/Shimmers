class CampaignQuestionListModel {
  List<CampaignQuestionData>? data;

  CampaignQuestionListModel({this.data});

  CampaignQuestionListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CampaignQuestionData>[];
      json['data'].forEach((v) {
        data!.add(CampaignQuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CampaignQuestionData {
  int? id;
  int? campaignId;
  String? question;
  List<Answer>? answer;
  String? answerType;
  int selectedIndex = -1;
  List<String>? selectedAnswerList = [];
  String? userAnswer = "";

  CampaignQuestionData(
      {this.id, this.campaignId, this.question, this.answer, this.answerType});

  CampaignQuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignId = json['campaign_id'];
    question = json['question'];
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(Answer.fromJson(v));
      });
    }
    answerType = json['answer_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['campaign_id'] = campaignId;
    data['question'] = question;
    if (answer != null) {
      data['answer'] = answer!.map((v) => v.toJson()).toList();
    }
    data['answer_type'] = answerType;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    return data;
  }
}
