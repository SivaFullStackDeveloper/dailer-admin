class CombinedUserData {
  final User user;
  final BusinessUser businessUser;

  CombinedUserData({required this.user, required this.businessUser});

  factory CombinedUserData.fromJson(Map<String, dynamic> json) {
    return CombinedUserData(
      user: json['user'] != null ? User.fromJson(json['user']) : User(id:  "", name:  "User Not Found", jobTitle:  "", companyName:  "", password:  "", email:  "", phoneNumber:  0, alternateNumber:  "", webLink:  "", city:  "", district:  "", state:  "", pinCode:  "", type:  "", businessRegister: false, userBlocked: false, active: false, createdAt:  "", updatedAt:  "", v:  0, profilePicture:  ""),
      businessUser: json['businessUser'] != null ? BusinessUser.fromJson(json['businessUser']) : BusinessUser(id: "", viwersCount:  0, userId:  "", businessName:   "Business Account Not found", mailId:  "", phoneNum1: '0', phoneNumAlternative:  "", cityName:  "", stateName:  "", address:  "", category:  "", subcategories:  "", PinCode:  "", isLoggedIn:  "", WebLink:  "", businessCoverPhoto:  "", businessProfilePhoto:  "", businessGallery:  [], rating:  0, paymentsAccepted:  "", yearOfEstablishment:  "", businessAboutUs:  "", workingHours:  "", keyWords:  "", location:  "", socialMediaLink:  "", languageSpoken:  "", parkingAvilbility:  "", videoTestimons:  "", numberOfStaff:  "", achivementsAwards:  "", fastResponseTime:  "", currentResponseTime:  0, getDicrection:  "", verified:  false, holidays:  [], ratingAndComments: [], createdAt:  "", updatedAt:  "", v:  0),
    );
  }
}




class UserData {
  final User user;
  final BusinessUser businessUser;

  UserData({required this.user, required this.businessUser});

  factory UserData.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> userMap = json['user'];
    final Map<String, dynamic> businessUserMap = json['businessUser'];

    return UserData(
      user: User.fromJson(userMap),
      businessUser: BusinessUser.fromJson(businessUserMap),
    );
  }
}

class User {
 String id;
 String name;
 String jobTitle;
 String companyName;
 String password;
 String email;
 int phoneNumber;
 String alternateNumber;
 String webLink;
 String city;
 String district;
 String state;
 String pinCode;
 String type;
   bool businessRegister;
   bool userBlocked;
   bool active;
   String createdAt;
   String updatedAt;
   int v;
   String profilePicture;

  User({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.companyName,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.alternateNumber,
    required this.webLink,
    required this.city,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.type,
    required this.businessRegister,
    required this.userBlocked,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      jobTitle: json['jobTitle'],
      companyName: json['companyName'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      alternateNumber: json['alternateNumber'],
      webLink: json['webLink'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      pinCode: json['pinCode'],
      type: json['type'],
      businessRegister: json['businessRegister'],
      userBlocked: json['userBlocked'],
      active: json['active'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      profilePicture: json['profilePicture'],
    );
  }
}

class BusinessUser {
   String id;
   int    viwersCount;
   String userId;
   String businessName;
   String mailId;
   String phoneNum1;
   String phoneNumAlternative;
   String cityName;
   String stateName;
   String address;
   String category;
   String subcategories;
   String PinCode;
   String isLoggedIn;
   String WebLink;
   String businessCoverPhoto;
   String businessProfilePhoto;
List<String>       businessGallery;
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
   List<RatingAndComment> ratingAndComments;
   String createdAt;
   String updatedAt;
   int v;

  BusinessUser({
    required this.id,
    required this.viwersCount,
    required this.userId,
    required this.businessName,
    required this.mailId,
    required this.phoneNum1,
    required this.phoneNumAlternative,
    required this.cityName,
    required this.stateName,
    required this.address,
    required this.category,
    required this.subcategories,
    required this.PinCode,
    required this.isLoggedIn,
    required this.WebLink,
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

  factory BusinessUser.fromJson(Map<String, dynamic> json) {
    return BusinessUser(
      id: json['_id']??"",
      viwersCount: json['viwersCount']??"",
      userId: json['userId']??"",
      businessName: json['businessName']??"",
      mailId: json['mailId']??"",
      phoneNum1: json['phoneNum1']??"",
      phoneNumAlternative: json['phoneNumAlternative']??"",
      cityName: json['cityName']??"",
      stateName: json['stateName']??"",
      address: json['address']??"",
      category: json['category']??"",
      subcategories: json['subcategories']??"",
      PinCode: json['PinCode']??"",
      isLoggedIn: json['isLoggedIn']??"",
      WebLink: json['WebLink']??"",
      businessCoverPhoto: json['businessCoverPhoto']??"",
      businessProfilePhoto: json['businessProfilePhoto']??"",
      businessGallery: List<String>.from(json['businessGallery'])??[],
      rating: json['rating']??"",
      paymentsAccepted: json['paymentsAccepted']??"",
      yearOfEstablishment: json['yearOfEstablishment']??"",
      businessAboutUs: json['businessAboutUs']??"",
      workingHours: json['workingHours']??"",
      keyWords: json['keyWords']??"",
      location: json['location']??"",
      socialMediaLink: json['socialMediaLink']??"",
      languageSpoken: json['languageSpoken']??"",
      parkingAvilbility: json['parkingAvilbility']??"",
      videoTestimons: json['videoTestimons']??"",
      numberOfStaff: json['numberOfStaff']??"",
      achivementsAwards: json['achivementsAwards']??"",
      fastResponseTime: json['fastResponseTime']??"",
      currentResponseTime: json['currentResponseTime']??"",
      getDicrection: json['getDicrection']??"",
      verified: json['verified']??"",
      holidays: List<String>.from(json['holidays'])??[],
      ratingAndComments: List<RatingAndComment>.from(parseRatingAndCommentsList(json['ratingAndComments']))??[],
    createdAt: json['createdAt']??'',
      updatedAt: json['updatedAt']??"",
      v: json['__v']??"",
    );
  }
}


class RatingAndComment {
  final String userName;
  final int rating;
  final String comment;
  final String userId;
  final String profilePicture;
  final List<Like> likes;
  final String id;
  final String createdAt;
  final String updatedAt;

  RatingAndComment({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.userId,
    required this.profilePicture,
    required this.likes,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RatingAndComment.fromJson(Map<String, dynamic> json) {
    return RatingAndComment(
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      userId: json['userId'],
      profilePicture: json['profilePicture'],
      likes: (json['likes'] as List<dynamic>)
          .map((like) => Like.fromJson(like))
          .toList(),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}



class Like {
  final bool likedOrNot;
  final String id;

  Like({
    required this.likedOrNot,
    required this.id,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      likedOrNot: json['likedOrNot'],
      id: json['_id'],
    );
  }
}
List<RatingAndComment> parseRatingAndCommentsList(List<dynamic> jsonList) {
  return jsonList.map((json) => RatingAndComment.fromJson(json)).toList();
}
