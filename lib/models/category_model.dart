
class Categories {
  final String id;
  final String categoryName;
  final String subCategory;
  final String keyWords;
  final int v;

  Categories({
    required this.id,
    required this.categoryName,
    required this.subCategory,
    required this.keyWords,
    required this.v,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['_id'],
      categoryName: json['categoryName'],
      subCategory: json['subCategory'],
      keyWords: json['keyWords'],
      v: json['__v'],
    );
  }
}

