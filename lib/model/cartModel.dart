class CartModel {
  String? itemName;
  int? productId;
  int? quantity;
  int? costPerItem;
  int? discountValue;
  String? discountType;
  int? amount;
  int? afterDiscountAmount;
  String? itemSummary;

  CartModel(
      {this.itemName,
      this.productId,
      this.quantity,
      this.costPerItem,
      this.discountValue,
      this.discountType,
      this.amount,
      this.afterDiscountAmount,
      this.itemSummary});

  CartModel.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    productId = json['product_id'];
    quantity = json['quantity'];
    costPerItem = json['cost_per_item'];
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
    amount = json['amount'];
    afterDiscountAmount = json['after_discount_amount'];
    itemSummary = json['item_summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['cost_per_item'] = this.costPerItem;
    data['discount_value'] = this.discountValue;
    data['discount_type'] = this.discountType;
    data['amount'] = this.amount;
    data['after_discount_amount'] = this.afterDiscountAmount;
    data['item_summary'] = this.itemSummary;
    return data;
  }
}
