class DistributorSalonListModel {
  List<DistributorSalonData>? data;

  DistributorSalonListModel({this.data});

  DistributorSalonListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DistributorSalonData>[];
      json['data'].forEach((v) {
        data!.add(new DistributorSalonData.fromJson(v));
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

class DistributorSalonData {
  String? distributorName;
  int? totalSalons;
  List<Salons>? salons;

  DistributorSalonData({this.distributorName, this.totalSalons, this.salons});

  DistributorSalonData.fromJson(Map<String, dynamic> json) {
    distributorName = json['distributor_name'];
    totalSalons = json['total_salons'];
    if (json['salons'] != null) {
      salons = <Salons>[];
      json['salons'].forEach((v) {
        salons!.add(new Salons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distributor_name'] = this.distributorName;
    data['total_salons'] = this.totalSalons;
    if (this.salons != null) {
      data['salons'] = this.salons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Salons {
  int? id;
  String? name;
  String? image;
  String? latitude;
  String? longitude;
  String? address;
  String? distance;

  Salons(
      {this.id,
      this.name,
      this.image,
      this.latitude,
      this.longitude,
      this.address,
      this.distance});

  Salons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    distance = json['distance'];
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
    return data;
  }
}
