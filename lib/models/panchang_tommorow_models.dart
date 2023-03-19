class PanchangTomorrowModel {
  bool? success;
  String? message;
  TomorrowData? data;

  PanchangTomorrowModel({this.success, this.message, this.data});

  PanchangTomorrowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new TomorrowData.fromJson(json['data']) : null;
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

class TomorrowData {
  String? date;
  ShubhMuhurat? shubhMuhurat;
  Rahukaal? rahukaal;
  Rahukaal? gulika;
  Rahukaal? yamakanta;
  Tithi? tithi;
  Nakshatra? nakshatra;
  Nakshatra? karana;
  Sun? sun;
  Sun? moon;

  TomorrowData(
      {this.date,
      this.shubhMuhurat,
      this.rahukaal,
      this.gulika,
      this.yamakanta,
      this.tithi,
      this.nakshatra,
      this.karana,
      this.sun,
      this.moon});

  TomorrowData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    shubhMuhurat = json['shubh_muhurat'] != null
        ? new ShubhMuhurat.fromJson(json['shubh_muhurat'])
        : null;
    rahukaal = json['rahukaal'] != null
        ? new Rahukaal.fromJson(json['rahukaal'])
        : null;
    gulika =
        json['gulika'] != null ? new Rahukaal.fromJson(json['gulika']) : null;
    yamakanta = json['yamakanta'] != null
        ? new Rahukaal.fromJson(json['yamakanta'])
        : null;
    tithi = json['tithi'] != null ? new Tithi.fromJson(json['tithi']) : null;
    nakshatra = json['nakshatra'] != null
        ? new Nakshatra.fromJson(json['nakshatra'])
        : null;
    karana =
        json['karana'] != null ? new Nakshatra.fromJson(json['karana']) : null;
    sun = json['sun'] != null ? new Sun.fromJson(json['sun']) : null;
    moon = json['moon'] != null ? new Sun.fromJson(json['moon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.shubhMuhurat != null) {
      data['shubh_muhurat'] = this.shubhMuhurat!.toJson();
    }
    if (this.rahukaal != null) {
      data['rahukaal'] = this.rahukaal!.toJson();
    }
    if (this.gulika != null) {
      data['gulika'] = this.gulika!.toJson();
    }
    if (this.yamakanta != null) {
      data['yamakanta'] = this.yamakanta!.toJson();
    }
    if (this.tithi != null) {
      data['tithi'] = this.tithi!.toJson();
    }
    if (this.nakshatra != null) {
      data['nakshatra'] = this.nakshatra!.toJson();
    }
    if (this.karana != null) {
      data['karana'] = this.karana!.toJson();
    }
    if (this.sun != null) {
      data['sun'] = this.sun!.toJson();
    }
    if (this.moon != null) {
      data['moon'] = this.moon!.toJson();
    }
    return data;
  }
}

class ShubhMuhurat {
  String? start;
  String? end;
  String? title;

  ShubhMuhurat({this.start, this.end, this.title});

  ShubhMuhurat.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    data['title'] = this.title;
    return data;
  }
}

class Rahukaal {
  String? title;
  String? value;

  Rahukaal({this.title, this.value});

  Rahukaal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}

class Tithi {
  String? title;
  String? name;
  String? type;
  String? start;
  String? end;
  String? special;

  Tithi({this.title, this.name, this.type, this.start, this.end, this.special});

  Tithi.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    type = json['type'];
    start = json['start'];
    end = json['end'];
    special = json['special'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['type'] = this.type;
    data['start'] = this.start;
    data['end'] = this.end;
    data['special'] = this.special;
    return data;
  }
}

class Nakshatra {
  String? title;
  String? name;
  String? start;
  String? end;

  Nakshatra({this.title, this.name, this.start, this.end});

  Nakshatra.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

class Sun {
  Rahukaal? rise;
  Rahukaal? set;

  Sun({this.rise, this.set});

  Sun.fromJson(Map<String, dynamic> json) {
    rise = json['rise'] != null ? new Rahukaal.fromJson(json['rise']) : null;
    set = json['set'] != null ? new Rahukaal.fromJson(json['set']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rise != null) {
      data['rise'] = this.rise!.toJson();
    }
    if (this.set != null) {
      data['set'] = this.set!.toJson();
    }
    return data;
  }
}
