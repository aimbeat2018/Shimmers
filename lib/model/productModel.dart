class ProductModel {
  List<ProductData>? data;

  ProductModel({this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
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

class ProductData {
  int? id;
  String? name;
  String? price;
  String? taxes;
  int? unitId;
  int? brandId;
  int? categoryId;
  int? quantity = 0;
  String? taxName;
  String? taxRatePercent;
  List<SuggestedProducts>? suggestedProducts;
  String? totalAmount;
  String? imageUrl;
  String? downloadFileUrl;
  String? tax;
  int? target = 0;

  ProductData(
      {this.id,
      this.name,
      this.price,
      this.taxes,
      this.unitId,
      this.brandId,
      this.categoryId,
      this.taxName,
      this.taxRatePercent,
      this.suggestedProducts,
      this.totalAmount,
      this.imageUrl,
      this.downloadFileUrl,
      this.tax});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    taxes = json['taxes'];
    unitId = json['unit_id'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    taxName = json['tax_name'];
    taxRatePercent = json['tax_rate_percent'];
    if (json['suggested_products'] != null) {
      suggestedProducts = <SuggestedProducts>[];
      json['suggested_products'].forEach((v) {
        suggestedProducts!.add(SuggestedProducts.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    imageUrl = json['image_url'];
    downloadFileUrl = json['download_file_url'];
    tax = json['tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['taxes'] = taxes;
    data['unit_id'] = unitId;
    data['brand_id'] = brandId;
    data['category_id'] = categoryId;
    data['tax_name'] = taxName;
    data['tax_rate_percent'] = taxRatePercent;
    if (suggestedProducts != null) {
      data['suggested_products'] =
          suggestedProducts!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    data['image_url'] = imageUrl;
    data['download_file_url'] = downloadFileUrl;
    data['tax'] = tax;
    return data;
  }
}

class SuggestedProducts {
  int? id;
  String? name;
  String? price;
  int? unitId;
  int? brandId;
  int? categoryId;
  int? quantity = 0;
  String? totalAmount;
  String? imageUrl;
  String? downloadFileUrl;
  String? tax;

  SuggestedProducts(
      {this.id,
      this.name,
      this.price,
      this.unitId,
      this.brandId,
      this.categoryId,
      this.totalAmount,
      this.imageUrl,
      this.downloadFileUrl,
      this.tax});

  SuggestedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    unitId = json['unit_id'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    totalAmount = json['total_amount'];
    imageUrl = json['image_url'];
    downloadFileUrl = json['download_file_url'];
    tax = json['tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['unit_id'] = unitId;
    data['brand_id'] = brandId;
    data['category_id'] = categoryId;
    data['total_amount'] = totalAmount;
    data['image_url'] = imageUrl;
    data['download_file_url'] = downloadFileUrl;
    data['tax'] = tax;
    return data;
  }
}
