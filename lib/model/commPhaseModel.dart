class CommPhaseModel {
  List<CommunicationPhase>? data;

  CommPhaseModel({this.data});

  CommPhaseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CommunicationPhase>[];
      json['data'].forEach((v) {
        data!.add(new CommunicationPhase.fromJson(v));
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

class CommunicationPhase {
  int? id;
  String? name;

  CommunicationPhase({this.id, this.name});

  CommunicationPhase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
