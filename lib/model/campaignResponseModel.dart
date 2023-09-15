class CampaignResponseModel {
  List<CampaignResponseData>? data;

  CampaignResponseModel({this.data});

  CampaignResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CampaignResponseData>[];
      json['data'].forEach((v) {
        data!.add(new CampaignResponseData.fromJson(v));
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

class CampaignResponseData {
  int? id;
  int? campaignId;
  int? salonId;
  int? userId;
  List<Answer>? answer;
  int? questionId;
  String? question;

  CampaignResponseData(
      {this.id,
      this.campaignId,
      this.salonId,
      this.userId,
      this.answer,
      this.questionId,
      this.question});

  CampaignResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignId = json['campaign_id'];
    salonId = json['salon_id'];
    userId = json['user_id'];
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
    questionId = json['question_id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campaign_id'] = this.campaignId;
    data['salon_id'] = this.salonId;
    data['user_id'] = this.userId;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    data['question_id'] = this.questionId;
    data['question'] = this.question;
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
