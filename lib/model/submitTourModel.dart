class SubmitTourModel {
  int? tourReqId;
  String? resubmitDate;
  String? executiveRemark;
  List<VisitData>? visitData;

  SubmitTourModel(
      {this.tourReqId,
        this.resubmitDate,
        this.executiveRemark,
        this.visitData});

  SubmitTourModel.fromJson(Map<String, dynamic> json) {
    tourReqId = json['tour_req_id'];
    resubmitDate = json['resubmit_date'];
    executiveRemark = json['visit_remark'];
    if (json['visit_data'] != null) {
      visitData = <VisitData>[];
      json['visit_data'].forEach((v) {
        visitData!.add(new VisitData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tour_req_id'] = this.tourReqId;
    data['resubmit_date'] = this.resubmitDate;
    data['visit_remark'] = this.executiveRemark;
    if (this.visitData != null) {
      data['visit_data'] = this.visitData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VisitData {
  String? salonName;
  String? mobile;
  String? existingBrand;
  String? commPhase;
  String? isOrder;
  int? orderValue;
  String? isSatisfy;

  VisitData(
      {this.salonName,
        this.mobile,
        this.existingBrand,
        this.commPhase,
        this.isOrder,
        this.orderValue,
        this.isSatisfy});

  VisitData.fromJson(Map<String, dynamic> json) {
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
