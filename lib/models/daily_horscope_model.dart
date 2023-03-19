class DailyHorscopeModel {
  bool? success;
  String? message;
  DailyHorscope? data;

  DailyHorscopeModel({this.success, this.message, this.data});

  DailyHorscopeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DailyHorscope.fromJson(json['data']) : null;
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

class DailyHorscope {
  String? luckyColor;
  String? luckyColorCode;
  List<dynamic>? luckyNumber;
  List<BotResponse>? botResponse;
  String? zodiac;

  DailyHorscope(
      {this.luckyColor,
      this.luckyColorCode,
      this.luckyNumber,
      this.botResponse,
      this.zodiac});

  DailyHorscope.fromJson(Map<String, dynamic> json) {
    luckyColor = json['lucky_color'];
    luckyColorCode = json['lucky_color_code'];
    luckyNumber = json['lucky_number'];
    if (json['bot_response'] != null) {
      botResponse = <BotResponse>[];
      json['bot_response'].forEach((v) {
        botResponse!.add(new BotResponse.fromJson(v));
      });
    }
    zodiac = json['zodiac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lucky_color'] = this.luckyColor;
    data['lucky_color_code'] = this.luckyColorCode;
    data['lucky_number'] = this.luckyNumber;
    if (this.botResponse != null) {
      data['bot_response'] = this.botResponse!.map((v) => v.toJson()).toList();
    }
    data['zodiac'] = this.zodiac;
    return data;
  }
}

class BotResponse {
  String? title;
  int? score;
  String? splitResponse;

  BotResponse({this.title, this.score, this.splitResponse});

  BotResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    score = json['score'];
    splitResponse = json['split_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['score'] = this.score;
    data['split_response'] = this.splitResponse;
    return data;
  }
}
