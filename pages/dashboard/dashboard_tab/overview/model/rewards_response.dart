class Rewards {
  List<Tier>? tier;
  Mytierdata? myTierdata;
  List<Books>? books;
  List<TShirt>? tShirt;
  List<TShirt>? countries;

  Rewards(
      {this.tier, this.myTierdata, this.books, this.tShirt, this.countries});

  Rewards.fromJson(Map<String, dynamic> json) {
    if (json['tier'] != null) {
      tier = <Tier>[];
      json['tier'].forEach((v) {
        tier!.add(new Tier.fromJson(v));
      });
    }
    myTierdata = json['mytierdata'] != null
        ? new Mytierdata.fromJson(json['mytierdata'])
        : null;
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
    if (json['tshirt'] != null) {
      tShirt = <TShirt>[];
      json['tshirt'].forEach((v) {
        tShirt!.add(new TShirt.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <TShirt>[];
      json['countries'].forEach((v) {
        countries!.add(new TShirt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tier != null) {
      data['tier'] = this.tier!.map((v) => v.toJson()).toList();
    }
    if (this.myTierdata != null) {
      data['mytierdata'] = this.myTierdata!.toJson();
    }
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    if (this.tShirt != null) {
      data['tshirt'] = this.tShirt!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tier {
  int? point;
  String? name;
  String? label;
  int? id;

  Tier({this.point, this.name, this.label, this.id});

  Tier.fromJson(Map<String, dynamic> json) {
    point = json['point'];
    name = json['name'];
    label = json['label'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point'] = this.point;
    data['name'] = this.name;
    data['label'] = this.label;
    data['id'] = this.id;
    return data;
  }
}

class Mytierdata {
  String? myTier;
  List<int>? readyToClaim;
  List<int>? alreadyClaimed;
  int? myTierId;
  String? fullName;
  int? rewardPoints;
  int? goalSetPoint;

  Mytierdata(
      {this.myTier,
      this.readyToClaim,
      this.alreadyClaimed,
      this.myTierId,
      this.fullName,
      this.rewardPoints,
      this.goalSetPoint});

  Mytierdata.fromJson(Map<String, dynamic> json) {
    myTier = json['my_tier'];
    if (json['ready_to_claim'] != null) {
      readyToClaim = <int>[];
      readyToClaim = json['ready_to_claim'].cast<int>();
    }

    if (json['already_claimed'] != null) {
      alreadyClaimed = <int>[];
      alreadyClaimed = json['already_claimed'].cast<int>();
    }
    myTierId = json['my_tier_id'];
    fullName = json['fullname'];
    rewardPoints = json['reward_points'];
    goalSetPoint = json['goal_set_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['my_tier'] = this.myTier;
    data['already_claimed'] = this.alreadyClaimed;
    data['readyToClaim'] = this.alreadyClaimed;
    if (this.readyToClaim != null) {
      data['ready_to_claim'] = this.readyToClaim;
    }
    if (this.alreadyClaimed != null) {
      data['already_claimed'] = this.alreadyClaimed;
    }
    // if (this.alreadyClaimed != null) {
    //   data['already_claimed'] =
    //       this.alreadyClaimed!.map((v) => v.toJson()).toList();
    // }
    data['my_tier_id'] = this.myTierId;
    data['fullname'] = this.fullName;
    data['reward_points'] = this.rewardPoints;
    data['goal_set_point'] = this.goalSetPoint;
    return data;
  }
}

class Books {
  String? name;
  int? price;
  String? priceDisplay;
  int? id;

  Books({this.name, this.price, this.priceDisplay, this.id});

  Books.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    priceDisplay = json['price_display'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_display'] = this.priceDisplay;
    data['id'] = this.id;
    return data;
  }
}

class TShirt {
  int? id;
  String? name;

  TShirt({this.id, this.name});

  TShirt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
