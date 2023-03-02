import 'package:flutter/cupertino.dart';

class Habits {
  String? date;
  List<HabitList>? habitList;
  int? treats;
  int? takeaway;
  String? treatsMsgDisplay;
  String? takeawayMsgDisplay;
  String? treatsMsg;
  int? treatLimit;
  int? week;

  Habits(
      {this.date,
      this.habitList,
      this.treats,
      this.takeaway,
      this.treatsMsgDisplay,
      this.takeawayMsgDisplay,
      this.treatsMsg,
      this.treatLimit,
      this.week});

  Habits.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['habitlist'] != null) {
      habitList = <HabitList>[];
      json['habitlist'].forEach((v) {
        habitList!.add(new HabitList.fromJson(v));
      });
    }
    treats = json['treats'];
    takeaway = json['takeaway'];
    treatsMsgDisplay = json['treats_msg_display'];
    takeawayMsgDisplay = json['takeaway_msg_display'];
    treatsMsg = json['treats_msg'];
    treatLimit = json['treat_limit'];
    week = json['week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.habitList != null) {
      data['habitlist'] = this.habitList!.map((v) => v.toJson()).toList();
    }
    data['treats'] = this.treats;
    data['takeaway'] = this.takeaway;
    data['treats_msg_display'] = this.treatsMsgDisplay;
    data['takeaway_msg_display'] = this.takeawayMsgDisplay;
    data['treats_msg'] = this.treatsMsg;
    data['treat_limit'] = this.treatLimit;
    data['week'] = this.week;
    return data;
  }
}

class HabitList {
  int? id;
  int? category;
  String? value;
  int? streak;
  String? type;
  int? isTicked;
  int? isDisabled;
  bool isRename = false;
  bool isEdit = false;
  TextEditingController? controller = TextEditingController();

  HabitList(
      {this.id,
      this.category,
      this.value,
      this.streak,
      this.type,
      this.isTicked,
      this.isDisabled});

  HabitList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    value = json['value'];
    streak = json['streak'];
    type = json['type'];
    isTicked = json['is_ticked'];
    isDisabled = json['is_disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['value'] = this.value;
    data['streak'] = this.streak;
    data['type'] = this.type;
    data['is_ticked'] = this.isTicked;
    data['is_disabled'] = this.isDisabled;
    return data;
  }
}
