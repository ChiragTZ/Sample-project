class Overview {
  int? id;
  int? championsBadge;
  String? currentPhase;
  String? monthWeekLabel;
  int? currentWeek;
  String? accountabilityStatement;
  String? videoLink;
  List<MyReminders>? myReminders;
  String? nextTierTitle;
  String? nextTier;
  String? currentTier;
  int? myTierId;
  String? fullname;
  int? rewardPoints;
  List<Null>? readyToClaim;
  List<Null>? alreadyClaimed;
  Scoreboard? scoreboard;

  Overview(
      {this.id,
      this.championsBadge,
      this.currentPhase,
      this.monthWeekLabel,
      this.currentWeek,
      this.accountabilityStatement,
      this.videoLink,
      this.myReminders,
      this.nextTierTitle,
      this.nextTier,
      this.currentTier,
      this.myTierId,
      this.fullname,
      this.rewardPoints,
      this.readyToClaim,
      this.alreadyClaimed,
      this.scoreboard});

  Overview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    championsBadge = json['champions_badge'];
    currentPhase = json['current_phase'];
    monthWeekLabel = json['month_week_label'];
    currentWeek = json['current_week'];
    accountabilityStatement = json['accountability_statement'];
    videoLink = json['video_link'];
    if (json['my_reminders'] != null) {
      myReminders = <MyReminders>[];
      json['my_reminders'].forEach((v) {
        myReminders!.add(new MyReminders.fromJson(v));
      });
    }
    nextTierTitle = json['next_tier_title'];
    nextTier = json['next_tier'];
    currentTier = json['current_tier'];
    myTierId = json['my_tier_id'];
    fullname = json['fullname'];
    rewardPoints = json['reward_points'];
    // if (json['ready_to_claim'] != null) {
    //   readyToClaim = <Null>[];
    //   json['ready_to_claim'].forEach((v) {
    //     readyToClaim!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['already_claimed'] != null) {
    //   alreadyClaimed = <Null>[];
    //   json['already_claimed'].forEach((v) {
    //     alreadyClaimed!.add(new Null.fromJson(v));
    //   });
    // }
    scoreboard = json['scoreboard'] != null
        ? new Scoreboard.fromJson(json['scoreboard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['champions_badge'] = this.championsBadge;
    data['current_phase'] = this.currentPhase;
    data['month_week_label'] = this.monthWeekLabel;
    data['current_week'] = this.currentWeek;
    data['accountability_statement'] = this.accountabilityStatement;
    data['video_link'] = this.videoLink;
    if (this.myReminders != null) {
      data['my_reminders'] = this.myReminders!.map((v) => v.toJson()).toList();
    }
    data['next_tier_title'] = this.nextTierTitle;
    data['next_tier'] = this.nextTier;
    data['current_tier'] = this.currentTier;
    data['my_tier_id'] = this.myTierId;
    data['fullname'] = this.fullname;
    data['reward_points'] = this.rewardPoints;
    // if (this.readyToClaim != null) {
    //   data['ready_to_claim'] =
    //       this.readyToClaim!.map((v) => v.toJson()).toList();
    // }
    // if (this.alreadyClaimed != null) {
    //   data['already_claimed'] =
    //       this.alreadyClaimed!.map((v) => v.toJson()).toList();
    // }
    if (this.scoreboard != null) {
      data['scoreboard'] = this.scoreboard!.toJson();
    }
    return data;
  }
}

class MyReminders {
  String? title;
  String? points;
  String? status;
  String? subtitle;
  int? noTreatTakeawayStatus;
  String? type;

  MyReminders(
      {this.title,
      this.points,
      this.status,
      this.subtitle,
      this.noTreatTakeawayStatus,
      this.type});

  MyReminders.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    points = json['points'];
    status = json['status'];
    subtitle = json['subtitle'];
    noTreatTakeawayStatus = json['no_treat_takeaway_status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['points'] = this.points;
    data['status'] = this.status;
    data['subtitle'] = this.subtitle;
    data['no_treat_takeaway_status'] = this.noTreatTakeawayStatus;
    data['type'] = this.type;
    return data;
  }
}

class Scoreboard {
  List<Weekly>? weekly;
  int? weeklyCount;
  int? weeklyMypos;
  List<Monthly>? monthly;
  int? monthlyCount;
  int? monthlyMypos;
  List<AllTime>? allTime;
  int? allTimeCount;
  int? allTimeMypos;

  Scoreboard(
      {this.weekly,
      this.weeklyCount,
      this.weeklyMypos,
      this.monthly,
      this.monthlyCount,
      this.monthlyMypos,
      this.allTime,
      this.allTimeCount,
      this.allTimeMypos});

  Scoreboard.fromJson(Map<String, dynamic> json) {
    if (json['weekly'] != null) {
      weekly = <Weekly>[];
      json['weekly'].forEach((v) {
        weekly!.add(new Weekly.fromJson(v));
      });
    }
    weeklyCount = json['weekly_count'];
    weeklyMypos = json['weekly_mypos'];
    if (json['monthly'] != null) {
      monthly = <Monthly>[];
      json['monthly'].forEach((v) {
        monthly!.add(new Monthly.fromJson(v));
      });
    }
    monthlyCount = json['monthly_count'];
    monthlyMypos = json['monthly_mypos'];
    if (json['all_time'] != null) {
      allTime = <AllTime>[];
      json['all_time'].forEach((v) {
        allTime!.add(new AllTime.fromJson(v));
      });
    }
    allTimeCount = json['all_time_count'];
    allTimeMypos = json['all_time_mypos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weekly != null) {
      data['weekly'] = this.weekly!.map((v) => v.toJson()).toList();
    }
    data['weekly_count'] = this.weeklyCount;
    data['weekly_mypos'] = this.weeklyMypos;
    if (this.monthly != null) {
      data['monthly'] = this.monthly!.map((v) => v.toJson()).toList();
    }
    data['monthly_count'] = this.monthlyCount;
    data['monthly_mypos'] = this.monthlyMypos;
    if (this.allTime != null) {
      data['all_time'] = this.allTime!.map((v) => v.toJson()).toList();
    }
    data['all_time_count'] = this.allTimeCount;
    data['all_time_mypos'] = this.allTimeMypos;
    return data;
  }
}

class Weekly {
  int? id;
  String? ufname;
  String? ulname;
  int? rewardPoints;
  int? tier;
  String? weekRewardPoints;
  int? posnum;

  Weekly(
      {this.id,
      this.ufname,
      this.ulname,
      this.rewardPoints,
      this.tier,
      this.weekRewardPoints,
      this.posnum});

  Weekly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ufname = json['ufname'];
    ulname = json['ulname'];
    rewardPoints = json['reward_points'];
    tier = json['tier'];
    weekRewardPoints = json['week_reward_points'];
    posnum = json['posnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ufname'] = this.ufname;
    data['ulname'] = this.ulname;
    data['reward_points'] = this.rewardPoints;
    data['tier'] = this.tier;
    data['week_reward_points'] = this.weekRewardPoints;
    data['posnum'] = this.posnum;
    return data;
  }
}

