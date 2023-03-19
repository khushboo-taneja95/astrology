class NotificationsListModel {
  bool? success;
  String? message;
  List<NotificationListData>? data;

  NotificationsListModel({this.success, this.message, this.data});

  NotificationsListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationListData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationListData.fromJson(v));
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

class NotificationListData {
  int? id;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationListData({this.id, this.content, this.createdAt, this.updatedAt});

  NotificationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
