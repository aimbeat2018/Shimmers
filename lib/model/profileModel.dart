class ProfileModel {
  UserProfile? userProfile;

  ProfileModel({this.userProfile});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userProfile =
        json['data'] != null ? UserProfile.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (userProfile != null) {
      data['data'] = userProfile!.toJson();
    }
    return data;
  }
}

class UserProfile {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  int? locationId;
  String? status;
  String? loginStatus;
  String? image;
  int? routeId;
  String? address;
  int? departmentId;
  int? designationId;
  String? joiningDate;
  String? dateOfBirth;
  int? reportingTo;
  String? employmentType;
  String? maritalStatus;
  String? designationName;
  String? departmentName;
  String? locationName;
  String? routeName;
  String? imageUrl;

  UserProfile(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.gender,
      this.locationId,
      this.status,
      this.loginStatus,
      this.image,
      this.routeId,
      this.address,
      this.departmentId,
      this.designationId,
      this.joiningDate,
      this.dateOfBirth,
      this.reportingTo,
      this.employmentType,
      this.maritalStatus,
      this.designationName,
      this.departmentName,
      this.locationName,
      this.routeName,
      this.imageUrl});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    locationId = json['location_id'];
    status = json['status'];
    loginStatus = json['login_status'];
    image = json['image'];
    routeId = json['route_id'];
    address = json['address'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    joiningDate = json['joining_date'];
    dateOfBirth = json['date_of_birth'];
    reportingTo = json['reporting_to'];
    employmentType = json['employment_type'];
    maritalStatus = json['marital_status'];
    designationName = json['designation_name'];
    departmentName = json['department_name'];
    locationName = json['location_name'];
    routeName = json['route_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['gender'] = gender;
    data['location_id'] = locationId;
    data['status'] = status;
    data['login_status'] = loginStatus;
    data['image'] = image;
    data['route_id'] = routeId;
    data['address'] = address;
    data['department_id'] = departmentId;
    data['designation_id'] = designationId;
    data['joining_date'] = joiningDate;
    data['date_of_birth'] = dateOfBirth;
    data['reporting_to'] = reportingTo;
    data['employment_type'] = employmentType;
    data['marital_status'] = maritalStatus;
    data['designation_name'] = designationName;
    data['department_name'] = departmentName;
    data['location_name'] = locationName;
    data['route_name'] = routeName;
    data['image_url'] = imageUrl;
    return data;
  }
}
