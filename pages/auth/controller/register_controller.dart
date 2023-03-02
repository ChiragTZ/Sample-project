import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FocusNode fNameFocus = new FocusNode();
  FocusNode lNameFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController textHeightController = TextEditingController();
  TextEditingController textWeightController = TextEditingController();
  // TextEditingController textGoalWeightController = TextEditingController();

  // RxInt? selectedGender = Rx<RxInt>();
  var selectedGender = Rxn<int>();
  var selectedAge = Rxn<int>();
  var selectedDay = Rxn<int>();
  RxInt currentPage = 0.obs;

  List<String> genderList = [
    "Female",
    "Male",
    "Intersex",
  ];
  List<String> ageList = [
    "20's",
    "30's",
    "40's",
    "50's",
    "60's",
    "70+",
  ];
  List<String> dayList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  List<HealthModel> listConditions = [
    HealthModel("High Cholesterol", RxBool(false)),
    HealthModel("Pre-Diabetes", RxBool(false)),
    HealthModel("High Blood Pressure", RxBool(false)),
    HealthModel("Fatty Liver", RxBool(false)),
    HealthModel("Heart Disease", RxBool(false)),
    HealthModel("Depression", RxBool(false)),
    HealthModel("None", RxBool(false)),
  ];

  List<HabitModel> listHabit = [
    HabitModel(tr("form.habit1"), RxBool(true)),
    HabitModel(tr("form.habit2"), RxBool(false)),
    HabitModel(tr("form.habit3"), RxBool(false)),
    HabitModel(tr("form.habit4"), RxBool(false)),
    HabitModel(tr("form.habit5"), RxBool(false)),
  ];

  TextEditingController lWController = TextEditingController();
  TextEditingController hWController = TextEditingController();
  TextEditingController gainedWController = TextEditingController();

  var selectedGainedW = Rxn<int>();

  List<String> gainedWList = [
    "Yes",
    "No",
  ];
  var lowestWeightSelected = Rxn<int>();

  List<String> lowestWeightList = [
    "0-12 month",
    "1-2 year",
    "2 year+",
  ];
  var relationSelected = Rxn<int>();

  List<String> relationList = [
    "Single",
    "In a relationship",
    "Married",
    "Married with children",
  ];
  var hereSelected = Rxn<int>();

  List<String> hereList = [
    "TV",
    "Radio",
    "Other Podcast",
  ];
  var howFollowSelected = Rxn<int>();

  List<String> howFollowList = [
    "Yes",
    "No",
  ];

  List<String> listDiff = [
    tr('form.diff_1'),
    tr('form.diff_2'),
    tr('form.diff_3'),
    tr('form.diff_4'),
    tr('form.diff_5'),
    tr('form.diff_6'),
    tr('form.diff_7')
  ];

  late TabController tabController;

  List<PlanModel> yearlyPlanList = [
    PlanModel(
        "IWL Plan",
        "\$21.50/mo",
        "\$258/yr billed upfront",
        [
          'Personalised weight and habit tracker',
          'Step-by-step guide to the IWL plan',
          'IWL approved recipes',
          'Access to IWL Community'
        ],
        RxBool(true)),
    PlanModel(
        "IWL Plus",
        "\$53.75/mo",
        "\$645/yr billed upfront",
        [
          'All features of IWL Plan',
          'Personal coaching with accredited dietitian including once a month calls, and 24/7 chat support',
        ],
        RxBool(false)),
  ];

  List<PlanModel> quarterlyPlanList = [
    PlanModel(
        "IWL Plan",
        "\$29/mo",
        "\$87/qtr billed upfront",
        [
          'Personalised weight and habit tracker',
          'Step-by-step guide to the IWL plan',
          'IWL approved recipes',
          'Access to IWL Community'
        ],
        RxBool(true)),
    PlanModel(
        "IWL Plus",
        "\$71.50/mo",
        "\$214/qtr billed upfront",
        [
          'All features of IWL Plan',
          'Personal coaching with accredited dietitian including once a month calls, and 24/7 chat support',
        ],
        RxBool(false)),
  ];

  RxInt yearlyMainIndex = 0.obs;
  RxInt quarterlyMainIndex = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.index = 1;
    selectedDay.value = DateTime.parse(DateTime.now().toString()).weekday - 1;
  }
}

class HealthModel {
  String? title;
  RxBool isSelected = false.obs;

  HealthModel(this.title, this.isSelected);
}

class HabitModel {
  String? title;
  RxBool isSelected = false.obs;

  HabitModel(this.title, this.isSelected);
}

class PlanModel {
  String? title;
  String? price;
  String? totalPrice;
  List<String>? itemList;
  RxBool isSelected = false.obs;

  PlanModel(
      this.title, this.price, this.totalPrice, this.itemList, this.isSelected);
}
