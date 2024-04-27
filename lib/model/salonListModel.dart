class SalonListModel {
  List<SalonDetailModel>? salondetailData;

  SalonListModel({this.salondetailData});

  SalonListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      salondetailData = <SalonDetailModel>[];
      json['data'].forEach((v) {
        salondetailData!.add(new SalonDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salondetailData != null) {
      data['data'] = this.salondetailData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalonDetailModel {
  int? id;
  String? name;
  String? image;
  String? latitude;
  String? longitude;
  String? address;
  String? distance;
  int? distributorId;
  String? distributorName;

  SalonDetailModel(
      {this.id,
        this.name,
        this.image,
        this.latitude,
        this.longitude,
        this.address,
        this.distance,
        this.distributorId,
        this.distributorName});

  SalonDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    distance = json['distance'];
    distributorId = json['distributor_id'];
    distributorName = json['distributor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['distance'] = this.distance;
    data['distributor_id'] = this.distributorId;
    data['distributor_name'] = this.distributorName;
    return data;
  }
}
