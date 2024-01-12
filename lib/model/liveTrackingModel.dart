class LiveTrackingModel {
  List<LiveTrackList>? data;

  LiveTrackingModel({this.data});

  LiveTrackingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LiveTrackList>[];
      json['data'].forEach((v) {
        data!.add(new LiveTrackList.fromJson(v));
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

class LiveTrackList {
  int? id;
  String? name;
  int? salonId;
  String? salonName;
  String? clockInTime;
  String? latitude;
  String? longitude;

  LiveTrackList(
      {this.id,
        this.name,
        this.salonId,
        this.salonName,
        this.clockInTime,
        this.latitude,
        this.longitude});

  LiveTrackList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    salonId = json['salon_id'];
    salonName = json['salon_name'];
    clockInTime = json['clock_in_time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['salon_id'] = this.salonId;
    data['salon_name'] = this.salonName;
    data['clock_in_time'] = this.clockInTime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
