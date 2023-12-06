class SubmitCampaignRequestModel {
  int? campaignId;
  int? salonId;
  int? is_on_tour;
  List<UsersAnswer>? answer;

  SubmitCampaignRequestModel({this.campaignId, this.salonId, this.answer});

  SubmitCampaignRequestModel.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaign_id'];
    salonId = json['salon_id'];
    is_on_tour = json['is_on_tour'];
    if (json['answer'] != null) {
      answer = <UsersAnswer>[];
      json['answer'].forEach((v) {
        answer!.add(new UsersAnswer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_id'] = this.campaignId;
    data['salon_id'] = this.salonId;
    data['is_on_tour'] = this.is_on_tour;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersAnswer {
  int? questionId;
  List<Answers>? answers;
  String? singleAnswer;

  UsersAnswer({this.questionId, this.answers, this.singleAnswer});

  UsersAnswer.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    singleAnswer = json['single_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['single_answer'] = this.singleAnswer;
    return data;
  }
}

class Answers {
  String? key;

  Answers({this.key});

  Answers.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}
