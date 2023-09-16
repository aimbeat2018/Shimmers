class EmployeeListModel {
  EmployeeData? data;

  EmployeeListModel({this.data});

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? EmployeeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EmployeeData {
  int? teamMembersCount;
  List<Members>? members;

  EmployeeData({this.teamMembersCount, this.members});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    teamMembersCount = json['team_members_count'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_members_count'] = teamMembersCount;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? status;
  int? roleId;
  String? role;
  List<Hierarchy>? hierarchy;
  String? imageUrl;

  Members(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.status,
      this.roleId,
      this.role,
      this.hierarchy,
      this.imageUrl});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    roleId = json['role_id'];
    role = json['role'];
    if (json['hierarchy'] != null) {
      hierarchy = <Hierarchy>[];
      json['hierarchy'].forEach((v) {
        hierarchy!.add(Hierarchy.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
    data['role_id'] = roleId;
    data['role'] = role;
    if (hierarchy != null) {
      data['hierarchy'] = hierarchy!.map((v) => v.toJson()).toList();
    }
    data['image_url'] = imageUrl;
    return data;
  }
}

class Hierarchy {
  int? id;
  String? name;

  Hierarchy({this.id, this.name});

  Hierarchy.fromJson(Map<String, dynamic> json) {
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
