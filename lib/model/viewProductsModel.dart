class ViewProductsModel {
  String? message;
  List<Data>? data;

  ViewProductsModel({this.message, this.data});

  ViewProductsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? orderId;
  int? productId;
  String? itemName;
  int? amount;
  int? standalonDiscount;
  int? discountValue;
  String? afterDiscountAmount;
  String? default_image;

  Data(
      {this.id,
        this.orderId,
        this.productId,
        this.itemName,
        this.amount,
        this.standalonDiscount,
        this.discountValue,
        this.afterDiscountAmount,
      this.default_image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    itemName = json['item_name'];
    amount = json['amount'];
    standalonDiscount = json['standalon_discount'];
    discountValue = json['discount_value'];
    afterDiscountAmount = json['after_discount_amount'];
    default_image = json['default_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['item_name'] = this.itemName;
    data['amount'] = this.amount;
    data['standalon_discount'] = this.standalonDiscount;
    data['discount_value'] = this.discountValue;
    data['after_discount_amount'] = this.afterDiscountAmount;
    data['default_image'] = this.default_image;
    return data;
  }
}
