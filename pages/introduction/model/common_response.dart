class HomeCarouselSlider {
  String? title;
  String? description;
  String? image;

  HomeCarouselSlider({this.title, this.description, this.image});

  HomeCarouselSlider.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

class Signup {
  String? inGoodHands;
  List<String>? happyToHere;

  Signup({this.inGoodHands, this.happyToHere});

  Signup.fromJson(Map<String, dynamic> json) {
    inGoodHands = json['in_good_hands'];
    happyToHere = json['happy_to_here'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['in_good_hands'] = this.inGoodHands;
    data['happy_to_here'] = this.happyToHere;
    return data;
  }
}
