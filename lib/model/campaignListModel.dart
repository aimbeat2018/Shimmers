class CampaignListModel {
  List<CampaignListData>? data;

  CampaignListModel({this.data});

  CampaignListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CampaignListData>[];
      json['data'].forEach((v) {
        data!.add(CampaignListData.fromJson(v));
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

class CampaignListData {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? status;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  CampaignListData(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.status,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  CampaignListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}
