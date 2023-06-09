class AstrologyDetailsModel {
  bool? success;
  String? message;
  Data? data;

  AstrologyDetailsModel({this.success, this.message, this.data});

  AstrologyDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? gender;
  int? dailyContributeHours;
  String? hearAbout;
  bool? haveAccountInOtherPlatform;
  int? experience;
  String? qualification;
  String? educationDegree;
  List<String>? languages;
  List<String>? skills;
  List<String>? expertise;
  String? address;
  String? panNumber;
  String? bankName;
  String? accountType;
  String? accountNumber;
  String? ifsc;
  String? upiId;
  String? image;
  int? chatPerMinute;
  int? callPerMinute;
  String? location;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  List<String>? consultMode;
  bool? active;
  Null? earningAmount;
  String? password;
  String? razorpayXContactId;
  String? razorpayXFundAccountId;
  String? accountName;
  List<Null>? reviews;

  Data(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.gender,
      this.dailyContributeHours,
      this.hearAbout,
      this.haveAccountInOtherPlatform,
      this.experience,
      this.qualification,
      this.educationDegree,
      this.languages,
      this.skills,
      this.expertise,
      this.address,
      this.panNumber,
      this.bankName,
      this.accountType,
      this.accountNumber,
      this.ifsc,
      this.upiId,
      this.image,
      this.chatPerMinute,
      this.callPerMinute,
      this.location,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.consultMode,
      this.active,
      this.earningAmount,
      this.password,
      this.razorpayXContactId,
      this.razorpayXFundAccountId,
      this.accountName,
      this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dailyContributeHours = json['daily_contribute_hours'];
    hearAbout = json['hear_about'];
    haveAccountInOtherPlatform = json['have_account_in_other_platform'];
    experience = json['experience'];
    qualification = json['qualification'];
    educationDegree = json['education_degree'];
    languages = json['languages'].cast<String>();
    skills = json['skills'].cast<String>();
    expertise = json['expertise'].cast<String>();
    address = json['address'];
    panNumber = json['pan_number'];
    bankName = json['bank_name'];
    accountType = json['account_type'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    upiId = json['upi_id'];
    image = json['image'];
    chatPerMinute = json['chat_per_minute'];
    callPerMinute = json['call_per_minute'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    consultMode = json['consult_mode'].cast<String>();
    active = json['active'];
    earningAmount = json['earning_amount'];
    password = json['password'];
    razorpayXContactId = json['razorpay_x_contact_id'];
    razorpayXFundAccountId = json['razorpay_x_fund_account_id'];
    accountName = json['account_name'];
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['daily_contribute_hours'] = this.dailyContributeHours;
    data['hear_about'] = this.hearAbout;
    data['have_account_in_other_platform'] = this.haveAccountInOtherPlatform;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['education_degree'] = this.educationDegree;
    data['languages'] = this.languages;
    data['skills'] = this.skills;
    data['expertise'] = this.expertise;
    data['address'] = this.address;
    data['pan_number'] = this.panNumber;
    data['bank_name'] = this.bankName;
    data['account_type'] = this.accountType;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['upi_id'] = this.upiId;
    data['image'] = this.image;
    data['chat_per_minute'] = this.chatPerMinute;
    data['call_per_minute'] = this.callPerMinute;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['consult_mode'] = this.consultMode;
    data['active'] = this.active;
    data['earning_amount'] = this.earningAmount;
    data['password'] = this.password;
    data['razorpay_x_contact_id'] = this.razorpayXContactId;
    data['razorpay_x_fund_account_id'] = this.razorpayXFundAccountId;
    data['account_name'] = this.accountName;
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
