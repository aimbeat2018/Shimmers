class TourRequestModel {
  String? area;
  String? date;
  String? time;
  int? amount;
  int? userId;
  int? roleId;
  String? remark;
  String? purpose;
  String? tourReqId;

  TourRequestModel(
      {this.area,
        this.date,
        this.time,
        this.amount,
        this.userId,
        this.roleId,
        this.remark,
        this.purpose,
        this.tourReqId});

  TourRequestModel.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    date = json['date'];
    time = json['time'];
    amount = json['amount'];
    userId = json['user_id'];
    roleId = json['role_id'];
    remark = json['remark'];
    purpose = json['purpose'];
    tourReqId = json['tour_req_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['date'] = this.date;
    data['time'] = this.time;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['remark'] = this.remark;
    data['purpose'] = this.purpose;
    data['tour_req_id'] = this.tourReqId;
    return data;
  }
}
