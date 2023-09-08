class SalonCategoryModel {
  List<SalonCategoryData>? data;

  SalonCategoryModel({this.data});

  SalonCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SalonCategoryData>[];
      json['data'].forEach((v) {
        data!.add(SalonCategoryData.fromJson(v));
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

class SalonCategoryData {
  int? id;
  String? categoryName;

  SalonCategoryData({this.id, this.categoryName});

  SalonCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    return data;
  }
}
