class SkillsCategoriesModel {
  bool? success;
  String? message;
  List<CategoriesData>? data;

  SkillsCategoriesModel({this.success, this.message, this.data});

  SkillsCategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoriesData>[];
      json['data'].forEach((v) {
        data!.add(new CategoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesData {
  String? name;
  CategoriesImage? image;

  CategoriesData({this.name, this.image});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'] != null ? new CategoriesImage.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class CategoriesImage {
  String? colored;
  String? blacked;

  CategoriesImage({this.colored, this.blacked});

  CategoriesImage.fromJson(Map<String, dynamic> json) {
    colored = json['colored'];
    blacked = json['blacked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colored'] = this.colored;
    data['blacked'] = this.blacked;
    return data;
  }
}
