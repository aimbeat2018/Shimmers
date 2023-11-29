class OrderApprovalModel {
  List<OrderApproveDetail>? orderApproveDetail;

  OrderApprovalModel({this.orderApproveDetail});

  OrderApprovalModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orderApproveDetail = <OrderApproveDetail>[];
      json['data'].forEach((v) {
        orderApproveDetail!.add(new OrderApproveDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderApproveDetail != null) {
      data['data'] = this.orderApproveDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderApproveDetail {
  int? id;
  int? orderNumber;
  String? salonName;
  String? executiveName;
  String? orderDate;
  int? total;
  String? status;
  int? noOfProducts;

  OrderApproveDetail(
      {this.id,
        this.orderNumber,
        this.salonName,
        this.executiveName,
        this.orderDate,
        this.total,
        this.status,
        this.noOfProducts});

  OrderApproveDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    salonName = json['salon name'];
    executiveName = json['executive name'];
    orderDate = json['order_date'];
    total = json['total'];
    status = json['status'];
    noOfProducts = json['no_of_products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['salon name'] = this.salonName;
    data['executive name'] = this.executiveName;
    data['order_date'] = this.orderDate;
    data['total'] = this.total;
    data['status'] = this.status;
    data['no_of_products'] = this.noOfProducts;
    return data;
  }
}
