class Measure {
  int? measurementAddedForWeek;
  LastLoggedWeight? lastLoggedWeight;
  Progress? progress;
  List<String>? howYouFeel;

  Measure(
      {this.measurementAddedForWeek,
      this.lastLoggedWeight,
      this.progress,
      this.howYouFeel});

  Measure.fromJson(Map<String, dynamic> json) {
    measurementAddedForWeek = json['measurement_added_for_week'];
    lastLoggedWeight = json['last_logged_weight'] != null
        ? new LastLoggedWeight.fromJson(json['last_logged_weight'])
        : null;
    progress = json['progress'] != null
        ? new Progress.fromJson(json['progress'])
        : null;
    howYouFeel = json['how_you_feel'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measurement_added_for_week'] = this.measurementAddedForWeek;
    if (this.lastLoggedWeight != null) {
      data['last_logged_weight'] = this.lastLoggedWeight!.toJson();
    }
    if (this.progress != null) {
      data['progress'] = this.progress!.toJson();
    }
    data['how_you_feel'] = this.howYouFeel;
    return data;
  }
}

class LastLoggedWeight {
  int? id;
  double? weight;
  double? waist;
  String? feel;
  String? comment;
  String? date;

  LastLoggedWeight(
      {this.id, this.weight, this.waist, this.feel, this.comment, this.date});

  LastLoggedWeight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'] != null ? json['weight'].toDouble() : null;
    waist = json['waist'] != null ? json['waist'].toDouble() : null;
    feel = json['feel'];
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weight'] = this.weight;
    data['waist'] = this.waist;
    data['feel'] = this.feel;
    data['comment'] = this.comment;
    data['date'] = this.date;
    return data;
  }
}

class Progress {
  double? startweight;
  double? lastlog;
  double? goal;

  Progress({this.startweight, this.lastlog, this.goal});

  Progress.fromJson(Map<String, dynamic> json) {
    startweight = json['startweight'].toDouble();
    lastlog = json['lastlog'].toDouble();
    goal = json['goal'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startweight'] = this.startweight;
    data['lastlog'] = this.lastlog;
    data['goal'] = this.goal;
    return data;
  }
}
