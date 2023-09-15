class LeaveTypeModel {
  List<LeaveTypeData>? data;

  LeaveTypeModel({this.data});

  LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LeaveTypeData>[];
      json['data'].forEach((v) {
        data!.add(LeaveTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTypeData {
  int? id;
  int? companyId;
  String? typeName;
  String? color;
  int? noOfLeaves;
  int? paid;
  String? monthlyLimit;

  LeaveTypeData(
      {this.id,
      this.companyId,
      this.typeName,
      this.color,
      this.noOfLeaves,
      this.paid,
      this.monthlyLimit});

  LeaveTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    typeName = json['type_name'];
    color = json['color'];
    noOfLeaves = json['no_of_leaves'];
    paid = json['paid'];
    monthlyLimit = json['monthly_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['type_name'] = typeName;
    data['color'] = color;
    data['no_of_leaves'] = noOfLeaves;
    data['paid'] = paid;
    data['monthly_limit'] = monthlyLimit;
    return data;
  }
}
