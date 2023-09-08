class SalonRouteModel {
  SalonRouteData? salonRouteData;

  SalonRouteModel({this.salonRouteData});

  SalonRouteModel.fromJson(Map<String, dynamic> json) {
    salonRouteData =
        json['data'] != null ? SalonRouteData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salonRouteData != null) {
      data['data'] = salonRouteData!.toJson();
    }
    return data;
  }
}

class SalonRouteData {
  List<RouteModel>? salons;

  SalonRouteData({this.salons});

  SalonRouteData.fromJson(Map<String, dynamic> json) {
    if (json['salons'] != null) {
      salons = <RouteModel>[];
      json['salons'].forEach((v) {
        salons!.add(RouteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salons != null) {
      data['salons'] = salons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RouteModel {
  int? distributorId;
  String? distributorName;
  String? cityName;
  int? totalSalons;
  List<SalonsModel>? salons;

  RouteModel(
      {this.distributorId,
      this.distributorName,
      this.cityName,
      this.totalSalons,
      this.salons});

  RouteModel.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributor_id'];
    distributorName = json['distributor_name'];
    cityName = json['city_name'];
    totalSalons = json['total_salons'];
    if (json['salons'] != null) {
      salons = <SalonsModel>[];
      json['salons'].forEach((v) {
        salons!.add(SalonsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distributor_id'] = distributorId;
    data['distributor_name'] = distributorName;
    data['city_name'] = cityName;
    data['total_salons'] = totalSalons;
    if (salons != null) {
      data['salons'] = salons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalonsModel {
  int? id;
  String? name;
  String? image;
  String? latitude;
  String? longitude;
  String? address;
  String? distance;

  SalonsModel(
      {this.id,
      this.name,
      this.image,
      this.latitude,
      this.longitude,
      this.address,
      this.distance});

  SalonsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['distance'] = distance;
    return data;
  }
}
