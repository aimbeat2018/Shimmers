class LoginModel {
  bool? success;
  String? token;
  int? code;
  int? roleId;
  String? roleName;
  int? userId;
  int? passwordChanged;

  LoginModel(
      {this.success,
      this.token,
      this.code,
      this.roleId,
      this.roleName,
      this.userId,
      this.passwordChanged});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    code = json['code'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    userId = json['user_id'];
    passwordChanged = json['password_changed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['code'] = this.code;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['user_id'] = this.userId;
    data['password_changed'] = this.passwordChanged;
    return data;
  }
}
