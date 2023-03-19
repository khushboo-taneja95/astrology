class ConsultationsHistory {
  List<String>? userType;
  List<String>? userId;
  List<String>? consultationType;

  ConsultationsHistory({this.userType, this.userId, this.consultationType});

  ConsultationsHistory.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'].cast<String>();
    userId = json['user_id'].cast<String>();
    consultationType = json['consultation_type'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['consultation_type'] = consultationType;
    return data;
  }
}
