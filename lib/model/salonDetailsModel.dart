class SalonDetailsModel {
  SalonDetails? data;

  SalonDetailsModel({this.data});

  SalonDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SalonDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SalonDetails {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  int? locationId;
  String? address;
  String? shippingAddress;
  String? postalCode;
  String? state;
  String? image;
  String? city;
  int? isArchived;
  String? cityName;
  int? categoryId;
  int? subCategoryId;
  String? ownerName;
  String? number;
  String? stage;
  String? latitude;
  String? longitude;
  String? outstandingPayment;
  String? credit;
  String? categoryName;
  String? subCategoryName;
  List<SalonNotes>? salonNotes;
  int? scheduledCalls;
  String? imageUrl;
  int? is_clockin;

  SalonDetails(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.gender,
      this.image,
      this.locationId,
      this.address,
      this.shippingAddress,
      this.postalCode,
      this.state,
      this.city,
      this.isArchived,
      this.cityName,
      this.categoryId,
      this.subCategoryId,
      this.ownerName,
      this.number,
      this.stage,
      this.latitude,
      this.longitude,
      this.outstandingPayment,
      this.credit,
      this.categoryName,
      this.subCategoryName,
      this.salonNotes,
      this.scheduledCalls,
      this.imageUrl,
      this.is_clockin});

  SalonDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    image = json['image'];
    locationId = json['location_id'];
    address = json['address'];
    shippingAddress = json['shipping_address'];
    postalCode = json['postal_code'];
    state = json['state'];
    city = json['city'];
    isArchived = json['is_archived'];
    cityName = json['city_name'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    ownerName = json['owner_name'];
    number = json['number'];
    stage = json['stage'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    outstandingPayment = json['outstanding_payment'];
    credit = json['credit'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    if (json['salon_notes'] != null) {
      salonNotes = <SalonNotes>[];
      json['salon_notes'].forEach((v) {
        salonNotes!.add(SalonNotes.fromJson(v));
      });
    }
    scheduledCalls = json['scheduled_calls'];
    imageUrl = json['image_url'];
    is_clockin = json['is_clockin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['gender'] = gender;
    data['image'] = image;
    data['location_id'] = locationId;
    data['address'] = address;
    data['shipping_address'] = shippingAddress;
    data['postal_code'] = postalCode;
    data['state'] = state;
    data['city'] = city;
    data['is_archived'] = isArchived;
    data['city_name'] = cityName;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['owner_name'] = ownerName;
    data['number'] = number;
    data['stage'] = stage;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['outstanding_payment'] = outstandingPayment;
    data['credit'] = credit;
    data['category_name'] = categoryName;
    data['sub_category_name'] = subCategoryName;
    if (salonNotes != null) {
      data['salon_notes'] = salonNotes!.map((v) => v.toJson()).toList();
    }
    data['scheduled_calls'] = scheduledCalls;
    data['image_url'] = imageUrl;
    data['is_clockin'] = is_clockin;
    return data;
  }
}

class SalonNotes {
  int? id;
  int? clientId;
  String? details;
  int? addedBy;

  SalonNotes({this.id, this.clientId, this.details, this.addedBy});

  SalonNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    details = json['details'];
    addedBy = json['added_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['details'] = details;
    data['added_by'] = addedBy;
    return data;
  }
}
