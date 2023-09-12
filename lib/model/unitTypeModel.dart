class UnitTypeModel {
  List<UnitTypeData>? data;

  UnitTypeModel({this.data});

  UnitTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UnitTypeData>[];
      json['data'].forEach((v) {
        data!.add(UnitTypeData.fromJson(v));
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

class UnitTypeData {
  int? id;
  String? unitType;

  UnitTypeData({this.id, this.unitType});

  UnitTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitType = json['unit_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_type'] = unitType;
    return data;
  }
}
