class Cities {
  List<CitiesData>? data;

  Cities({this.data});

  Cities.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CitiesData>[];
      json['data'].forEach((v) {
        data!.add(new CitiesData.fromJson(v));
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

class CitiesData {
  String? sId;
  String? state;
  String? district;
  String? city;
  String? mandal;
  String? village;
  int? iV;

  CitiesData(
      {this.sId,
        this.state,
        this.district,
        this.city,
        this.mandal,
        this.village,
        this.iV});

  CitiesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    mandal = json['mandal'];
    village = json['village'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['mandal'] = this.mandal;
    data['village'] = this.village;
    data['__v'] = this.iV;
    return data;
  }
}