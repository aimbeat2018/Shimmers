class SalonDataModel {
  List<SalonNameModel>? data;

  SalonDataModel({this.data});

  SalonDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SalonNameModel>[];
      json['data'].forEach((v) {
        data!.add(new SalonNameModel.fromJson(v));
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

class SalonNameModel {
  int? id;
  String? name;
  String? mobile;

  SalonNameModel({this.id, this.name, this.mobile});

  SalonNameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}
