class ExpensesByIdModel {
  String? message;
  Data? data;

  ExpensesByIdModel({this.message, this.data});

  ExpensesByIdModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? date;
  String? areaCovered;
  String? kilometer;
  int? da;
  int? ta;
  int? hotel;
  int? miscOther;
  int? total;
  String? remark;
  int? createdBy;
  String? updatedBy;

  Data(
      {this.id,
        this.userId,
        this.date,
        this.areaCovered,
        this.kilometer,
        this.da,
        this.ta,
        this.hotel,
        this.miscOther,
        this.total,
        this.remark,
        this.createdBy,
        this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    areaCovered = json['area_covered'];
    kilometer = json['kilometer'];
    da = json['da'];
    ta = json['ta'];
    hotel = json['hotel'];
    miscOther = json['misc_other'];
    total = json['total'];
    remark = json['remark'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['area_covered'] = this.areaCovered;
    data['kilometer'] = this.kilometer;
    data['da'] = this.da;
    data['ta'] = this.ta;
    data['hotel'] = this.hotel;
    data['misc_other'] = this.miscOther;
    data['total'] = this.total;
    data['remark'] = this.remark;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
