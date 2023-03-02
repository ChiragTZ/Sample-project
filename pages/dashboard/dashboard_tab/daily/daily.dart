import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/daily/controller/daily_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/daily/model/habit_response.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/widgets/decoration/boxDecoration.dart';
import 'package:iwl/widgets/decoration/inputDecoration.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyPage extends GetView<DailyController> {
  final DailyController controller = Get.put(DailyController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppGlobal.isWeekStart
        ? Obx(
            () => showLoader(
              isLoading: controller.status.value == Status.LOADING &&
                  !controller.isPullToRefresh.value,
              child: CustomScrollView(
                controller: controller.scrollController.value,
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () => controller.refreshIndicator(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Obx(
                          () => SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Daily Habits',
                                          style: textTheme.headline5,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // final HomeController homeController =
                                          //     Get.put(HomeController());
                                          // homeController.page.value = 1;
                                          // final ProgressTrackerController pTController =
                                          //     Get.put(ProgressTrackerController());
                                          // pTController.selectedIndex.value = 0;
                                          habitBottomSheet(context);
                                        },
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Modify habits',
                                            style: textTheme.subtitle1!
                                                .copyWith(
                                                    fontSize: 13,
                                                    color: colorSecondary),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  margin:
                                      EdgeInsets.fromLTRB(5.w, 3.w, 5.w, 3.w),
                                  decoration: boxDecorationDashboard(),
                                  child: Obx(
                                    () => Showcase(
                                      tooltipBorderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      disableMovingAnimation: true,
                                      targetBorderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      key: AppGlobal.four,
                                      onTargetClick: () async {
                                        controller.scrollController.value
                                            .animateTo(
                                                controller
                                                    .scrollController
                                                    .value
                                                    .position
                                                    .maxScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.ease);
                                        controller.update();
                                        await Future.delayed(
                                            Duration(milliseconds: 500));
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) async {
                                          ShowCaseWidget.of(Get.context!)
                                              .startShowCase([
                                            AppGlobal.five,
                                          ]);
                                        });
                                      },
                                      onToolTipClick: () {},
                                      disposeOnTap: false,
                                      // targetPadding: EdgeInsets.only(left: 100),
                                      tooltipPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      titleAlignment: TextAlign.center,
                                      titleTextStyle: Theme.of(Get.context!)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: colorBlue),
                                      description: "",
                                      title:
                                          "Track and build habits with the IWL principles",
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 20, 15, 10),
                                            child: TableCalendar(
                                              calendarFormat:
                                                  CalendarFormat.week,
                                              calendarStyle: CalendarStyle(
                                                canMarkersOverflow: false,
                                                tablePadding: EdgeInsets.zero,

                                                // todayDecoration: Colors.orange,
                                                // selectedDecoration: Theme.of(context).primaryColor,
                                                todayTextStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Colors.white),
                                              ),
                                              headerVisible: false,
                                              startingDayOfWeek:
                                                  StartingDayOfWeek.monday,
                                              calendarBuilders:
                                                  CalendarBuilders(
                                                selectedBuilder: (context, date,
                                                        events) =>
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                colorSecondary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Text(
                                                          date.day.toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                todayBuilder: (context, date,
                                                        events) =>
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .all(4.0),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: colorWhite,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        child: Text(
                                                          date.day.toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                              ),
                                              focusedDay:
                                                  controller.focusedDay.value,
                                              firstDay: DateTime.parse(AppGlobal
                                                  .userData!.weekStartDate
                                                  .toString()),
                                              lastDay: DateTime.now(),
                                              onPageChanged: (focusedDay) {
                                                controller.focusedDay.value =
                                                    focusedDay;
                                              },
                                              selectedDayPredicate: (day) {
                                                // Use `selectedDayPredicate` to determine which day is currently selected.
                                                // If this returns true, then `day` will be marked as selected.

                                                // Using `isSameDay` is recommended to disregard
                                                // the time-part of compared DateTime objects.
                                                return isSameDay(
                                                    controller
                                                        .selectedDay.value,
                                                    day);
                                              },
                                              onDaySelected:
                                                  (selectedDay, focusedDay) {
                                                if (!isSameDay(
                                                    controller
                                                        .selectedDay.value,
                                                    selectedDay)) {
                                                  // Call `setState()` when updating the selected day
                                                  controller.selectedDay.value =
                                                      selectedDay;
                                                  controller.focusedDay.value =
                                                      focusedDay;
                                                  print(selectedDay);
                                                  controller.getHabits();
                                                }
                                              },
                                            ),
                                          ),
                                          // SizedBox(height: 5),
                                          // Center(
                                          //   child: Text(
                                          //     DateFormat('EEEE, d MMM, yyyy')
                                          //         .format(controller.selectedDay.value)
                                          //         .toString(),
                                          //     style: textTheme.headline5!.copyWith(
                                          //         fontWeight: FontWeight.w400, color: colorBlack),
                                          //   ),
                                          // ),
                                          Divider(),
                                          controller.habits.value.habitList !=
                                                  null
                                              ? ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return controller
                                                                .habits
                                                                .value
                                                                .habitList![
                                                                    index]
                                                                .isDisabled ==
                                                            0
                                                        ? Divider()
                                                        : Container();
                                                  },
                                                  itemCount: controller.habits
                                                      .value.habitList!.length,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 20, 20, 10),
                                                  // padding: EdgeInsets.only(top: 10, bottom: 15),
                                                  itemBuilder:
                                                      (context, index) {
                                                    HabitList data = controller
                                                        .habits
                                                        .value
                                                        .habitList![index];
                                                    return data.isDisabled == 0
                                                        ? InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .selectUnSelectHabit(
                                                                      index);
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Transform
                                                                        .scale(
                                                                      scale:
                                                                          1.3,
                                                                      child: Checkbox(
                                                                          value: data.isTicked == 1 ? true : false,
                                                                          checkColor: colorWhite,
                                                                          activeColor: colorSecondary,
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(3),
                                                                          ),
                                                                          onChanged: ((value) {
                                                                            controller.selectUnSelectHabit(index);
                                                                          })),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        data.value ??
                                                                            "",
                                                                        style: textTheme
                                                                            .bodyText1,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    if (data.isTicked == 1 &&
                                                                        data.streak !=
                                                                            null &&
                                                                        data.streak !=
                                                                            0)
                                                                      Text(
                                                                        data.streak
                                                                            .toString(),
                                                                        style: textTheme
                                                                            .subtitle1!
                                                                            .copyWith(color: Colors.orange),
                                                                      ),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    if (data.isTicked == 1 &&
                                                                        data.streak !=
                                                                            null &&
                                                                        data.streak !=
                                                                            0)
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/fire.svg"),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container();
                                                  },
                                                )
                                              : noDataFound(),
                                          // ButtonView1(
                                          //   text: tr("daily.edit_habits"),
                                          //   width: 150,
                                          //   margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
                                          //   onPressed: () {
                                          //     habitBottomSheet(context);
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                  child: Text(
                                    "Weekly Log",
                                    style: textTheme.headline5,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  margin:
                                      EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 5.w),
                                  decoration: boxDecorationDashboard(),
                                  child: Showcase(
                                    tooltipBorderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    targetBorderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    key: AppGlobal.five,
                                    // targetPadding: EdgeInsets.only(left: 100),
                                    tooltipPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    titleAlignment: TextAlign.center,
                                    titleTextStyle: Theme.of(Get.context!)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: colorBlue),
                                    onTargetClick: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) async {
                                        ShowCaseWidget.of(Get.context!)
                                            .startShowCase([
                                          AppGlobal.six,
                                        ]);
                                      });
                                    },
                                    onToolTipClick: () {},
                                    disposeOnTap: false,
                                    disableScaleAnimation: false,
                                    description: "",
                                    title:
                                        "During washout month, you can have up to 2 treats or takeout meals a week",
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListView.separated(
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const Divider();
                                            },
                                            shrinkWrap: true,
                                            primary: false,
                                            padding: EdgeInsets.only(
                                              top: 10,
                                            ),
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                              .listTreat[index]
                                                              .title ??
                                                          "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ),
                                                    if (controller
                                                            .listTreat[index]
                                                            .count! >=
                                                        controller
                                                            .listTreat[index]
                                                            .totalCount!)
                                                      SizedBox(height: 5),
                                                    if (controller
                                                            .listTreat[index]
                                                            .count! >=
                                                        controller
                                                            .listTreat[index]
                                                            .totalCount!)
                                                      Text(
                                                        index == 0
                                                            ? controller
                                                                .habits
                                                                .value
                                                                .treatsMsgDisplay!
                                                            : controller
                                                                .habits
                                                                .value
                                                                .takeawayMsgDisplay!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color:
                                                                    colorBlue,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                  ],
                                                ),
                                                trailing: Container(
                                                  width: 28.w,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .updateTreatTakeAway(
                                                                  index,
                                                                  "minus");
                                                        },
                                                        child: Container(
                                                          width: 8.w,
                                                          height: 8.w,
                                                          decoration:
                                                              boxdecoration(
                                                            colorCustomizeGrey,
                                                            colorCustomizeGrey,
                                                            10.0,
                                                            0.0,
                                                          ),
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: colorBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Obx(
                                                            () => Text(
                                                              "${controller.listTreat[index].count}/${controller.listTreat[index].totalCount}",
                                                              style: textTheme
                                                                  .headline4,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .updateTreatTakeAway(
                                                                  index,
                                                                  "plus");
                                                        },
                                                        child: Container(
                                                          width: 8.w,
                                                          height: 8.w,
                                                          decoration:
                                                              boxdecoration(
                                                            colorTeal50,
                                                            colorTeal50,
                                                            10.0,
                                                            0.0,
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            color:
                                                                colorTealDark,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                              );
                                            },
                                            itemCount:
                                                controller.listTreat.length,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h)
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: Text(
              "Your weekly cycle start on ${viewFormatDate.format(DateTime.parse(AppGlobal.userData!.weekStartDate.toString()))}",
              style: textTheme.headline5,
            ),
          );
  }

  habitBottomSheet(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      builder: (context) {
        return Obx(
          () => showLoader(
            isLoading: controller.habitLoadingStatus.value == Status.LOADING,
            child: Container(
              height: 80.h,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                if (controller.isEdit.value)
                                  InkWell(
                                    onTap: () =>
                                        controller.isEdit.value = false,
                                    child: Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        tr("common.cancel"),
                                        style: textTheme.bodyText1!
                                            .copyWith(color: colorSecondary),
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    "Modify habits",
                                    textAlign: TextAlign.center,
                                    style: textTheme.subtitle1,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (controller.isEdit.value) {
                                      controller.isEdit.value = false;
                                    } else {
                                      controller.isEdit.value = true;
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      !controller.isEdit.value
                                          ? "Edit"
                                          : "Done",
                                      textAlign: TextAlign.center,
                                      style: textTheme.subtitle1!
                                          .copyWith(color: colorSecondary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Scaffold(
                              resizeToAvoidBottomInset: true,
                              body: Obx(
                                () => ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  itemBuilder: (context, index) {
                                    HabitList habit = controller
                                        .habits.value.habitList![index];
                                    return Column(
                                      children: [
                                        Slidable(
                                          closeOnScroll: true,
                                          enabled:
                                              false, //not in use because design chagne
                                          key: const ValueKey(0),
                                          endActionPane: ActionPane(
                                            motion: ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                // An action can be bigger than the others.
                                                onPressed: (context) {
                                                  habit.isRename = true;
                                                  //controller.listHabit.refresh();
                                                },
                                                backgroundColor: colorGrey,
                                                foregroundColor: colorWhite,
                                                label: tr("common.rename"),
                                                padding: EdgeInsets.zero,
                                              ),
                                              SlidableAction(
                                                onPressed: (context) {
                                                  showActionDialog(context,
                                                      desc: tr(
                                                          "common.delete_desc"),
                                                      positiveButton: "Delete",
                                                      negativeButton: "Cancel",
                                                      functionCallBack:
                                                          (value) {
                                                    if (value) {
                                                      controller.deleteHabit();
                                                    }
                                                  });
                                                },
                                                backgroundColor: Colors.red,
                                                foregroundColor: colorWhite,
                                                label: tr("common.delete"),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                title: TextFormField(
                                                  decoration:
                                                      inputDecorationNone(
                                                              context, '')
                                                          .copyWith(
                                                    filled: habit.value ==
                                                                null ||
                                                            habit.value!
                                                                .isEmpty ||
                                                            habit.isRename ==
                                                                true
                                                        ? true
                                                        : false,
                                                    fillColor:
                                                        colorCustomizeGrey,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                  ),
                                                  controller: habit.id != null
                                                      ? null
                                                      : habit.controller,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  onFieldSubmitted: (value) {
                                                    if (habit.isRename &&
                                                        habit.type ==
                                                            "custom") {
                                                      controller.updateHabit(
                                                          value, habit.id);
                                                    } else {
                                                      controller
                                                          .addNewHabit(value);
                                                    }
                                                  },
                                                  initialValue: habit.value,
                                                  cursorColor: colorBlack,
                                                  enabled:
                                                      habit.value == null ||
                                                              habit.value!
                                                                  .isEmpty ||
                                                              habit.isRename ==
                                                                  true
                                                          ? true
                                                          : false,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                          color: colorBlack,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                  autocorrect: false,
                                                  maxLines: null,
                                                ),
                                                leading: Transform.scale(
                                                  scale: 0.9,
                                                  child: CupertinoSwitch(
                                                    onChanged: (value) {
                                                      controller
                                                          .enableDisableHabit(
                                                              index);
                                                    },
                                                    value: habit.isDisabled == 0
                                                        ? true
                                                        : false,
                                                    activeColor: colorPrimary,
                                                  ),
                                                ),
                                                trailing: controller
                                                            .isEdit.value &&
                                                        habit.type == 'custom'
                                                    ? Container(
                                                        height: 15,
                                                        width: 15,
                                                        decoration: habit
                                                                    .type ==
                                                                "custom"
                                                            ? BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                border: Border.all(
                                                                    color:
                                                                        colorHint),
                                                                color:
                                                                    colorWhite)
                                                            : null,
                                                        child: CircleAvatar(
                                                          backgroundColor: controller
                                                                      .isEdit
                                                                      .value &&
                                                                  habit.isEdit
                                                              ? colorSecondary
                                                              : Colors
                                                                  .transparent,
                                                          child: controller
                                                                      .isEdit
                                                                      .value &&
                                                                  habit.isEdit
                                                              ? Icon(
                                                                  Icons.check,
                                                                  color:
                                                                      colorWhite,
                                                                  size: 10,
                                                                )
                                                              : null,
                                                        ),
                                                      )
                                                    : null,
                                                contentPadding: EdgeInsets.zero,
                                                onTap: () {
                                                  if (controller.isEdit.value &&
                                                      habit.type == "custom") {
                                                    controller
                                                        .habits.value.habitList!
                                                        .forEach((element) {
                                                      element.isEdit = false;
                                                    });
                                                    if (controller
                                                        .isEdit.value) {
                                                      habit.isEdit = true;
                                                    } else {
                                                      habit.isEdit = false;
                                                    }
                                                    controller.isSelected
                                                        .value = true;
                                                    controller.habits.refresh();
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (index ==
                                                controller.habits.value
                                                        .habitList!.length -
                                                    1 &&
                                            !controller.isEdit.value)
                                          InkWell(
                                            onTap: () {
                                              if (controller.habits.value
                                                      .habitList![index].id !=
                                                  null) {
                                                controller
                                                    .habits.value.habitList!
                                                    .add(HabitList(
                                                  isDisabled: 0,
                                                  type: "custom",
                                                ));
                                                controller.habits.refresh();
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 15),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add,
                                                      size: 25,
                                                      color: colorNeutral80),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    tr("daily.add_custom_habit"),
                                                    style: textTheme.bodyText1!
                                                        .copyWith(
                                                            color:
                                                                colorNeutral80),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                  itemCount:
                                      controller.habits.value.habitList!.length,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.isEdit.value)
                    Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      decoration: BoxDecoration(
                          color: colorCustomizeGrey,
                          border: Border(
                              top: BorderSide(width: 1, color: colorGrey))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (controller.isEdit.value)
                            InkWell(
                              onTap: () {
                                controller.habits.value.habitList!
                                    .forEach((element) {
                                  if (element.isEdit) {
                                    element.isRename = true;
                                  }
                                });
                                controller.habits.refresh();
                              },
                              child: Text(
                                tr("common.rename"),
                                textAlign: TextAlign.center,
                                style: textTheme.bodyText1!.copyWith(
                                    color: controller.isSelected.value
                                        ? colorSecondary
                                        : colorGreyText),
                              ),
                            ),
                          InkWell(
                            onTap: () {
                              if (controller.isSelected.value) {
                                showActionDialog(context,
                                    desc: tr("common.delete_desc"),
                                    positiveButton: "Delete",
                                    negativeButton: "Cancel",
                                    functionCallBack: (value) {
                                  if (value) {
                                    controller.isSelected.value = false;
                                    controller.deleteHabit();
                                  }
                                });
                              }
                            },
                            child: Text(
                              tr("common.delete"),
                              textAlign: TextAlign.center,
                              style: textTheme.bodyText1!.copyWith(
                                  color: controller.isSelected.value
                                      ? colorError
                                      : colorGreyText),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
