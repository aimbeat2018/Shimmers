class DistributorListModel {
  List<DistributorData>? data;

  DistributorListModel({this.data});

  DistributorListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DistributorData>[];
      json['data'].forEach((v) {
        data!.add(new DistributorData.fromJson(v));
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

class DistributorData {
  int? id;
  String? name;
  String? address;
  String? shippingAddress;
  String? state;
  String? city;
  int? routeId;

  DistributorData(
      {this.id,
      this.name,
      this.address,
      this.shippingAddress,
      this.state,
      this.city,
      this.routeId});

  DistributorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    shippingAddress = json['shipping_address'];
    state = json['state'];
    city = json['city'];
    routeId = json['route_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['shipping_address'] = this.shippingAddress;
    data['state'] = this.state;
    data['city'] = this.city;
    data['route_id'] = this.routeId;
    return data;
  }
}
