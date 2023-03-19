class HorscopeModel {
  bool? success;
  String? message;
  List<Data>? data;

  HorscopeModel({this.success, this.message, this.data});

  HorscopeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? name;
  String? dateString;
  String? image;
  int? apiValue;

  Data({this.name, this.dateString, this.image, this.apiValue});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateString = json['date_string'];
    image = json['image'];
    apiValue = json['api_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date_string'] = this.dateString;
    data['image'] = this.image;
    data['api_value'] = this.apiValue;
    return data;
  }
}
