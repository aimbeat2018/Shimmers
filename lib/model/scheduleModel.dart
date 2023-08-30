class ScheduleModel {
  String? salonName;
  String? location;
  String? time;
  String? status;

  ScheduleModel({this.salonName, this.location, this.time, this.status});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    salonName = json['salonName'];
    location = json['location'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salonName'] = this.salonName;
    data['location'] = this.location;
    data['time'] = this.time;
    data['status'] = this.status;
    return data;
  }
}
