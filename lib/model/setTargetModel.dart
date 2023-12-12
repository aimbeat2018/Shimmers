class SetTargetModel {
  int? employeeId;
  List<ProductDataModel>? productData;

  SetTargetModel({this.employeeId, this.productData});

  SetTargetModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    if (json['product_data'] != null) {
      productData = <ProductDataModel>[];
      json['product_data'].forEach((v) {
        productData!.add(new ProductDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDataModel {
  int? productId;
  int? target=0;

  ProductDataModel({this.productId, this.target});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['target'] = this.target;
    return data;
  }
}
