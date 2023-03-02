class UserData {
  int? id;
  String? email;
  String? firstname;
  String? lastname;
  String? bio;
  int? gender;
  int? age;
  String? height;
  int? currentWeight;
  int? goalWeight;
  int? preferStartDay;
  String? activePhase;
  List<String>? allowedPhase;
  int? isMembershipActive;
  int? currWeek;
  int? isWeekCycleActive;
  int? pauseProgramme;
  String? nextPreferStartDay;
  int? pushNotificationPermission;
  int? emailPermission;
  String? timezone;
  String? signupDate;
  String? weekStartDate;
  String? token;

  UserData(
      {this.id,
      this.email,
      this.firstname,
      this.lastname,
      this.bio,
      this.gender,
      this.age,
      this.height,
      this.currentWeight,
      this.goalWeight,
      this.preferStartDay,
      this.activePhase,
      this.allowedPhase,
      this.isMembershipActive,
      this.currWeek,
      this.isWeekCycleActive,
      this.pauseProgramme,
      this.nextPreferStartDay,
      this.pushNotificationPermission,
      this.emailPermission,
      this.timezone,
      this.signupDate,
      this.weekStartDate,
      this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    bio = json['bio'];
    gender = json['gender'];
    age = json['age'];
    height = json['height'];
    currentWeight = json['current_weight'];
    goalWeight = json['goal_weight'];
    preferStartDay = json['prefer_start_day'];
    activePhase = json['active_phase'];
    allowedPhase = json['allowed_phase'] != null
        ? json['allowed_phase'].cast<String>()
        : null;
    isMembershipActive = json['is_membership_active'];
    currWeek = json['curr_week'];
    isWeekCycleActive = json['is_week_cycle_active'];
    pauseProgramme = json['pause_programme'];
    nextPreferStartDay = json['next_prefer_start_day'];
    pushNotificationPermission = json['push_notification_permission'];
    emailPermission = json['email_permission'];
    timezone = json['timezone'];
    signupDate = json['signup_date'];
    weekStartDate = json['weekstart_date'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['bio'] = this.bio;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['height'] = this.height;
    data['current_weight'] = this.currentWeight;
    data['goal_weight'] = this.goalWeight;
    data['prefer_start_day'] = this.preferStartDay;
    data['active_phase'] = this.activePhase;
    data['allowed_phase'] = this.allowedPhase;
    data['is_membership_active'] = this.isMembershipActive;
    data['curr_week'] = this.currWeek;
    data['is_week_cycle_active'] = this.isWeekCycleActive;
    data['pause_programme'] = this.pauseProgramme;
    data['next_prefer_start_day'] = this.nextPreferStartDay;
    data['push_notification_permission'] = this.pushNotificationPermission;
    data['email_permission'] = this.emailPermission;
    data['timezone'] = this.timezone;
    data['signup_date'] = this.signupDate;
    data['weekstart_date'] = this.weekStartDate;
    data['token'] = this.token;
    return data;
  }
}
