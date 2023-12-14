class EmployeeTargetDetail {
  List<Data>? data;

  EmployeeTargetDetail({this.data});

  EmployeeTargetDetail.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  int? assignedTarget;
  int? completedTarget;
  String? status;

  Data(
      {this.productName,
        this.assignedTarget,
        this.completedTarget,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    assignedTarget = json['assigned_target'];
    completedTarget = json['completed_target'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['assigned_target'] = this.assignedTarget;
    data['completed_target'] = this.completedTarget;
    data['status'] = this.status;
    return data;
  }
}
