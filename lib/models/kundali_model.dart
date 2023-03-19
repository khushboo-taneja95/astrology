class KundaliModel {
  bool? success;
  String? message;
  Data? data;

  KundaliModel({this.success, this.message, this.data});

  KundaliModel.fromJson(Map<String, dynamic> json) {
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
  Basic? basic;
  List<Dasha>? dasha;
  String? lagna;
  String? navamsa;

  Data({this.basic, this.dasha, this.lagna, this.navamsa});

  Data.fromJson(Map<String, dynamic> json) {
    basic = json['basic'] != null ? new Basic.fromJson(json['basic']) : null;
    if (json['dasha'] != null) {
      dasha = <Dasha>[];
      json['dasha'].forEach((v) {
        dasha!.add(new Dasha.fromJson(v));
      });
    }
    lagna = json['lagna'];
    navamsa = json['navamsa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basic != null) {
      data['basic'] = this.basic!.toJson();
    }
    if (this.dasha != null) {
      data['dasha'] = this.dasha!.map((v) => v.toJson()).toList();
    }
    data['lagna'] = this.lagna;
    data['navamsa'] = this.navamsa;
    return data;
  }
}

class Basic {
  BirthDetails? birthDetails;
  PanchangDetails? panchangDetails;
  PlanetaryDetails? planetaryDetails;

  Basic({this.birthDetails, this.panchangDetails, this.planetaryDetails});

  Basic.fromJson(Map<String, dynamic> json) {
    birthDetails = json['birth_details'] != null
        ? new BirthDetails.fromJson(json['birth_details'])
        : null;
    panchangDetails = json['panchang_details'] != null
        ? new PanchangDetails.fromJson(json['panchang_details'])
        : null;
    planetaryDetails = json['planetary_details'] != null
        ? new PlanetaryDetails.fromJson(json['planetary_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.birthDetails != null) {
      data['birth_details'] = this.birthDetails!.toJson();
    }
    if (this.panchangDetails != null) {
      data['panchang_details'] = this.panchangDetails!.toJson();
    }
    if (this.planetaryDetails != null) {
      data['planetary_details'] = this.planetaryDetails!.toJson();
    }
    return data;
  }
}

class BirthDetails {
  String? name;
  String? gender;
  String? dob;
  String? tob;
  String? pob;
  String? lat;
  String? long;
  String? timezone;

  BirthDetails(
      {this.name,
      this.gender,
      this.dob,
      this.tob,
      this.pob,
      this.lat,
      this.long,
      this.timezone});

  BirthDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    tob = json['tob'];
    pob = json['pob'];
    lat = json['lat'];
    long = json['long'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['tob'] = this.tob;
    data['pob'] = this.pob;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['timezone'] = this.timezone;
    return data;
  }
}

class PanchangDetails {
  String? tithi;
  String? karana;
  String? yoga;
  String? nakshatra;
  double? ayanamsa;
  String? sunRise;
  String? sunSet;

  PanchangDetails(
      {this.tithi,
      this.karana,
      this.yoga,
      this.nakshatra,
      this.ayanamsa,
      this.sunRise,
      this.sunSet});

  PanchangDetails.fromJson(Map<String, dynamic> json) {
    tithi = json['tithi'];
    karana = json['karana'];
    yoga = json['yoga'];
    nakshatra = json['nakshatra'];
    ayanamsa = json['ayanamsa'];
    sunRise = json['sun_rise'];
    sunSet = json['sun_set'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tithi'] = this.tithi;
    data['karana'] = this.karana;
    data['yoga'] = this.yoga;
    data['nakshatra'] = this.nakshatra;
    data['ayanamsa'] = this.ayanamsa;
    data['sun_rise'] = this.sunRise;
    data['sun_set'] = this.sunSet;
    return data;
  }
}

class PlanetaryDetails {
  Ascendant? ascendant;
  Ascendant? sun;
  Ascendant? moon;
  Ascendant? mars;
  Ascendant? mercury;
  Ascendant? jupiter;
  Ascendant? venus;
  Ascendant? saturn;
  Ascendant? rahu;
  Ascendant? ketu;

  PlanetaryDetails(
      {this.ascendant,
      this.sun,
      this.moon,
      this.mars,
      this.mercury,
      this.jupiter,
      this.venus,
      this.saturn,
      this.rahu,
      this.ketu});

  PlanetaryDetails.fromJson(Map<String, dynamic> json) {
    ascendant = json['Ascendant'] != null
        ? new Ascendant.fromJson(json['Ascendant'])
        : null;
    sun = json['Sun'] != null ? new Ascendant.fromJson(json['Sun']) : null;
    moon = json['Moon'] != null ? new Ascendant.fromJson(json['Moon']) : null;
    mars = json['Mars'] != null ? new Ascendant.fromJson(json['Mars']) : null;
    mercury = json['Mercury'] != null
        ? new Ascendant.fromJson(json['Mercury'])
        : null;
    jupiter = json['Jupiter'] != null
        ? new Ascendant.fromJson(json['Jupiter'])
        : null;
    venus =
        json['Venus'] != null ? new Ascendant.fromJson(json['Venus']) : null;
    saturn =
        json['Saturn'] != null ? new Ascendant.fromJson(json['Saturn']) : null;
    rahu = json['Rahu'] != null ? new Ascendant.fromJson(json['Rahu']) : null;
    ketu = json['Ketu'] != null ? new Ascendant.fromJson(json['Ketu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ascendant != null) {
      data['Ascendant'] = this.ascendant!.toJson();
    }
    if (this.sun != null) {
      data['Sun'] = this.sun!.toJson();
    }
    if (this.moon != null) {
      data['Moon'] = this.moon!.toJson();
    }
    if (this.mars != null) {
      data['Mars'] = this.mars!.toJson();
    }
    if (this.mercury != null) {
      data['Mercury'] = this.mercury!.toJson();
    }
    if (this.jupiter != null) {
      data['Jupiter'] = this.jupiter!.toJson();
    }
    if (this.venus != null) {
      data['Venus'] = this.venus!.toJson();
    }
    if (this.saturn != null) {
      data['Saturn'] = this.saturn!.toJson();
    }
    if (this.rahu != null) {
      data['Rahu'] = this.rahu!.toJson();
    }
    if (this.ketu != null) {
      data['Ketu'] = this.ketu!.toJson();
    }
    return data;
  }
}

class Ascendant {
  int? deg;
  String? rashi;
  int? house;
  String? nakshatra;
  int? nakshatraPada;

  Ascendant(
      {this.deg, this.rashi, this.house, this.nakshatra, this.nakshatraPada});

  Ascendant.fromJson(Map<String, dynamic> json) {
    deg = json['deg'];
    rashi = json['rashi'];
    house = json['house'];
    nakshatra = json['nakshatra'];
    nakshatraPada = json['nakshatra_pada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deg'] = this.deg;
    data['rashi'] = this.rashi;
    data['house'] = this.house;
    data['nakshatra'] = this.nakshatra;
    data['nakshatra_pada'] = this.nakshatraPada;
    return data;
  }
}

class Dasha {
  String? planet;
  String? start;
  String? end;

  Dasha({this.planet, this.start, this.end});

  Dasha.fromJson(Map<String, dynamic> json) {
    planet = json['planet'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planet'] = this.planet;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
