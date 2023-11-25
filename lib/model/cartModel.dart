class CartModel {
  String? itemName;
  String? image;
  int? productId;
  int? quantity;
  int? discountValue;
  String? discountType;
  int? amount;
  int? amountWithQty;
  int? afterDiscountAmount;
  int? standalon_discount;
  String? itemSummary;

  CartModel(
      {this.itemName,
      this.image,
      this.productId,
      this.quantity,
      // this.costPerItem,
      this.discountValue,
      this.amountWithQty,
      this.discountType,
      this.amount,
      this.afterDiscountAmount,
      this.standalon_discount,
      this.itemSummary});

  CartModel.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    productId = json['product_id'];
    image = json['image'];
    quantity = json['quantity'];
    amount = json['cost_per_item'];
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
    amountWithQty = json['amount'];
    afterDiscountAmount = json['after_discount_amount'];
    standalon_discount = json['standalon_discount'];
    itemSummary = json['item_summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['image'] = this.image;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['cost_per_item'] = this.amount;
    data['discount_value'] = this.discountValue;
    data['discount_type'] = this.discountType;
    data['amount'] = this.amountWithQty;
    data['after_discount_amount'] = this.afterDiscountAmount;
    data['standalon_discount'] = this.standalon_discount;
    data['item_summary'] = this.itemSummary;
    return data;
  }
}
