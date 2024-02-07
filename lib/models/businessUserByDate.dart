class BusinessByDate {
  List<Datum> data;

  BusinessByDate({
    required this.data,
  });

  factory BusinessByDate.fromJson(Map<String, dynamic> json) => BusinessByDate(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  int viwersCount;
  String userId;
  String businessName;
  String mailId;
  String phoneNum1;
  String phoneNumAlternative;
  String district;
  String cityName;
  String stateName;
  String address;
  String category;
  String subcategories;
  String pinCode;
  String isLoggedIn;
  String webLink;
  String businessCoverPhoto;
  String businessProfilePhoto;
  List<String> businessGallery;
  int rating;
  String paymentsAccepted;
  String yearOfEstablishment;
  String businessAboutUs;
  String workingHours;
  String keyWords;
  String location;
  String socialMediaLink;
  String languageSpoken;
  String parkingAvilbility;
  String videoTestimons;
  String numberOfStaff;
  String achivementsAwards;
  String fastResponseTime;
  int currentResponseTime;
  String getDicrection;
  bool verified;
  List<String> holidays;
  List<dynamic> ratingAndComments;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.viwersCount,
    required this.userId,
    required this.businessName,
    required this.mailId,
    required this.phoneNum1,
    required this.phoneNumAlternative,
    required this.district,
    required this.cityName,
    required this.stateName,
    required this.address,
    required this.category,
    required this.subcategories,
    required this.pinCode,
    required this.isLoggedIn,
    required this.webLink,
    required this.businessCoverPhoto,
    required this.businessProfilePhoto,
    required this.businessGallery,
    required this.rating,
    required this.paymentsAccepted,
    required this.yearOfEstablishment,
    required this.businessAboutUs,
    required this.workingHours,
    required this.keyWords,
    required this.location,
    required this.socialMediaLink,
    required this.languageSpoken,
    required this.parkingAvilbility,
    required this.videoTestimons,
    required this.numberOfStaff,
    required this.achivementsAwards,
    required this.fastResponseTime,
    required this.currentResponseTime,
    required this.getDicrection,
    required this.verified,
    required this.holidays,
    required this.ratingAndComments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    viwersCount: json["viwersCount"],
    userId: json["userId"],
    businessName: json["businessName"],
    mailId: json["mailId"],
    phoneNum1: json["phoneNum1"],
    phoneNumAlternative: json["phoneNumAlternative"],
    district: json["district"],
    cityName: json["cityName"],
    stateName: json["stateName"],
    address: json["address"],
    category: json["category"],
    subcategories: json["subcategories"],
    pinCode: json["PinCode"],
    isLoggedIn: json["isLoggedIn"],
    webLink: json["WebLink"],
    businessCoverPhoto: json["businessCoverPhoto"],
    businessProfilePhoto: json["businessProfilePhoto"],
    businessGallery: List<String>.from(json["businessGallery"].map((x) => x)),
    rating: json["rating"],
    paymentsAccepted: json["paymentsAccepted"],
    yearOfEstablishment: json["yearOfEstablishment"],
    businessAboutUs: json["businessAboutUs"],
    workingHours: json["workingHours"],
    keyWords: json["keyWords"],
    location: json["location"],
    socialMediaLink: json["socialMediaLink"],
    languageSpoken: json["languageSpoken"],
    parkingAvilbility: json["parkingAvilbility"],
    videoTestimons: json["videoTestimons"],
    numberOfStaff: json["numberOfStaff"],
    achivementsAwards: json["achivementsAwards"],
    fastResponseTime: json["fastResponseTime"],
    currentResponseTime: json["currentResponseTime"],
    getDicrection: json["getDicrection"],
    verified: json["verified"],
    holidays: List<String>.from(json["holidays"].map((x) => x)),
    ratingAndComments: List<dynamic>.from(json["ratingAndComments"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "viwersCount": viwersCount,
    "userId": userId,
    "businessName": businessName,
    "mailId": mailId,
    "phoneNum1": phoneNum1,
    "phoneNumAlternative": phoneNumAlternative,
    "district": district,
    "cityName": cityName,
    "stateName": stateName,
    "address": address,
    "category": category,
    "subcategories": subcategories,
    "PinCode": pinCode,
    "isLoggedIn": isLoggedIn,
    "WebLink": webLink,
    "businessCoverPhoto": businessCoverPhoto,
    "businessProfilePhoto": businessProfilePhoto,
    "businessGallery": List<dynamic>.from(businessGallery.map((x) => x)),
    "rating": rating,
    "paymentsAccepted": paymentsAccepted,
    "yearOfEstablishment": yearOfEstablishment,
    "businessAboutUs": businessAboutUs,
    "workingHours": workingHours,
    "keyWords": keyWords,
    "location": location,
    "socialMediaLink": socialMediaLink,
    "languageSpoken": languageSpoken,
    "parkingAvilbility": parkingAvilbility,
    "videoTestimons": videoTestimons,
    "numberOfStaff": numberOfStaff,
    "achivementsAwards": achivementsAwards,
    "fastResponseTime": fastResponseTime,
    "currentResponseTime": currentResponseTime,
    "getDicrection": getDicrection,
    "verified": verified,
    "holidays": List<dynamic>.from(holidays.map((x) => x)),
    "ratingAndComments": List<dynamic>.from(ratingAndComments.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
