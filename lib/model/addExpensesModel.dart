class AddExpensesModel {
  String? expensesId;
  int? userId;
  String? date;
  String? area;
  String? kilometer;
  int? da;
  int? ta;
  int? hotel;
  int? miscOther;
  int? total;
  String? remark;

  AddExpensesModel(
      {this.expensesId,
        this.userId,
        this.date,
        this.area,
        this.kilometer,
        this.da,
        this.ta,
        this.hotel,
        this.miscOther,
        this.total,
        this.remark});

  AddExpensesModel.fromJson(Map<String, dynamic> json) {
    expensesId = json['expenses_id'];
    userId = json['user_id'];
    date = json['date'];
    area = json['area'];
    kilometer = json['kilometer'];
    da = json['da'];
    ta = json['ta'];
    hotel = json['hotel'];
    miscOther = json['misc_other'];
    total = json['total'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenses_id'] = this.expensesId;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['area'] = this.area;
    data['kilometer'] = this.kilometer;
    data['da'] = this.da;
    data['ta'] = this.ta;
    data['hotel'] = this.hotel;
    data['misc_other'] = this.miscOther;
    data['total'] = this.total;
    data['remark'] = this.remark;
    return data;
  }
}
