class EmployeeTargetDetail {
  List<EmployeeTargetList>? data;

  EmployeeTargetDetail({this.data});

  EmployeeTargetDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EmployeeTargetList>[];
      json['data'].forEach((v) {
        data!.add(new EmployeeTargetList.fromJson(v));
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

class EmployeeTargetList {
  String? productName;
  int? assignedTarget;
  int? completedTarget;
  String? status;

  EmployeeTargetList(
      {this.productName,
        this.assignedTarget,
        this.completedTarget,
        this.status});

  EmployeeTargetList.fromJson(Map<String, dynamic> json) {
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
