class StatesData {
  final List<String> totalStates;

  StatesData({required this.totalStates});

  factory StatesData.fromJson(Map<String, dynamic> json) {
    return StatesData(
      totalStates: List<String>.from(json['totalStates']),
    );
  }
}

class DistrictsData {
  final List<String> totalDistricts;

  DistrictsData({required this.totalDistricts});

  factory DistrictsData.fromJson(Map<String, dynamic> json) {
    return DistrictsData(
      totalDistricts: List<String>.from(json['totalDistricts']),
    );
  }
}

class CitiData {
  final String id;
  final String state;
  final String district;
  final String city;
  final int v;

  CitiData({
    required this.id,
    required this.state,
    required this.district,
    required this.city,
    required this.v,
  });

  factory CitiData.fromJson(Map<String, dynamic> json) {
    return CitiData(
      id: json['_id'],
      state: json['state'],
      district: json['district'],
      city: json['city'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'state': state,
      'district': district,
      'city': city,
      '__v': v,
    };
  }
}

