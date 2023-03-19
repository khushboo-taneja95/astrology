class UserProfile {
  int? id;
  String? phone;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? timeOfBirth;
  String? placeOfBirth;
  String? latitude;
  String? longitude;
  int? whatsAppNotification;
  int? active;
  int? amount;

  UserProfile({
    this.id,
    this.phone,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.timeOfBirth,
    this.placeOfBirth,
    this.latitude,
    this.longitude,
    this.whatsAppNotification,
    this.active,
    this.amount,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      timeOfBirth: json['time_of_birth'],
      placeOfBirth: json['place_of_birth'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      whatsAppNotification: json['whatsapp_notification'],
      active: json['active'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "time_of_birth": timeOfBirth,
      "place_of_birth": placeOfBirth,
      "latitude": latitude ?? '0',
      "longitude": longitude ?? '0',
    };
  }
}
