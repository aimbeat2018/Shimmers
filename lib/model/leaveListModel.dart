class LeaveListModel {
  List<LeaveData>? data;

  LeaveListModel({this.data});

  LeaveListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LeaveData>[];
      json['data'].forEach((v) {
        data!.add(LeaveData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveData {
  int? id;
  int? userId;
  int? leaveTypeId;
  String? duration;
  String? leaveDate;
  int? month;
  String? reason;
  String? status;
  String? rejectReason;
  int? paid;
  String? approveReason;
  String? leaveType;
  String? date;

  LeaveData(
      {this.id,
      this.userId,
      this.leaveTypeId,
      this.duration,
      this.leaveDate,
      this.month,
      this.reason,
      this.status,
      this.rejectReason,
      this.paid,
      this.approveReason,
      this.leaveType,
      this.date});

  LeaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    leaveTypeId = json['leave_type_id'];
    duration = json['duration'];
    leaveDate = json['leave_date'];
    month = json['month'];
    reason = json['reason'];
    status = json['status'];
    rejectReason = json['reject_reason'];
    paid = json['paid'];
    approveReason = json['approve_reason'];
    leaveType = json['leave_type'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['leave_type_id'] = leaveTypeId;
    data['duration'] = duration;
    data['leave_date'] = leaveDate;
    data['month'] = month;
    data['reason'] = reason;
    data['status'] = status;
    data['reject_reason'] = rejectReason;
    data['paid'] = paid;
    data['approve_reason'] = approveReason;
    data['leave_type'] = leaveType;
    data['date'] = date;
    return data;
  }
}
