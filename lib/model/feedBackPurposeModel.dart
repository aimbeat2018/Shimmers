class FeedBackPurposeModel {
  List<FeedbackData>? data;

  FeedBackPurposeModel({this.data});

  FeedBackPurposeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FeedbackData>[];
      json['data'].forEach((v) {
        data!.add(FeedbackData.fromJson(v));
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

class FeedbackData {
  int? id;
  String? feedbackType;

  FeedbackData({this.id, this.feedbackType});

  FeedbackData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedbackType = json['feedback_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['feedback_type'] = feedbackType;
    return data;
  }
}
