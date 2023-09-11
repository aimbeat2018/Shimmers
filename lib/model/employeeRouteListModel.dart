class EmployeeRouteListModel {
  List<EmpRouteModel>? data;

  EmployeeRouteListModel({this.data});

  EmployeeRouteListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EmpRouteModel>[];
      json['data'].forEach((v) {
        data!.add(EmpRouteModel.fromJson(v));
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

class EmpRouteModel {
  int? id;
  String? name;

  EmpRouteModel({this.id, this.name});

  EmpRouteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