class Monthly {
  int? id;
  String? ufname;
  String? ulname;
  int? rewardPoints;
  int? tier;
  String? monthRewardPoints;
  int? posnum;

  Monthly(
      {this.id,
      this.ufname,
      this.ulname,
      this.rewardPoints,
      this.tier,
      this.monthRewardPoints,
      this.posnum});

  Monthly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ufname = json['ufname'];
    ulname = json['ulname'];
    rewardPoints = json['reward_points'];
    tier = json['tier'];
    monthRewardPoints = json['month_reward_points'];
    posnum = json['posnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ufname'] = this.ufname;
    data['ulname'] = this.ulname;
    data['reward_points'] = this.rewardPoints;
    data['tier'] = this.tier;
    data['month_reward_points'] = this.monthRewardPoints;
    data['posnum'] = this.posnum;
    return data;
  }
}

class AllTime {
  String? ufname;
  String? ulname;
  int? id;
  int? rewardPoints;
  int? tier;
  int? posnum;

  AllTime(
      {this.ufname,
      this.ulname,
      this.id,
      this.rewardPoints,
      this.tier,
      this.posnum});

  AllTime.fromJson(Map<String, dynamic> json) {
    ufname = json['ufname'];
    ulname = json['ulname'];
    id = json['id'];
    rewardPoints = json['reward_points'];
    tier = json['tier'];
    posnum = json['posnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ufname'] = this.ufname;
    data['ulname'] = this.ulname;
    data['id'] = this.id;
    data['reward_points'] = this.rewardPoints;
    data['tier'] = this.tier;
    data['posnum'] = this.posnum;
    return data;
  }
}
