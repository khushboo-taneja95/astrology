class MatchMakingModel {
  bool? success;
  String? message;
  Data? data;

  MatchMakingModel({this.success, this.message, this.data});

  MatchMakingModel.fromJson(Map<String, dynamic> json) {
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
  Compatibility? compatibility;
  Doshas? doshas;

  Data({this.compatibility, this.doshas});

  Data.fromJson(Map<String, dynamic> json) {
    compatibility = json['compatibility'] != null
        ? new Compatibility.fromJson(json['compatibility'])
        : null;
    doshas =
        json['doshas'] != null ? new Doshas.fromJson(json['doshas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.compatibility != null) {
      data['compatibility'] = this.compatibility!.toJson();
    }
    if (this.doshas != null) {
      data['doshas'] = this.doshas!.toJson();
    }
    return data;
  }
}

class Compatibility {
  int? score;
  String? summary;
  String? ashtakootScore;
  String? dashkootScore;
  String? gunaSummary;

  Compatibility(
      {this.score,
      this.summary,
      this.ashtakootScore,
      this.dashkootScore,
      this.gunaSummary});

  Compatibility.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    summary = json['summary'];
    ashtakootScore = json['ashtakoot_score'];
    dashkootScore = json['dashkoot_score'];
    gunaSummary = json['guna_summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['summary'] = this.summary;
    data['ashtakoot_score'] = this.ashtakootScore;
    data['dashkoot_score'] = this.dashkootScore;
    data['guna_summary'] = this.gunaSummary;
    return data;
  }
}

class Doshas {
  String? pitraDosh;
  String? kaalsarpDosh;
  String? kalatraDoshRahuketu;
  String? kalatraDoshSaturn;
  String? mangalDosh;

  Doshas(
      {this.pitraDosh,
      this.kaalsarpDosh,
      this.kalatraDoshRahuketu,
      this.kalatraDoshSaturn,
      this.mangalDosh});

  Doshas.fromJson(Map<String, dynamic> json) {
    pitraDosh = json['pitra_dosh'];
    kaalsarpDosh = json['kaalsarp_dosh'];
    kalatraDoshRahuketu = json['kalatra_dosh_rahuketu'];
    kalatraDoshSaturn = json['kalatra_dosh_saturn'];
    mangalDosh = json['mangal_dosh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pitra_dosh'] = this.pitraDosh;
    data['kaalsarp_dosh'] = this.kaalsarpDosh;
    data['kalatra_dosh_rahuketu'] = this.kalatraDoshRahuketu;
    data['kalatra_dosh_saturn'] = this.kalatraDoshSaturn;
    data['mangal_dosh'] = this.mangalDosh;
    return data;
  }
}
