class DemoListModel {
  List<DemoData>? data;

  DemoListModel({this.data});

  DemoListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DemoData>[];
      json['data'].forEach((v) {
        data!.add(new DemoData.fromJson(v));
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

class DemoData {
  String? salonName;
  int? id;
  int? salonId;
  String? date;
  String? time;
  String? requirement;
  int? demoAssignedTo;
  String? demoStatus;
  int? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  DemoData(
      {this.salonName,
      this.id,
      this.salonId,
      this.date,
      this.time,
      this.requirement,
      this.demoAssignedTo,
      this.demoStatus,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  DemoData.fromJson(Map<String, dynamic> json) {
    salonName = json['salon_name'];
    id = json['id'];
    salonId = json['salon_id'];
    date = json['date'];
    time = json['time'];
    requirement = json['requirement'];
    demoAssignedTo = json['demo_assigned_to'];
    demoStatus = json['demo_status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_name'] = this.salonName;
    data['id'] = this.id;
    data['salon_id'] = this.salonId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['requirement'] = this.requirement;
    data['demo_assigned_to'] = this.demoAssignedTo;
    data['demo_status'] = this.demoStatus;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
