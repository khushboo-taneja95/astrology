class HomeBanner {
  bool? success;
  String? message;
  Banners? data;

  HomeBanner({this.success, this.message, this.data});

  HomeBanner.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Banners.fromJson(json['data']) : null;
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

class Banners {
  List<Top>? top;
  List<Bottom>? bottom;

  Banners({this.top, this.bottom});

  Banners.fromJson(Map<String, dynamic> json) {
    if (json['top'] != null) {
      top = <Top>[];
      json['top'].forEach((v) {
        top!.add(new Top.fromJson(v));
      });
    }
    if (json['bottom'] != null) {
      bottom = <Bottom>[];
      json['bottom'].forEach((v) {
        bottom!.add(new Bottom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.top != null) {
      data['top'] = this.top!.map((v) => v.toJson()).toList();
    }
    if (this.bottom != null) {
      data['bottom'] = this.bottom!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Top {
  String? name;
  String? image;

  Top({this.name, this.image});

  Top.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
class Bottom {
  String? name;
  String? image;

  Bottom({this.name, this.image});

  Bottom.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
