class AttendanceModel {
  String? date;
  String? description;
  String? type;
  String? status;

  AttendanceModel({this.date, this.description, this.type, this.status});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    description = json['description'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['description'] = description;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}
