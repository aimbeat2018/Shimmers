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
  int? id;
  String? brandName;
  int? brandAssignedTarget;
  int? brandCompletedTarget;
  String? brandTargetStatus;
  List<ProductData>? productData;

  EmployeeTargetList(
      {this.id,
        this.brandName,
        this.brandAssignedTarget,
        this.brandCompletedTarget,
        this.brandTargetStatus,
        this.productData});

  EmployeeTargetList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    brandAssignedTarget = json['brand_assigned_target'];
    brandCompletedTarget = json['brand_completed_target'];
    brandTargetStatus = json['brand_target_status'];
    if (json['product_data'] != null) {
      productData = <ProductData>[];
      json['product_data'].forEach((v) {
        productData!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['brand_assigned_target'] = this.brandAssignedTarget;
    data['brand_completed_target'] = this.brandCompletedTarget;
    data['brand_target_status'] = this.brandTargetStatus;
    if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? productName;
  int? assignedTarget;
  int? completedTarget;
  String? status;

  ProductData(
      {this.productName,
        this.assignedTarget,
        this.completedTarget,
        this.status});

  ProductData.fromJson(Map<String, dynamic> json) {
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
