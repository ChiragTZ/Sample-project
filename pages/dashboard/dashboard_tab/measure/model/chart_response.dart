class Chart {
  List<ChartProgress>? yourProgress;
  List<ChartProgress>? projectedPlan;

  Chart({this.yourProgress, this.projectedPlan});

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['your_progress'] != null) {
      yourProgress = <ChartProgress>[];
      json['your_progress'].forEach((v) {
        yourProgress!.add(new ChartProgress.fromJson(v));
      });
    }
    if (json['projected_plan'] != null) {
      projectedPlan = <ChartProgress>[];
      json['projected_plan'].forEach((v) {
        projectedPlan!.add(new ChartProgress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.yourProgress != null) {
      data['your_progress'] =
          this.yourProgress!.map((v) => v.toJson()).toList();
    }
    if (this.projectedPlan != null) {
      data['projected_plan'] =
          this.projectedPlan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChartProgress {
  String? date;
  int? week;
  int? isCurrentWeek;
  int? weekPhase;
  String? xaxis;
  double? yaxis;

  ChartProgress(
      {this.date,
      this.week,
      this.isCurrentWeek,
      this.weekPhase,
      this.xaxis,
      this.yaxis});

  ChartProgress.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    week = json['week'];
    isCurrentWeek = json['is_current_week'];
    weekPhase = json['week_phase'];
    xaxis = json['xaxis'];
    yaxis = json['yaxis'] == 0 ? null : json['yaxis'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['week'] = this.week;
    data['is_current_week'] = this.isCurrentWeek;
    data['week_phase'] = this.weekPhase;
    data['xaxis'] = this.xaxis;
    data['yaxis'] = this.yaxis;
    return data;
  }
}
