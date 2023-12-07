class SalonVisitModel {
  String? salonName;
  String? mobile;
  String? existingBrand;
  String? commPhase;
  String? isOrder;
  int? orderValue;
  String? isSatisfy;

  SalonVisitModel(
      {this.salonName,
        this.mobile,
        this.existingBrand,
        this.commPhase,
        this.isOrder,
        this.orderValue,
        this.isSatisfy});

  SalonVisitModel.fromJson(Map<String, dynamic> json) {
    salonName = json['salon_name'];
    mobile = json['mobile'];
    existingBrand = json['existing_brand'];
    commPhase = json['comm_phase'];
    isOrder = json['is_order'];
    orderValue = json['order_value'];
    isSatisfy = json['is_satisfy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salon_name'] = this.salonName;
    data['mobile'] = this.mobile;
    data['existing_brand'] = this.existingBrand;
    data['comm_phase'] = this.commPhase;
    data['is_order'] = this.isOrder;
    data['order_value'] = this.orderValue;
    data['is_satisfy'] = this.isSatisfy;
    return data;
  }
}
