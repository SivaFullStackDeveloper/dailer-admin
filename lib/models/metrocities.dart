class MetroCity {
  final String id;
  final String metroCity;
  final String subCity;

  MetroCity({
    required this.id,
    required this.metroCity,
    required this.subCity,
  });

  factory MetroCity.fromJson(Map<String, dynamic> json) {
    return MetroCity(
      id: json['_id'],
      metroCity: json['metroCity'],
      subCity: json['subCity'],
    );
  }
}
