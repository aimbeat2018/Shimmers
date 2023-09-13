import 'package:shimmers/model/cartModel.dart';

class PlaceOrderModel {
  int? clientId;
  String? shippingAddress;
  String? address;
  int? unitTypeId;
  List<CartModel>? products;
  int? subTotal;
  int? afterSubTotal;
  String? note;

  PlaceOrderModel(
      {this.clientId,
      this.shippingAddress,
      this.address,
      this.unitTypeId,
      this.products,
      this.subTotal,
      this.afterSubTotal,
      this.note});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    shippingAddress = json['shipping_address'];
    address = json['address'];
    unitTypeId = json['unit_type_id'];
    if (json['products'] != null) {
      products = <CartModel>[];
      json['products'].forEach((v) {
        products!.add(new CartModel.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    afterSubTotal = json['after_sub_total'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['shipping_address'] = this.shippingAddress;
    data['address'] = this.address;
    data['unit_type_id'] = this.unitTypeId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['sub_total'] = this.subTotal;
    data['after_sub_total'] = this.afterSubTotal;
    data['note'] = this.note;
    return data;
  }
}

// class Products {
//   String? itemName;
//   int? productId;
//   int? quantity;
//   int? costPerItem;
//   int? discountValue;
//   String? discountType;
//   int? amount;
//   int? afterDiscountAmount;
//   // String? itemSummary;
//
//   Products(
//       {this.itemName,
//       this.productId,
//       this.quantity,
//       this.costPerItem,
//       this.discountValue,
//       this.discountType,
//       this.amount,
//       this.afterDiscountAmount,
//       this.itemSummary});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     itemName = json['item_name'];
//     productId = json['product_id'];
//     quantity = json['quantity'];
//     costPerItem = json['cost_per_item'];
//     discountValue = json['discount_value'];
//     discountType = json['discount_type'];
//     amount = json['amount'];
//     afterDiscountAmount = json['after_discount_amount'];
//     itemSummary = json['item_summary'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['item_name'] = this.itemName;
//     data['product_id'] = this.productId;
//     data['quantity'] = this.quantity;
//     data['cost_per_item'] = this.costPerItem;
//     data['discount_value'] = this.discountValue;
//     data['discount_type'] = this.discountType;
//     data['amount'] = this.amount;
//     data['after_discount_amount'] = this.afterDiscountAmount;
//     data['item_summary'] = this.itemSummary;
//     return data;
//   }
// }
