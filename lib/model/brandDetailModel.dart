class BrandDetailModel {
  List<BrandListData>? data;

  BrandDetailModel({this.data});

  BrandDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BrandListData>[];
      json['data'].forEach((v) {
        data!.add(new BrandListData.fromJson(v));
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

class BrandListData {
  int? id;
  String? brandName;

  BrandListData({this.id, this.brandName});

  BrandListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    return data;
  }
}
