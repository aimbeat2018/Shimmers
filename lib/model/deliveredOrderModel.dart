class DeliveredOrderModel {
  List<Data>? data;

  DeliveredOrderModel({this.data});

  DeliveredOrderModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? orderNumber;
  int? clientId;
  String? orderDate;
  int? total;
  String? status;
  String? note;
  int? no_of_products;

  Data(
      {this.id,
      this.orderNumber,
      this.clientId,
      this.orderDate,
      this.total,
      this.status,
      this.note,
      this.no_of_products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    clientId = json['client_id'];
    orderDate = json['order_date'];
    total = json['total'];
    status = json['status'];
    note = json['note'];
    no_of_products = json['no_of_products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['client_id'] = this.clientId;
    data['order_date'] = this.orderDate;
    data['total'] = this.total;
    data['status'] = this.status;
    data['note'] = this.note;
    data['no_of_products'] = this.no_of_products;
    return data;
  }
}
