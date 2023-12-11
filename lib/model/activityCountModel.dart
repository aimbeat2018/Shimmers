class ActivityCountModel {
  String? name;
  String? mobile;
  String? role;
  String? profileImage;
  int? salonCreated;
  int? salonVisit;
  int? salonOrderValue;
  int? assignedTarget;
  int? completedTarget;
  int? feedback;
  int? demo;
  int? paymentCollect;
  int? campaign;

  ActivityCountModel(
      {this.name,
        this.mobile,
        this.role,
        this.profileImage,
        this.salonCreated,
        this.salonVisit,
        this.salonOrderValue,
        this.assignedTarget,
        this.completedTarget,
        this.feedback,
        this.demo,
        this.paymentCollect,
        this.campaign});

  ActivityCountModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    role = json['role'];
    profileImage = json['profile_image'];
    salonCreated = json['salon_created'];
    salonVisit = json['salon_visit'];
    salonOrderValue = json['salon_order_value'];
    assignedTarget = json['assigned_target'];
    completedTarget = json['completed_target'];
    feedback = json['feedback'];
    demo = json['demo'];
    paymentCollect = json['payment_collect'];
    campaign = json['campaign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['role'] = this.role;
    data['profile_image'] = this.profileImage;
    data['salon_created'] = this.salonCreated;
    data['salon_visit'] = this.salonVisit;
    data['salon_order_value'] = this.salonOrderValue;
    data['assigned_target'] = this.assignedTarget;
    data['completed_target'] = this.completedTarget;
    data['feedback'] = this.feedback;
    data['demo'] = this.demo;
    data['payment_collect'] = this.paymentCollect;
    data['campaign'] = this.campaign;
    return data;
  }
}
