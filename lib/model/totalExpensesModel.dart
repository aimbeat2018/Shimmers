class TotalExpensesModel {
  String? message;
  List<ExpensesDetailModel>? data;

  TotalExpensesModel({this.message, this.data});

  TotalExpensesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ExpensesDetailModel>[];
      json['data'].forEach((v) {
        data!.add(new ExpensesDetailModel.fromJson(v));
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

class ExpensesDetailModel {
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
  int? updatedBy;
  String? attachment;

  ExpensesDetailModel(
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
        this.updatedBy,
      this.attachment});

  ExpensesDetailModel.fromJson(Map<String, dynamic> json) {
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
    attachment = json['attachment'];
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
    data['attachment'] = this.attachment;
    return data;
  }
}
