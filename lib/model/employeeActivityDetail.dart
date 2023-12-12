class EmployeeActivityDetail {
  List<Data>? data;

  EmployeeActivityDetail({this.data});

  EmployeeActivityDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? salonId;
  String? salonName;
  String? mobile;
  String? address;
  Null? orderAmount;
  String? rating;
  String? remark;

  Data(
      {this.salonId,
        this.salonName,
        this.mobile,
        this.address,
        this.orderAmount,
        this.rating,
        this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    salonId = json['salon_id'];
    salonName = json['salon_name'];
    mobile = json['mobile'];
    address = json['address'];
    orderAmount = json['order_amount'];
    rating = json['rating'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_id'] = this.salonId;
    data['salon_name'] = this.salonName;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['order_amount'] = this.orderAmount;
    data['rating'] = this.rating;
    data['remark'] = this.remark;
    return data;
  }
}
