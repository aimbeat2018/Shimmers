class TourVisitModel {
  String? message;
  List<TourVisitDetailModel>? tourVisitDetailModel;

  TourVisitModel({this.message, this.tourVisitDetailModel});

  TourVisitModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      tourVisitDetailModel = <TourVisitDetailModel>[];
      json['data'].forEach((v) {
        tourVisitDetailModel!.add(new TourVisitDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.tourVisitDetailModel != null) {
      data['data'] = this.tourVisitDetailModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TourVisitDetailModel {
  int? id;
  int? tourVisitId;
  String? date;
  String? time;
  String? area;
  String? role;
  String? name;
  String? contact;
  String? description;
  int? createdBy;

  TourVisitDetailModel(
      {this.id,
        this.tourVisitId,
        this.date,
        this.time,
        this.area,
        this.role,
        this.name,
        this.contact,
        this.description,
        this.createdBy});

  TourVisitDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tourVisitId = json['tour_visit_id'];
    date = json['date'];
    time = json['time'];
    area = json['area'];
    role = json['role'];
    name = json['name'];
    contact = json['contact'];
    description = json['description'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tour_visit_id'] = this.tourVisitId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['area'] = this.area;
    data['role'] = this.role;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    return data;
  }
}
