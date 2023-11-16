class TRFExecutiveProfile {
  List<TRFExecutiveProfileDetail>? data;

  TRFExecutiveProfile({this.data});

  TRFExecutiveProfile.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TRFExecutiveProfileDetail>[];
      json['data'].forEach((v) {
        data!.add(new TRFExecutiveProfileDetail.fromJson(v));
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

class TRFExecutiveProfileDetail {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? status;

  TRFExecutiveProfileDetail({this.id, this.name, this.email, this.mobile, this.status});

  TRFExecutiveProfileDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['status'] = this.status;
    return data;
  }
}
