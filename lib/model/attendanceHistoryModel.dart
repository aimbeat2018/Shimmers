class AttendanceHistoryModel {
  History? history;

  AttendanceHistoryModel({this.history});

  AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    history = json['data'] != null ? History.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (history != null) {
      data['data'] = history!.toJson();
    }
    return data;
  }
}

class History {
  int? totalWorkingDays;
  int? totalPresents;
  int? totalAbsents;
  List<Summary>? summary;

  History(
      {this.totalWorkingDays,
      this.totalPresents,
      this.totalAbsents,
      this.summary});

  History.fromJson(Map<String, dynamic> json) {
    totalWorkingDays = json['total_working_days'];
    totalPresents = json['total_presents'];
    totalAbsents = json['total_absents'];
    if (json['summary'] != null) {
      summary = <Summary>[];
      json['summary'].forEach((v) {
        summary!.add(Summary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_working_days'] = totalWorkingDays;
    data['total_presents'] = totalPresents;
    data['total_absents'] = totalAbsents;
    if (summary != null) {
      data['summary'] = summary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  String? date;
  String? status;

  Summary({this.date, this.status});

  Summary.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
