class CampaignModel {
  String? question;
  String? answers;
  String? image;
  String? type;
  List<AnswersList>? answersList;
  List<SelectedAnswersList>? selectedAnswersList;

  CampaignModel(
      {this.question,
      this.answers,
      this.image,
      this.type,
      this.answersList,
      this.selectedAnswersList});

  CampaignModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answers = json['answers'];
    image = json['image'];
    type = json['type'];
    if (json['answersList'] != null) {
      answersList = <AnswersList>[];
      json['answersList'].forEach((v) {
        answersList!.add(new AnswersList.fromJson(v));
      });
    }
    if (json['selectedAnswersList'] != null) {
      selectedAnswersList = <SelectedAnswersList>[];
      json['selectedAnswersList'].forEach((v) {
        selectedAnswersList!.add(new SelectedAnswersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answers'] = this.answers;
    data['image'] = this.image;
    data['type'] = this.type;
    if (this.answersList != null) {
      data['answersList'] = this.answersList!.map((v) => v.toJson()).toList();
    }
    if (this.selectedAnswersList != null) {
      data['selectedAnswersList'] =
          this.selectedAnswersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswersList {
  String? name;

  AnswersList({this.name});

  AnswersList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class SelectedAnswersList {
  String? name;

  SelectedAnswersList({this.name});

  SelectedAnswersList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
