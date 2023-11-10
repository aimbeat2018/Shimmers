class ExeTourDetailModel {
  String? message;
  List<ExecutiveTourModel>? data;

  ExeTourDetailModel({this.message, this.data});

  ExeTourDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ExecutiveTourModel>[];
      json['data'].forEach((v) {
        data!.add(new ExecutiveTourModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExecutiveTourModel {
  int? id;
  String? area;
  String? date;
  String? time;
  int? amount;
  String? bda;
  int? userId;
  int? roleId;
  String? acceptedBy;
  String? description;
  int? status;
  String? remark;
  String? attachment;
  int? createdBy;

  ExecutiveTourModel(
      {this.id,
        this.area,
        this.date,
        this.time,
        this.amount,
        this.bda,
        this.userId,
        this.roleId,
        this.acceptedBy,
        this.description,
        this.status,
        this.remark,
        this.attachment,
        this.createdBy});

  ExecutiveTourModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'];
    date = json['date'];
    time = json['time'];
    amount = json['amount'];
    bda = json['bda'];
    userId = json['user_id'];
    roleId = json['role_id'];
    acceptedBy = json['accepted_by'];
    description = json['description'];
    status = json['status'];
    remark = json['remark'];
    attachment = json['attachment'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area'] = this.area;
    data['date'] = this.date;
    data['time'] = this.time;
    data['amount'] = this.amount;
    data['bda'] = this.bda;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['accepted_by'] = this.acceptedBy;
    data['description'] = this.description;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['attachment'] = this.attachment;
    data['created_by'] = this.createdBy;
    return data;
  }
}
