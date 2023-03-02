import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/daily/model/habit_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/controller/overview_controller.dart';
import 'package:iwl/rest_api/api_utils.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/common_widget.dart';

import '../../../../../rest_api/api_repository.dart';
import '../../../../../utils/base_response.dart';

class DailyController extends GetxController {
  // RxList<HabitModel> listHabit = <HabitModel>[].obs;
  RxList<TreatModel> listTreat = [
    TreatModel(tr("daily.add_your_treat_foods"), 1, 2),
    TreatModel(tr("daily.add_your_takeaway_or_dine_out_meals"), 0, 2),
  ].obs;
  RxBool isPullToRefresh = false.obs;
  RxBool isEdit = false.obs;
  RxBool isSelected = false.obs;

  List<HabitModel> listEnabledHabit = <HabitModel>[].obs;

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  Rx<Enum> status = Status.INITIAL.obs;
  Rx<Enum> habitLoadingStatus = Status.INITIAL.obs;
  Rx<Habits> habits = Habits().obs;

  refreshIndicator() async {
    isPullToRefresh.value = true;
    await getHabits();
    isPullToRefresh.value = false;
  }

  Rx<ScrollController> scrollController = ScrollController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (AppGlobal.isWeekStart) {
      if (AppGlobal.checkDayStart(apiFormat.format(selectedDay.value))) {
        focusedDay.value = focusedDay.value.subtract(Duration(days: 1));
        selectedDay.value = selectedDay.value.subtract(Duration(days: 1));
      } else {
        focusedDay.value = focusedDay.value.add(Duration(days: 1));
        selectedDay.value = selectedDay.value.add(Duration(days: 1));
      }
      getHabits();
    }
    // listHabit.value = [
    //   HabitModel(
    //       tr("daily.habit1"), RxBool(false), RxBool(true), 1, RxBool(false)),
    //   HabitModel(
    //       tr("daily.habit2"), RxBool(false), RxBool(true), 3, RxBool(false)),
    //   HabitModel(
    //       tr("daily.habit3"), RxBool(false), RxBool(true), 12, RxBool(false)),
    //   HabitModel(
    //       tr("daily.habit4"), RxBool(false), RxBool(true), 1, RxBool(false)),
    //   HabitModel(
    //       tr("daily.habit5"), RxBool(false), RxBool(false), 5, RxBool(false)),
    //   HabitModel(
    //       tr("daily.habit6"), RxBool(false), RxBool(false), 1, RxBool(false)),
    // ];
    // for (var i in listHabit) {
    //   if (i.isEnable.value) {
    //     listEnabledHabit.add(i);
    //   }
    // }
  }

  getHabits() async {
    isEdit.value = false;
    isSelected.value = false;
    status.value = Status.LOADING;
    dynamic data = {
      "date": apiFormat.format(selectedDay.value).toString(),
    };
    status.value = Status.LOADING;
    BaseResponse? response;
    try {
      var res = await ApiRepo().getDashboardHabit(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        habits.value = response.habits!;

        listTreat[0].totalCount = habits.value.treatLimit;
        listTreat[0].count = habits.value.treats;
        listTreat[1].totalCount = habits.value.treatLimit;
        listTreat[1].count = habits.value.takeaway;
      } else {
        habits.value = Habits();
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }

  selectUnSelectHabit(int index) async {
    status.value = Status.LOADING;
    if (habits.value.habitList![index].isTicked == 1) {
      habits.value.habitList![index].isTicked = 0;
    } else {
      habits.value.habitList![index].isTicked = 1;
    }

    String habit1 = "";
    String habit2 = "";
    String habit3 = "";
    habits.value.habitList!.forEach((element) {
      if (element.isTicked == 1 &&
          element.category == 1 &&
          element.isDisabled == 0) {
        if (habit1.isEmpty) {
          habit1 = element.id.toString();
        } else {
          habit1 = habit1 + "," + element.id.toString();
        }
      } else if (element.isTicked == 1 &&
          element.category == 2 &&
          element.isDisabled == 0) {
        if (habit2.isEmpty) {
          habit2 = element.id.toString();
        } else {
          habit2 = habit2 + "," + element.id.toString();
        }
      } else if (element.isTicked == 1 &&
          element.category == 3 &&
          element.isDisabled == 0) {
        if (habit3.isEmpty) {
          habit3 = element.id.toString();
        } else {
          habit3 = habit3 + "," + element.id.toString();
        }
      }
    });

    dynamic data = {
      "date": apiFormat.format(selectedDay.value).toString(),
      "habits1": habit1,
      "habits2": habit2,
      "habits3": habit3,
      "selected_habit": habits.value.habitList![index].id,
    };

    BaseResponse? response;
    try {
      var res = await ApiRepo().selectUnSelectHabit(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        getHabits();
        final OverviewController controller = Get.find();
        controller.getOverview();
      } else {
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      showSnackBar(StatusEnum.ERROR, title: "Error", desc: error.toString());
      status.value = Status.ERROR;
      getHabits();
      return apiUtils.handleError(error);
    }
  }

  enableDisableHabit(int index) async {
    status.value = Status.LOADING;
    if (habits.value.habitList![index].isDisabled == 0) {
      habits.value.habitList![index].isDisabled = 1;
      habits.refresh();
    } else {
      habits.value.habitList![index].isDisabled = 0;
      habits.refresh();
    }
    dynamic data = {
      "date": apiFormat.format(selectedDay.value).toString(),
      "habitid": habits.value.habitList![index].id.toString(),
      "type": habits.value.habitList![index].isDisabled.toString(),
    };
    BaseResponse? response;
    try {
      var res = await ApiRepo().enableDisableHabit(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        //habits.value = response.habits!;
      } else {
        getHabits();
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      getHabits();
      return apiUtils.handleError(error);
    }
  }

  addNewHabit(value) async {
    habitLoadingStatus.value = Status.LOADING;
    dynamic data = {
      "habit": value,
    };
    BaseResponse? response;
    try {
      var res = await ApiRepo().addNewHabit(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        getHabits();
        showSnackBar(StatusEnum.SUCCESS,
            title: "Success", desc: response.message);
      } else {
        getHabits();
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      habitLoadingStatus.value = Status.SUCCESS;
    } catch (error) {
      habitLoadingStatus.value = Status.ERROR;
      getHabits();
      return apiUtils.handleError(error);
    }
  }

  updateHabit(value, int? id) async {
    habitLoadingStatus.value = Status.LOADING;
    dynamic data = {
      "habit": value,
      "habitid": id.toString(),
    };
    BaseResponse? response;
    try {
      var res = await ApiRepo().updateHabit(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        getHabits();
        showSnackBar(StatusEnum.SUCCESS,
            title: "Success", desc: response.message);
      } else {
        getHabits();
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      habitLoadingStatus.value = Status.SUCCESS;
    } catch (error) {
      habitLoadingStatus.value = Status.ERROR;
      getHabits();
      return apiUtils.handleError(error);
    }
  }

  deleteHabit() async {
    habitLoadingStatus.value = Status.LOADING;
    var habitId;
    habits.value.habitList!.forEach((element) {
      if (element.type == "custom" && element.isEdit) {
        habitId = element.id!;
      }
    });
    dynamic data = {
      "habitid": habitId,
    };
    BaseResponse? response;
    try {
      var res = await ApiRepo().deleteHabit(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        getHabits();
        showSnackBar(StatusEnum.SUCCESS,
            title: "Success", desc: response.message);
      } else {
        getHabits();
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      habitLoadingStatus.value = Status.SUCCESS;
    } catch (error) {
      habitLoadingStatus.value = Status.ERROR;
      getHabits();
      return apiUtils.handleError(error);
    }
  }

  updateTreatTakeAway(int index, String action) async {
    if (action == "plus") {
      listTreat[index].count = listTreat[index].count! + 1;
    } else {
      if (listTreat[index].count == 0) {
        return;
      }
      listTreat[index].count = listTreat[index].count! - 1;
    }
    status.value = Status.LOADING;
    dynamic data = {
      "logfor": index == 0 ? "treat_foods" : "takeaway",
      "date": apiFormat.format(selectedDay.value).toString(),
      "count": listTreat[index].count.toString(),
      "action": action, //"minus, plus",
    };
    BaseResponse? response;
    try {
      var res = await ApiRepo().updateTreatTakeAway(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        getHabits();
        final OverviewController controller = Get.find();
        controller.getOverview();
        showSnackBar(StatusEnum.SUCCESS,
            title: "Success", desc: response.message);
      } else {
        getHabits();
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      habitLoadingStatus.value = Status.SUCCESS;
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      habitLoadingStatus.value = Status.ERROR;
      getHabits();
      return apiUtils.handleError(error);
    }

    // if (listTreat[index].count != 0) {
    //   listTreat[index].count = listTreat[index].count! - 1;
    // }
    // listTreat.refresh();
  }
}

class HabitModel {
  String? title;
  RxBool isCompleted = false.obs;
  RxBool isEnable = false.obs;
  int? count;
  RxBool isRename = false.obs;

  HabitModel(
      this.title, this.isCompleted, this.isEnable, this.count, this.isRename);
}

class TreatModel {
  String? title;
  int? count;
  int? totalCount;

  TreatModel(this.title, this.count, this.totalCount);
}
