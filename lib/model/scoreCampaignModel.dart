class ScoreCampaignModel {
  List<Data>? data;

  ScoreCampaignModel({this.data});

  ScoreCampaignModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? campaignId;
  String? campaignName;
  String? startDate;
  String? endDate;
  String? status;
  int? salonId;
  String? salonName;

  Data(
      {this.campaignId,
        this.campaignName,
        this.startDate,
        this.endDate,
        this.status,
        this.salonId,
        this.salonName});

  Data.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaign_id'];
    campaignName = json['campaign_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    salonId = json['salon_id'];
    salonName = json['salon_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_id'] = this.campaignId;
    data['campaign_name'] = this.campaignName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['salon_id'] = this.salonId;
    data['salon_name'] = this.salonName;
    return data;
  }
}
