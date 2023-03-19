class BlogsHomePageModel {
  bool? success;
  String? message;
  List<BlogsHomeData>? data;

  BlogsHomePageModel({this.success, this.message, this.data});

  BlogsHomePageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BlogsHomeData>[];
      json['data'].forEach((v) {
        data!.add(new BlogsHomeData.fromJson(v));
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

class BlogsHomeData {
  String? image;
  int? id;
  String? createdAt;
  int? date;

  BlogsHomeData({this.image, this.id, this.createdAt, this.date});

  BlogsHomeData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    createdAt = json['created_at'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['date'] = this.date;
    return data;
  }
}
