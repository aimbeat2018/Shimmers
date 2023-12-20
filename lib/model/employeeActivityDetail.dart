class EmployeeActivityDetail {
  List<ActivityTypeDetails>? data;

  EmployeeActivityDetail({this.data});

  EmployeeActivityDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ActivityTypeDetails>[];
      json['data'].forEach((v) {
        data!.add(new ActivityTypeDetails.fromJson(v));
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

class ActivityTypeDetails {
  int? salonId;
  String? salonName;
  String? mobile;
  String? address;
  int? orderAmount;
  String? date;
  String? rating;
  String? remark;
  String? demoDate;
  String? demoTime;
  String? requirement;
  String? demoStatus;

  ActivityTypeDetails(
      {this.salonId,
        this.salonName,
        this.mobile,
        this.address,
        this.orderAmount,
        this.date,
        this.rating,
        this.remark,
        this.demoDate,
        this.demoTime,
        this.requirement,
        this.demoStatus});

  ActivityTypeDetails.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    salonName = json['salon_name'];
    mobile = json['mobile'];
    address = json['address'];
    orderAmount = json['order_amount'];
    date = json['date'];
    rating = json['rating'];
    remark = json['remark'];
    demoDate = json['demo_date'];
    demoTime = json['demo_time'];
    requirement = json['requirement'];
    demoStatus = json['demo_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['salon_name'] = this.salonName;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['order_amount'] = this.orderAmount;
    data['date'] = this.date;
    data['rating'] = this.rating;
    data['remark'] = this.remark;
    data['demo_date'] = this.demoDate;
    data['demo_time'] = this.demoTime;
    data['requirement'] = this.requirement;
    data['demo_status'] = this.demoStatus;
    return data;
  }
}
