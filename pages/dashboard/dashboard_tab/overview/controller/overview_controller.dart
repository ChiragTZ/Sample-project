import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/model/user_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/model/overview_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/model/rewards_response.dart';
import 'package:iwl/rest_api/api_repository.dart';
import 'package:iwl/rest_api/api_utils.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/base_response.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/preference.dart';
import 'package:iwl/utils/routes/app_pages.dart';

enum ViewType { ALL, FOCUS, CUSTOM }

class OverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Rx<TextEditingController> accStatementController =
      TextEditingController().obs;
  late Rx<FocusNode> accStatementFocus = FocusNode().obs;
  late TabController tabController;
  RxInt selectedLayout = 1.obs;
  RxBool isShowLogTreat = false.obs;
  RxBool isEditStatement = false.obs;
  RxList<FeatureModel> listFeature = <FeatureModel>[].obs;
  RxList<FeatureModel> listFeatureTemp = <FeatureModel>[].obs;
  Rx<Enum> status = Status.INITIAL.obs;
  Rx<Enum> statusStatement = Status.INITIAL.obs;
  RxBool isPullToRefresh = false.obs;
  Rx<Overview> overview = Overview().obs;
  Rx<Rewards> rewards = Rewards().obs;
  Rx<RewardsModel> clickedReward = RewardsModel().obs;

  List<Tab> tabs = [
    Tab(text: tr('score.week')),
    Tab(text: tr('score.month')),
    Tab(text: tr("score.all_time")),
  ];

  List<RewardsModel> listRewards = [
    RewardsModel(
        id: 1,
        title: tr("rewards.bronze"),
        desc: tr("rewards.bronze_desc"),
        isClaim: false,
        isClaimed: false,
        pts: "1200 pts"),
    RewardsModel(
        id: 2,
        title: tr("rewards.silver"),
        desc: tr("rewards.silver_desc"),
        isClaim: false,
        isClaimed: false,
        pts: "2000 pts"),
    RewardsModel(
        id: 3,
        title: tr("rewards.gold"),
        desc: tr("rewards.gold_desc"),
        isClaim: false,
        isClaimed: false,
        pts: "4000 pts"),
  ];

  //claim rewards
  final formKey = GlobalKey<FormBuilderState>();

  FocusNode nameFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  FocusNode phoneFocus = new FocusNode();
  FocusNode addressFocus = new FocusNode();
  FocusNode zipFocus = new FocusNode();
  FocusNode cityFocus = new FocusNode();
  FocusNode stateFocus = new FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  Rx<Books> selectedBooks = Books().obs;
  Rx<TShirt> selectedTShirt = TShirt().obs;
  Rx<TShirt> selectedCountry = TShirt().obs;

  // RxList<BookResponse> bookList = [
  //   BookResponse(tr("measure.excellent"), true),
  //   BookResponse(tr("measure.good"), false),
  //   BookResponse(tr("measure.getting_there"), false),
  //   BookResponse(tr("measure.dissatisfied"), false),
  //   BookResponse(tr("measure.struggling"), false),
  // ].obs;

  changeView(ViewType viewType) {
    if (viewType == ViewType.ALL) {
      selectedLayout.value = 1;
      for (var a in listFeatureTemp) {
        a.isSelected = true;
      }
    } else if (viewType == ViewType.FOCUS) {
      selectedLayout.value = 2;
      for (var a in listFeatureTemp) {
        a.isSelected = false;
      }
      listFeatureTemp[0].isSelected = true;
      listFeatureTemp[1].isSelected = true;
    } else {
      selectedLayout.value = 0;
    }
  }

  checkUncheckItem(int index) {
    int count = 0;
    if (listFeatureTemp[index].isSelected) {
      if (index == 2 || index == 3) {
        listFeatureTemp[2].isSelected = false;
        listFeatureTemp[3].isSelected = false;
        return;
      }
      listFeatureTemp[index].isSelected = false;
    } else {
      if (index == 2 || index == 3) {
        listFeatureTemp[2].isSelected = true;
        listFeatureTemp[3].isSelected = true;
        return;
      }
      listFeatureTemp[index].isSelected = true;
    }
    for (int i = 0; i < listFeatureTemp.length; i++) {
      if (listFeatureTemp[i].isSelected) {
        count = count + 1;
      } else {
        count = count - 1;
      }
    }

    changeView(ViewType.CUSTOM);
    if (count == 5) {
      changeView(ViewType.ALL);
    }
    if ((listFeatureTemp[0].isSelected == true &&
            listFeatureTemp[1].isSelected == true) &&
        (listFeatureTemp[2].isSelected == false &&
            listFeatureTemp[3].isSelected == false &&
            listFeatureTemp[4].isSelected == false)) {
      changeView(ViewType.FOCUS);
    }
    update();
  }

  getUserDetail() async {
    status.value = Status.LOADING;
    BaseResponse? response;
    try {
      var res = await ApiRepo().userDetail();
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        PM.write(prefKeyUserModel, response.userData!);
        var data1 = await PM.read(prefKeyUserModel, PrefEnum.MODEL);
        AppGlobal.userData = UserData.fromJson(data1);
        await getOverview();
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }

  getOverview() async {
    AppGlobal.isWeekStart =
        AppGlobal.checkDayStart(AppGlobal.userData!.weekStartDate!);
    if (!AppGlobal.isWeekStart) {
      Get.offAllNamed(Routes.HOME);
    } else {
      update();
      refresh();
    }
    if (AppGlobal.isWeekStart) {
      status.value = Status.LOADING;
      BaseResponse? response;
      try {
        var res = await ApiRepo().overview();
        response = BaseResponse.fromJson(res.data);
        if (response.status!) {
          overview.value = response.overview!;
          // accStatementController.value.text =
          //     overview.value.accountabilityStatement ??
          //         "I will prioritise my health to be a good role model ...";
          if (overview.value.accountabilityStatement!.isNotEmpty) {
            accStatementController.value.text =
                overview.value.accountabilityStatement!;
          } else {
            accStatementController.value.text = "";
          }
        }
        status.value = Status.SUCCESS;
      } catch (error) {
        status.value = Status.ERROR;
        return apiUtils.handleError(error);
      }
    }
  }

  updateAccStatement() async {
    if (accStatementController.value.text.isEmpty) {
      overview.value.accountabilityStatement =
          accStatementController.value.text;
      return;
    }
    statusStatement.value = Status.LOADING;
    BaseResponse? response;
    var data = {"statement": accStatementController.value.text};
    try {
      var res = await ApiRepo().updateAccStatement(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        overview.value.accountabilityStatement =
            accStatementController.value.text;
      } else {
        accStatementController.value.text =
            overview.value.accountabilityStatement!;
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      isEditStatement.value = false;
      statusStatement.value = Status.SUCCESS;
    } catch (error) {
      statusStatement.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }

  updateNoTreatsTakesAway(index, value) async {
    status.value = Status.LOADING;
    BaseResponse? response;
    var data = {"no_treats_takeaway": value};
    try {
      var res = await ApiRepo().updateNoTreatsTakeAway(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        overview.value.myReminders![index].noTreatTakeawayStatus = value;
        isShowLogTreat.value = false;
        if (value == 1) {
          overview.value.myReminders![index].status = "done";
        } else {
          overview.value.myReminders![index].status = "undone";
        }
        update();
      } else {
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }

  watchedWeeklyVideo(int? currentWeek) async {
    status.value = Status.LOADING;
    BaseResponse? response;
    var data = {"curr_week": currentWeek.toString()};
    try {
      var res = await ApiRepo().watchedWeeklyVideo(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        refreshIndicator();
      } else {
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }

  getReward() async {
    status.value = Status.LOADING;
    BaseResponse? response;
    try {
      var res = await ApiRepo().reward();
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        rewards.value = response.rewards!;

        if (rewards.value.myTierdata!.readyToClaim!.contains(1)) {
          listRewards[0].isClaim = true;
        }
        if (rewards.value.myTierdata!.readyToClaim!.contains(2)) {
          listRewards[1].isClaim = true;
        }
        if (rewards.value.myTierdata!.readyToClaim!.contains(3)) {
          listRewards[2].isClaim = true;
        }

        if (rewards.value.myTierdata!.alreadyClaimed!.contains(1)) {
          listRewards[0].isClaimed = true;
        }
        if (rewards.value.myTierdata!.alreadyClaimed!.contains(2)) {
          listRewards[1].isClaimed = true;
        }
        if (rewards.value.myTierdata!.alreadyClaimed!.contains(3)) {
          listRewards[2].isClaimed = true;
        }
        listRewards[2].desc = tr("rewards.gold_desc") +
            rewards.value.myTierdata!.goalSetPoint!.toString() +
            tr("rewards.gold_desc1");
      }

      if (rewards.value.countries != null &&
          rewards.value.countries!.isNotEmpty) {}
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }

  claimReward() async {
    if (formKey.currentState!.validate()) {
      if (selectedBooks.value.id != null &&
          clickedReward.value.title == "Bronze") {
        showSnackBar(StatusEnum.ERROR,
            title: "Error", desc: "Please select book", isShowIcon: true);
        return;
      }
      if (selectedTShirt.value.id == null &&
          clickedReward.value.title == "Silver") {
        showSnackBar(StatusEnum.ERROR,
            title: "Error",
            desc: "Please select T-shirt size",
            isShowIcon: true);
        return;
      }

      if (selectedCountry.value.id == null) {
        showSnackBar(StatusEnum.ERROR,
            title: "Error", desc: "Please select country", isShowIcon: true);
        return;
      }
      status.value = Status.LOADING;
      dynamic data = {
        "fullname": nameController.text.toString(),
        "email": emailController.text.toString(),
        "phone": phoneController.text.toString(),
        "address": addressController.text.toString(),
        "zip": zipController.text.toString(),
        "city": cityController.text.toString(),
        "state": stateController.text.toString(),
        "country": selectedCountry.value.id,
        "tier": clickedReward.value.id,
        "book": selectedBooks.value.id ?? "",
        "tshirtsize": selectedTShirt.value.id ?? "",
      };
      status.value = Status.LOADING;
      BaseResponse? response;
      try {
        var res = await ApiRepo().claimReward(data);
        response = BaseResponse.fromJson(res.data);
        if (response.status!) {
          getOverview();
          getReward();
          // rewards.value = response.rewards!;
          Get.toNamed(Routes.SUCCESS, arguments: {
            "title": "Claim Submitted",
            "desc": "Please be patient while we ship your goods!",
            "goToText": "Return to Rewards",
          });
        } else {
          showSnackBar(StatusEnum.ERROR, desc: response.message);
        }
        status.value = Status.SUCCESS;
      } catch (error) {
        status.value = Status.ERROR;
        return apiUtils.handleError(error);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
    tabController = TabController(length: 3, vsync: this);
    listFeature.value = [
      FeatureModel(tr("customize.accountability_statement"), true),
      FeatureModel(tr("customize.treats_takeaway_log"), true),
      FeatureModel(tr("customize.scoreboard"), true),
      FeatureModel(tr("customize.rewards_points"), true),
      FeatureModel(tr("customize.your_reminders"), true),
    ];
    listFeatureTemp.value = List.from(listFeature);

    // listFeatureTemp.removeAt(0);
    print(listFeature.length.toString());
    print(listFeatureTemp.length.toString());
  }

  double getReminderProgress() {
    // double progress = 0.0;
    int done = 0;
    overview.value.myReminders!.forEach((element) {
      if (element.status != "undone") {
        done++;
      }
    });
    return done / overview.value.myReminders!.length;
    // print('done ${done / overview.value.myReminders!.length}');
    // print('done1 $done');
    // print('progress $progress');
    // if (progress == 0) {
    //   return progress = 1;
    // } else if (progress == 1) {
    //   return progress = 0;
    // } else {
    //   return progress;
    // }
  }

  refreshIndicator() async {
    isPullToRefresh.value = true;
    await getUserDetail();
    isPullToRefresh.value = false;
  }
}

class FeatureModel {
  String? title;
  bool isSelected;
  FeatureModel(this.title, this.isSelected);

  FeatureModel.clone(FeatureModel source)
      : this.title = source.title,
        this.isSelected = source.isSelected;
}

class RewardsModel {
  String? title;
  String? desc;
  bool? isClaim;
  bool? isClaimed;
  String? pts;
  int? id;

  RewardsModel(
      {this.id, this.title, this.desc, this.isClaim, this.isClaimed, this.pts});
}
