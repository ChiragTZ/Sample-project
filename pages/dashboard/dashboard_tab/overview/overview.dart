import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/controller/overview_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/model/overview_response.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/AssetsHelper.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/buttons/ButtonView1.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:iwl/widgets/decoration/boxDecoration.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

class OverViewPage extends GetView<OverviewController> {
  final OverviewController controller = Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppGlobal.isWeekStart
        ? Obx(
            () => showLoader(
              isLoading: controller.status.value == Status.LOADING &&
                  !controller.isPullToRefresh.value,
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: [
                      CupertinoSliverRefreshControl(
                        onRefresh: () => controller.refreshIndicator(),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Obx(
                              () => Column(
                                children: [
                                  welcomeView(textTheme),
                                  if (controller.listFeature[0].isSelected)
                                    accountabilityStatementView(textTheme),
                                  if (controller.listFeature[2].isSelected)
                                    if (controller
                                            .overview.value.rewardPoints !=
                                        null)
                                      rewardView(textTheme, context),
                                  if (controller.listFeature[4].isSelected)
                                    myReminder(textTheme),
                                  ButtonView1(
                                    text: tr("overview.customise"),
                                    width: 50.w,
                                    onPressed: () {
                                      customizeBottomSheet(context);
                                    },
                                  ),
                                  getFieldSeparator()
                                ],
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),
                  // Positioned(
                  //   child: Center(
                  //     child: Showcase(
                  //         tooltipBorderRadius: BorderRadius.only(
                  //           bottomLeft: Radius.circular(0),
                  //           topRight: Radius.circular(30),
                  //           topLeft: Radius.circular(30),
                  //           bottomRight: Radius.circular(30),
                  //         ),
                  //         key: AppGlobal.one,
                  //         showArrow: false,
                  //         onTargetClick: () {
                  //           // WidgetsBinding.instance
                  //           //     .addPostFrameCallback((_) async {
                  //           //   ShowCaseWidget.of(Get.context!).next();
                  //           // });
                  //           WidgetsBinding.instance
                  //               .addPostFrameCallback((_) async {
                  //             ShowCaseWidget.of(Get.context!).startShowCase([
                  //               AppGlobal.two,
                  //             ]);
                  //           });
                  //         },
                  //         onToolTipClick: () {
                  //           WidgetsBinding.instance
                  //               .addPostFrameCallback((_) async {
                  //             ShowCaseWidget.of(Get.context!).startShowCase([
                  //               AppGlobal.two,
                  //             ]);
                  //           });
                  //         },
                  //         disposeOnTap: true,
                  //         blurValue: 3,
                  //         disableMovingAnimation: true,
                  //         title:
                  //             "Welcome, ${AppGlobal.userData!.firstname}! Let’s get you started",
                  //         tooltipPadding: EdgeInsets.symmetric(
                  //             vertical: 15, horizontal: 30),
                  //         titleAlignment: TextAlign.center,
                  //         titleTextStyle: textTheme.headline5!.copyWith(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 19,
                  //             color: colorBlue),
                  //         description: "",
                  //         child: Container(width: 0, height: 0)),
                  //   ),
                  // )
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

  customizeBottomSheet(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    double smallSize = 20;
    double bigBox = 40;
    double smallSize1 = 30;
    double bigBox1 = 50;
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
                // //duration: const Duration(seconds: 10),
                // //curve: Curves.fastOutSlowIn,
                height: 70.h,
                child: Column(
                  children: [
                    Container(
                      // //duration: const Duration(seconds: 10),
                      // //curve: Curves.fastOutSlowIn,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                tr("common.cancel"),
                                textAlign: TextAlign.center,
                                style: textTheme.bodyText1!
                                    .copyWith(color: colorSecondary),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              tr("customize.choose_layout"),
                              textAlign: TextAlign.center,
                              style: textTheme.subtitle1,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              controller.listFeature.clear();
                              controller.listFeature.value =
                                  List.from(controller.listFeatureTemp);
                              // controller.listFeature.value = controller
                              //     .listFeatureTemp
                              //     .map((item) => FeatureModel.clone(item))
                              //     .toList();
                              controller.update();
                            },
                            child: Container(
                              //duration: const Duration(seconds: 10),
                              //curve: Curves.fastOutSlowIn,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                tr("common.done"),
                                textAlign: TextAlign.center,
                                style: textTheme.subtitle1!
                                    .copyWith(color: colorSecondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              // //duration: const Duration(seconds: 10),
                              // //curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.only(top: 20),
                              width: 90.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.changeView(ViewType.ALL);
                                        });
                                      },
                                      child: Obx(
                                        () => Container(
                                          // //duration: const Duration(seconds: 10),
                                          // //curve: Curves.fastOutSlowIn,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: colorCustomizeGrey,
                                            border: Border.all(
                                                color: controller.selectedLayout
                                                            .value ==
                                                        1
                                                    ? colorSecondary
                                                    : colorCustomizeGrey,
                                                width: 2),
                                          ),
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                tr("customize.all_features"),
                                                textAlign: TextAlign.center,
                                                style: textTheme.bodyText1,
                                              ),
                                              SizedBox(height: 15),
                                              StaggeredGrid.count(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                children: [
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    // //curve: Curves.fastOutSlowIn,
                                                    height: smallSize,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    // //curve: Curves.fastOutSlowIn,
                                                    height: smallSize,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    // //curve: Curves.fastOutSlowIn,
                                                    height: bigBox,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    // //curve: Curves.fastOutSlowIn,
                                                    height: smallSize,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    // //curve: Curves.fastOutSlowIn,
                                                    height: bigBox,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    // //curve: Curves.fastOutSlowIn,
                                                    height: smallSize,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.changeView(ViewType.FOCUS);
                                        });
                                      },
                                      child: Obx(
                                        () => Container(
                                          // //duration: const Duration(seconds: 10),
                                          // //curve: Curves.fastOutSlowIn,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: colorCustomizeGrey,
                                            border: Border.all(
                                                color: controller.selectedLayout
                                                            .value ==
                                                        2
                                                    ? colorSecondary
                                                    : colorCustomizeGrey,
                                                width: 2),
                                          ),
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                tr("customize.focus"),
                                                textAlign: TextAlign.center,
                                                style: textTheme.bodyText1,
                                              ),
                                              SizedBox(height: 20),
                                              StaggeredGrid.count(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                children: [
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    //curve: Curves.fastOutSlowIn,
                                                    height: bigBox1,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    //curve: Curves.fastOutSlowIn,
                                                    height: smallSize1,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    //curve: Curves.fastOutSlowIn,
                                                    height: bigBox1,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  Container(
                                                    // duration:
                                                    //     const Duration(seconds: 10),
                                                    //curve: Curves.fastOutSlowIn,
                                                    height: smallSize1,
                                                    decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: 90.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: colorCustomizeGrey,
                                border: Border.all(
                                  width: 1,
                                  color: colorSecondary,
                                ),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    tr("customize.custom"),
                                    textAlign: TextAlign.center,
                                    style: textTheme.bodyText1,
                                  ),
                                  SizedBox(height: 20),
                                  Obx(
                                    () => Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i <
                                                controller
                                                    .listFeatureTemp.length;
                                            i++)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                controller.checkUncheckItem(i);
                                              });
                                            },
                                            child: Container(
                                              // //duration: const Duration(seconds: 10),
                                              // //curve: Curves.fastOutSlowIn,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                          .listFeatureTemp[i]
                                                          .isSelected
                                                      ? colorPrimary
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                      color: controller
                                                              .listFeatureTemp[
                                                                  i]
                                                              .isSelected
                                                          ? Colors.transparent
                                                          : colorNeutral80),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                controller.listFeatureTemp[i]
                                                        .title ??
                                                    "",
                                                style: textTheme.bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: controller
                                                                .listFeatureTemp[
                                                                    i]
                                                                .isSelected
                                                            ? colorBlack
                                                            : colorNeutral80),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 20, 25, 10),
                              child: Text(
                                tr("customize.note"),
                                textAlign: TextAlign.center,
                                style: textTheme.bodyText2!
                                    .copyWith(color: colorNeutral90),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  scoreBoardBottomSheet(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        List<Weekly> weekly = controller.overview.value.scoreboard!.weekly!;
        List<Monthly> monthly = controller.overview.value.scoreboard!.monthly!;
        List<AllTime> allTime = controller.overview.value.scoreboard!.allTime!;
        return SingleChildScrollView(
          primary: true,
          child: Container(
            //duration: const Duration(seconds: 10),
            //curve: Curves.fastOutSlowIn,
            height: 70.h,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Container(
                  //duration: const Duration(seconds: 10),
                  //curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                      color: colorGrey,
                      borderRadius: BorderRadius.circular(10)),
                  width: 15.w,
                  height: 5,
                  margin: EdgeInsets.only(top: 5),
                ),
                SizedBox(height: 20),
                Text(
                  tr("score.scoreboard"),
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.overview.value.fullname.toString(),
                      textAlign: TextAlign.center,
                      style: textTheme.subtitle1,
                    ),
                    SizedBox(width: 10),
                    Text(
                      controller.overview.value.rewardPoints.toString(),
                      textAlign: TextAlign.center,
                      style: textTheme.subtitle1,
                    ),
                    if (controller.overview.value.myTierId != null &&
                        controller.overview.value.myTierId != 0)
                      SizedBox(
                          height: 20,
                          width: 30,
                          child: getBatch(controller.overview.value.myTierId!)),
                  ],
                ),
                SizedBox(height: 5),
                if (controller.overview.value.currentTier != null &&
                    controller.overview.value.currentTier!.isNotEmpty)
                  Text(
                    controller.overview.value.currentTier.toString(),
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2,
                  ),
                SizedBox(height: 20),
                Container(
                  //duration: const Duration(seconds: 10),
                  //curve: Curves.fastOutSlowIn,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: colorAnswerBackground,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: TabBar(
                    padding: EdgeInsets.fromLTRB(1.w, 1.w, 1.w, 1.w),
                    controller: controller.tabController,

                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorWhite,
                    ),
                    splashBorderRadius: BorderRadius.circular(10),
                    onTap: (value) {},
                    labelColor: colorBlack,
                    labelStyle: textTheme.subtitle1,
                    unselectedLabelColor: colorNeutral80,
                    unselectedLabelStyle: textTheme.bodyText2,
                    tabs: controller.tabs,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        ListView.builder(
                          itemCount: weekly.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Weekly data = weekly[index];
                            int weeklyPos = controller
                                .overview.value.scoreboard!.weeklyMypos!;
                            return Container(
                              //duration: const Duration(seconds: 10),
                              //curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (weeklyPos != 51 &&
                                      data.posnum! >= 51 &&
                                      index == 50)
                                    Container(
                                      //duration: const Duration(seconds: 10),
                                      //curve: Curves.fastOutSlowIn,
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text("...",
                                          textAlign: TextAlign.center),
                                    ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              '${data.posnum}. ' +
                                                  data.ufname! +
                                                  " " +
                                                  data.ulname!
                                                      .substring(0, 1)
                                                      .capitalize!,
                                              style: textTheme.bodyText1!
                                                  .copyWith(
                                                      fontWeight: data.posnum ==
                                                              weeklyPos
                                                          ? FontWeight.w600
                                                          : FontWeight.w400,
                                                      color: data.posnum ==
                                                              weeklyPos
                                                          ? colorBlue
                                                          : colorBlack),
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: getBatch(data.tier!)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        data.weekRewardPoints.toString(),
                                        style: textTheme.bodyText1!.copyWith(
                                            fontWeight: data.posnum == weeklyPos
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                            color: data.posnum == weeklyPos
                                                ? colorBlue
                                                : colorBlack),
                                      ),
                                    ],
                                  ),
                                  if (data.posnum! > 51 &&
                                      index >= 52 &&
                                      weeklyPos != 52 &&
                                      weeklyPos != 53)
                                    Container(
                                      //duration: const Duration(seconds: 10),
                                      //curve: Curves.fastOutSlowIn,
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text("...",
                                          textAlign: TextAlign.center),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: monthly.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Monthly data = monthly[index];
                            int monthlyPos = controller
                                .overview.value.scoreboard!.monthlyMypos!;
                            return Container(
                              //duration: const Duration(seconds: 10),
                              //curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (monthlyPos != 51 &&
                                      data.posnum! >= 51 &&
                                      index == 50)
                                    Container(
                                      //duration: const Duration(seconds: 10),
                                      //curve: Curves.fastOutSlowIn,
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text("...",
                                          textAlign: TextAlign.center),
                                    ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              '${data.posnum}. ' +
                                                  data.ufname! +
                                                  " " +
                                                  data.ulname!
                                                      .substring(0, 1)
                                                      .capitalize!,
                                              style: textTheme.bodyText1!
                                                  .copyWith(
                                                      fontWeight: data.posnum ==
                                                              monthlyPos
                                                          ? FontWeight.w600
                                                          : FontWeight.w400,
                                                      color: data.posnum ==
                                                              monthlyPos
                                                          ? colorBlue
                                                          : colorBlack),
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: getBatch(data.tier!)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        data.monthRewardPoints.toString(),
                                        style: textTheme.bodyText1!.copyWith(
                                            fontWeight:
                                                data.posnum == monthlyPos
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                            color: data.posnum == monthlyPos
                                                ? colorBlue
                                                : colorBlack),
                                      ),
                                    ],
                                  ),
                                  if (data.posnum! > 51 &&
                                      index >= 52 &&
                                      monthlyPos != 52 &&
                                      monthlyPos != 53)
                                    Container(
                                      //duration: const Duration(seconds: 10),
                                      //curve: Curves.fastOutSlowIn,
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text("...",
                                          textAlign: TextAlign.center),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: allTime.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            AllTime data = allTime[index];
                            int allTimeMyPos = controller
                                .overview.value.scoreboard!.allTimeMypos!;
                            int allTimeCount = controller
                                .overview.value.scoreboard!.allTimeCount!;
                            return Container(
                              //duration: const Duration(seconds: 10),
                              //curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (allTimeMyPos != 51 &&
                                      data.posnum! >= 51 &&
                                      index == 50)
                                    Container(
                                      //duration: const Duration(seconds: 10),
                                      //curve: Curves.fastOutSlowIn,
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text("...",
                                          textAlign: TextAlign.center),
                                    ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              '${data.posnum}. ' +
                                                  data.ufname! +
                                                  " " +
                                                  data.ulname!
                                                      .substring(0, 1)
                                                      .capitalize!,
                                              style: textTheme.bodyText1!
                                                  .copyWith(
                                                      fontWeight: data.posnum ==
                                                              allTimeMyPos
                                                          ? FontWeight.w600
                                                          : FontWeight.w400,
                                                      color: data.posnum ==
                                                              allTimeMyPos
                                                          ? colorBlue
                                                          : colorBlack),
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: getBatch(data.tier!)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        data.rewardPoints.toString(),
                                        style: textTheme.bodyText1!.copyWith(
                                            fontWeight:
                                                data.posnum == allTimeMyPos
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                            color: data.posnum == allTimeMyPos
                                                ? colorBlue
                                                : colorBlack),
                                      ),
                                    ],
                                  ),
                                  if (isShowDots(
                                      allTimeMyPos, allTimeCount, data.posnum!))
                                    Container(
                                      //duration: const Duration(seconds: 10),
                                      //curve: Curves.fastOutSlowIn,
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text("...",
                                          textAlign: TextAlign.center),
                                    ),
                                ],
                              ),
                            );
                          },
                        )
                      ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  getBatch(int tier) {
    switch (tier) {
      case 1:
        return SvgPicture.asset("assets/icons/bronz_batch.svg");
      case 2:
        return SvgPicture.asset("assets/icons/silver.svg");
      case 3:
        return SvgPicture.asset("assets/icons/gold.svg");
    }
  }

  getTireProgress() {
    double progress = 0.0;
    if (controller.overview.value.myTierId == 0) {
      progress = (controller.overview.value.rewardPoints! / 1200);
      if (progress == 0.0) {
        progress = 1;
      }
    } else if (controller.overview.value.myTierId == 1) {
      progress = (controller.overview.value.rewardPoints! / 2000);
      if (progress == 0.0) {
        progress = 1;
      }
    } else if (controller.overview.value.myTierId == 2) {
      progress = (controller.overview.value.rewardPoints! / 4000);
      if (progress == 0.0) {
        progress = 1;
      }
    }

    // print('done ${done / overview.value.myReminders!.length}');
    // print('done1 $done');
    // print('progress $progress');
    print('===== $progress');
    if (progress == 0) {
      return progress = 1;
    } else if (progress == 1 || progress > 1) {
      return progress = 1;
    } else {
      return progress;
    }
  }

  isShowDots(int myPos, int totalCount, int indexPos) {
    if (totalCount > 51 &&
        !(myPos != 51 || myPos != 52 || myPos != 53) &&
        myPos > 50) {
      return true;
    } else if ((totalCount) == myPos && indexPos >= 50) {
      // for your position is last and total in more then 50 + 3 record
      return true;
    } else if ((indexPos - 1) == myPos && indexPos >= 50) {
      // for your position is second last and total in more then 50 + 3 record
      return true;
    } else if (totalCount > 51 && myPos < 50 && indexPos == 50) {
      // for exact 50 and less position
      return true;
    } else {
      return false;
    }
  }

  welcomeView(TextTheme textTheme) {
    return Container(
      ////duration: const Duration(seconds: 10),
      //                           //curve: Curves.fastOutSlowIn,
      width: 100.w,
      padding: EdgeInsets.only(left: 25, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getFieldSeparator(height: 10),
          Row(
            children: [
              Text(
                tr('overview.welcome') + " ${AppGlobal.userData!.firstname}",
                style: textTheme.headline5,
                textAlign: TextAlign.start,
              ),
              SizedBox(width: 10),
              if (controller.overview.value.championsBadge == 1)
                Image(
                    width: 25,
                    height: 25,
                    image: AssetsHelper.getImage("champion_badge.png")),
            ],
          ),
          SizedBox(height: 5),
          if (controller.overview.value.currentPhase != null)
            Obx(
              () => Text(
                tr('overview.maintain_month') +
                    controller.overview.value.currentPhase! +
                    " - " +
                    controller.overview.value.monthWeekLabel!,
                style: textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
          getFieldSeparator(),
        ],
      ),
    );
  }

  accountabilityStatementView(TextTheme textTheme) {
    return Obx(
      () => Container(
        width: 100.w,
        margin: EdgeInsets.fromLTRB(5.w, 0.w, 5.w, 5.w),
        decoration: boxDecorationDashboard(),
        // //duration: const Duration(seconds: 10),
        // //curve: Curves.fastOutSlowIn,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('overview.your_statement'),
                    style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.accStatementController.value,
                    focusNode: controller.accStatementFocus.value,
                    decoration: InputDecoration(
                      filled: controller.isEditStatement.value ? false : false,
                      hintStyle:
                          textTheme.subtitle1!.copyWith(color: colorGreyText),
                      hintText:
                          "Enter a statement to help you stay accountable and motivated",
                      fillColor: colorCustomizeGrey,
                      hintMaxLines: 3,
                      contentPadding: EdgeInsets.all(5),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    buildCounter: (_,
                            {required currentLength,
                            required maxLength,
                            required isFocused}) =>
                        controller.isEditStatement.value
                            ? Container(
                                // duration:
                                //     const Duration(
                                //         seconds: 10),
                                // curve: Curves
                                //     .fastOutSlowIn,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (maxLength! - currentLength).toString(),
                                ),
                              )
                            : null,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    maxLength: 100,
                    cursorColor: colorBlack,
                    enabled: controller.isEditStatement.value ? true : false,
                    style: textTheme.subtitle1!
                        .copyWith(color: colorSecondary, fontSize: 19),
                    textAlign: TextAlign.start,
                    autofocus: true,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: InkWell(
                onTap: () {
                  print('------------ ${DateTime.now().toIso8601String()}');
                  print('------------ ${DateTime.now().timeZoneOffset}');
                  if (controller.isEditStatement.value) {
                    controller.updateAccStatement();
                  } else {
                    controller.isEditStatement.value = true;
                    controller.accStatementFocus.value.requestFocus();
                  }
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: colorPrimary.withAlpha(50),
                  child: !controller.isEditStatement.value
                      ? SvgPicture.asset("assets/icons/edit.svg")
                      : Obx(
                          () =>
                              controller.statusStatement.value == Status.LOADING
                                  ? CircularProgressIndicator()
                                  : Icon(
                                      Icons.check,
                                      color: Color(0XFF138282),
                                    ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  myReminder(TextTheme textTheme) {
    return Container(
      // //duration: const Duration(seconds: 10),
      // //curve: Curves.fastOutSlowIn,
      width: 100.w,
      margin: EdgeInsets.fromLTRB(5.w, 0.w, 5.w, 5.w),
      decoration: boxDecorationDashboard(),
      child: Showcase(
        key: AppGlobal.two,
        title: "We’ve broken down your goal into smaller actionable steps",
        tooltipPadding: EdgeInsets.all(15),
        tooltipBorderRadius: BorderRadius.circular(20),
        onToolTipClick: () {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            ShowCaseWidget.of(Get.context!).startShowCase([
              AppGlobal.three,
            ]);
          });
        },
        onTargetClick: () {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            ShowCaseWidget.of(Get.context!).startShowCase([
              AppGlobal.three,
            ]);
          });
        },
        disposeOnTap: true,
        disableMovingAnimation: true,
        targetBorderRadius: BorderRadius.all(Radius.circular(20)),
        titleAlignment: TextAlign.center,
        titleTextStyle: textTheme.headline5!.copyWith(
            fontWeight: FontWeight.w500, fontSize: 19, color: colorBlue),
        description: "",
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 30, 25, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('overview.my_reminders'),
                style: textTheme.headline5,
                textAlign: TextAlign.start,
              ),
              getFieldSeparator(),
              if (controller.overview.value.myReminders != null)
                Container(
                  // //duration: const Duration(seconds: 10),
                  // //curve: Curves.fastOutSlowIn,
                  width: 100.w,
                  height: 13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: controller.getReminderProgress(),
                      valueColor: AlwaysStoppedAnimation<Color>(colorTeal),
                      backgroundColor: colorGrey,
                    ),
                  ),
                ),
              getFieldSeparator(),
              controller.overview.value.myReminders != null
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: controller.overview.value.myReminders!.length,
                      itemBuilder: (context, index) {
                        MyReminders data =
                            controller.overview.value.myReminders![index];
                        return Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Divider(color: colorGrey),
                              ),
                              InkWell(
                                onTap: () {
                                  if (data.subtitle != null) {
                                    controller.isShowLogTreat.value =
                                        !controller.isShowLogTreat.value;
                                  } else if (data.type == "video") {
                                    print(controller.overview.value.videoLink!
                                        .split("/")
                                        .last);
                                    Get.toNamed(Routes.VIDEO,
                                        // arguments: {
                                        //   "url": controller
                                        //       .overview
                                        //       .value
                                        //       .videoLink!
                                        //       .split("/")
                                        //       .last,
                                        //   "type": "V",
                                        // }
                                        arguments: {
                                          "url":
                                              "https://www.youtube.com/watch?v=yISeUR6UDAI",
                                          "type": "YT",
                                          "currentWeek":
                                              AppGlobal.userData!.currWeek,
                                        });
                                  }
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.title ?? "",
                                        style: textTheme.bodyText1!.copyWith(
                                            decoration: data.status == "done"
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                      ),
                                    ),
                                    if (data.subtitle != null)
                                      Icon(Icons.keyboard_arrow_down),
                                    //I did not have any treats or takeaway meals today
                                    SizedBox(width: 10),
                                    Text(
                                      data.points ?? "",
                                      style: textTheme.bodyText1!.copyWith(
                                          fontSize: 13,
                                          decoration: data.status == "done"
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                  ],
                                ),
                              ),
                              if (controller.overview.value.myReminders![index]
                                          .subtitle !=
                                      null &&
                                  controller.isShowLogTreat.value)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller
                                                  .overview
                                                  .value
                                                  .myReminders![index]
                                                  .subtitle ??
                                              "",
                                          style: textTheme.bodyText1!.copyWith(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Checkbox(
                                          value: data.noTreatTakeawayStatus == 1
                                              ? true
                                              : false,
                                          checkColor: colorWhite,
                                          activeColor: colorSecondary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          onChanged: ((value) {
                                            if (value!) {
                                              controller
                                                  .updateNoTreatsTakesAway(
                                                      index, 1);
                                            } else {
                                              controller
                                                  .updateNoTreatsTakesAway(
                                                      index, 0);
                                            }
                                            controller.overview.refresh();
                                            //controller.callapi();
                                          })),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      })
                  : noDataFound(),
            ],
          ),
        ),
      ),
    );
  }

  rewardView(TextTheme textTheme, BuildContext context) {
    return Container(
      // //duration: const Duration(seconds: 10),
      // //curve: Curves.fastOutSlowIn,
      width: 100.w,
      margin: EdgeInsets.fromLTRB(5.w, 0.w, 5.w, 5.w),
      decoration: boxDecorationDashboard(),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                controller.getReward();
                Get.toNamed(Routes.REWARD);
              },
              child: Column(
                children: [
                  CircularPercentIndicator(
                      radius: 15.w,
                      lineWidth: 5.w,
                      animation: true,
                      backgroundColor: getColorProgressInner(
                          controller.overview.value.myTierId!),
                      percent: getTireProgress(),
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.overview.value.nextTierTitle!,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyText2,
                          ),
                          SizedBox(height: 5),
                          Text(
                            controller.overview.value.nextTier!,
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1!.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: getColorProgressOuter(
                          controller.overview.value.myTierId!)),
                  SizedBox(height: 20),
                  Row(children: [
                    Text("Rewards", style: textTheme.subtitle1),
                    Icon(Icons.arrow_forward_ios, size: 20)
                  ])
                ],
              ),
            ),
            SizedBox(width: 10),
            Stack(
              children: [
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 15.w,
                      lineWidth: 5.w,
                      animation: true,
                      backgroundColor: colorProgressIndicator.withOpacity(0.3),
                      percent: 0.0,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total pts",
                            textAlign: TextAlign.center,
                            style: textTheme.bodyText2,
                          ),
                          SizedBox(height: 5),
                          Text(
                            controller.overview.value.rewardPoints.toString(),
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1!.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: colorProgressIndicator,
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        scoreBoardBottomSheet(context);
                      },
                      child: Row(children: [
                        Text("Scoreboard", style: textTheme.subtitle1),
                        Icon(Icons.arrow_forward_ios, size: 20)
                      ]),
                    )
                  ],
                ),
                if (controller.overview.value.currentTier!.isNotEmpty)
                  Positioned(
                      left: 0,
                      right: 0,
                      child: getBatch(controller.overview.value.myTierId!)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
