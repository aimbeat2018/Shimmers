class TourVisitModel {
  String? message;
  String? resubmitDate;
  String? executiveRemark;
  List<TourVisitDetailModel>? tourVisitDetailModel;

  TourVisitModel(
      {this.message, this.resubmitDate, this.executiveRemark, this.tourVisitDetailModel});

  TourVisitModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    resubmitDate = json['resubmit_date'];
    executiveRemark = json['visit_remark'];
    if (json['data'] != null) {
      tourVisitDetailModel = <TourVisitDetailModel>[];
      json['data'].forEach((v) {
        tourVisitDetailModel!.add(new TourVisitDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['resubmit_date'] = this.resubmitDate;
    data['visit_remark'] = this.executiveRemark;
    if (this.tourVisitDetailModel != null) {
      data['data'] = this.tourVisitDetailModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TourVisitDetailModel {
  String? salonName;
  String? mobile;
  String? existingBrand;
  String? commPhase;
  String? isOrder;
  int? orderValue;
  String? isSatisfy;

  TourVisitDetailModel(
      {this.salonName,
        this.mobile,
        this.existingBrand,
        this.commPhase,
        this.isOrder,
        this.orderValue,
        this.isSatisfy});

  TourVisitDetailModel.fromJson(Map<String, dynamic> json) {
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
