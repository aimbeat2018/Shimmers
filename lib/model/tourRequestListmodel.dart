class TourRequestListModel {
  String? message;
  List<TourRequestDetails>? tourRequestList;

  TourRequestListModel({this.message, this.tourRequestList});

  TourRequestListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      tourRequestList = <TourRequestDetails>[];
      json['data'].forEach((v) {
        tourRequestList!.add(new TourRequestDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.tourRequestList != null) {
      data['data'] = this.tourRequestList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TourRequestDetails {
  int? id;
  String? name;
  String? travelFrom;
  String? travelTo;
  String? deptDate;
  String? returnDate;
  String? checkinDate;
  String? checkoutDate;
  String? rsmName;
  String? executiveRemark;
  int? noOfDays;
  int? noOfDemos;
  int? userId;
  int? roleId;
  String? officeRemark;
  int? acceptedBy;
  String? description;
  int? status;
  String? remark;
  String? attachment;
  int? isVisited;
  int? hotel;
  int? osAllowance;
  int? tavelTickets;
  int? other;
  int? total;
  int? createdBy;

  TourRequestDetails(
      {this.id,
        this.name,
        this.travelFrom,
        this.travelTo,
        this.deptDate,
        this.returnDate,
        this.checkinDate,
        this.checkoutDate,
        this.rsmName,
        this.executiveRemark,
        this.noOfDays,
        this.noOfDemos,
        this.userId,
        this.roleId,
        this.officeRemark,
        this.acceptedBy,
        this.description,
        this.status,
        this.remark,
        this.attachment,
        this.isVisited,
        this.hotel,
        this.osAllowance,
        this.tavelTickets,
        this.other,
        this.total,
        this.createdBy});

  TourRequestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    travelFrom = json['travel_from'];
    travelTo = json['travel_to'];
    deptDate = json['dept_date'];
    returnDate = json['return_date'];
    checkinDate = json['checkin_date'];
    checkoutDate = json['checkout_date'];
    rsmName = json['rsm_name'];
    executiveRemark = json['executive_remark'];
    noOfDays = json['no_of_days'];
    noOfDemos = json['no_of_demos'];
    userId = json['user_id'];
    roleId = json['role_id'];
    officeRemark = json['office_remark'];
    acceptedBy = json['accepted_by'];
    description = json['description'];
    status = json['status'];
    remark = json['remark'];
    attachment = json['attachment'];
    isVisited = json['is_visited'];
    hotel = json['hotel'];
    osAllowance = json['os_allowance'];
    tavelTickets = json['tavel_tickets'];
    other = json['other'];
    total = json['total'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['travel_from'] = this.travelFrom;
    data['travel_to'] = this.travelTo;
    data['dept_date'] = this.deptDate;
    data['return_date'] = this.returnDate;
    data['checkin_date'] = this.checkinDate;
    data['checkout_date'] = this.checkoutDate;
    data['rsm_name'] = this.rsmName;
    data['executive_remark'] = this.executiveRemark;
    data['no_of_days'] = this.noOfDays;
    data['no_of_demos'] = this.noOfDemos;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['office_remark'] = this.officeRemark;
    data['accepted_by'] = this.acceptedBy;
    data['description'] = this.description;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['attachment'] = this.attachment;
    data['is_visited'] = this.isVisited;
    data['hotel'] = this.hotel;
    data['os_allowance'] = this.osAllowance;
    data['tavel_tickets'] = this.tavelTickets;
    data['other'] = this.other;
    data['total'] = this.total;
    data['created_by'] = this.createdBy;
    return data;
  }
}
