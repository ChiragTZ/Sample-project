import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/controller/measure_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/model/chart_response.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/buttons/ButtonView1.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:iwl/widgets/decoration/boxDecoration.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MeasurePage extends GetView<MeasureController> {
  final MeasureController controller = Get.put(MeasureController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return AppGlobal.isWeekStart
        ? Obx(
            () => showLoader(
              isLoading: controller.status.value == Status.LOADING &&
                  !controller.isPullToRefresh.value,
              child: Obx(
                () => CustomScrollView(
                  controller: controller.scrollController.value,
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    CupertinoSliverRefreshControl(
                      onRefresh: () => controller.refreshIndicator(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          controller.notifyChildrens();
                          return SingleChildScrollView(
                            primary: true,
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  child: Text(
                                    tr('measure.my_weight_loss_plan'),
                                    style: textTheme.headline5,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  decoration: boxDecorationDashboard(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Padding(
                                        //   padding: EdgeInsets.fromLTRB(25, 30, 25, 30),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //         child: Text(
                                        //           tr('measure.my_weight_loss_plan'),
                                        //           style: textTheme.headline4!.copyWith(
                                        //             fontWeight: FontWeight.w600,
                                        //             fontSize: 19,
                                        //           ),
                                        //           textAlign: TextAlign.start,
                                        //         ),
                                        //       ),
                                        //       GestureDetector(
                                        //         onTap: () {
                                        //           final HomeController homeController =
                                        //               Get.put(HomeController());
                                        //           homeController.page.value = 1;
                                        //           final ProgressTrackerController pTController =
                                        //               Get.put(ProgressTrackerController());
                                        //           pTController.selectedIndex.value = 1;
                                        //         },
                                        //         child: Text(
                                        //           tr('common.view_more'),
                                        //           style: textTheme.bodyText1!.copyWith(
                                        //               fontWeight: FontWeight.w600,
                                        //               color: colorSecondary),
                                        //           textAlign: TextAlign.start,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/icons/progress.svg"),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        tr('measure.your_progress'),
                                                        style: textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: colorBlack
                                                                    .withOpacity(
                                                                        0.6)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/icons/projected_plan.svg"),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        tr('measure.projected_plan'),
                                                        style: textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: colorBlack
                                                                    .withOpacity(
                                                                        0.6)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/icons/weight_loss_month.svg"),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        tr('measure.maintenance_month'),
                                                        style: textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: colorBlack
                                                                    .withOpacity(
                                                                        0.6)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/icons/maintenance_month.svg"),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        tr('measure.weight_loss_month'),
                                                        style: textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: colorBlack
                                                                    .withOpacity(
                                                                        0.6)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        if (controller
                                                .chart.value.yourProgress !=
                                            null)
                                          Container(
                                            height: 230,
                                            child: SfCartesianChart(
                                              zoomPanBehavior:
                                                  controller.zoomPanBehavior,
                                              // primaryYAxis: LogarithmicAxis(
                                              //   anchorRangeToVisiblePoints: true,
                                              //   minimum: controller.minValue,
                                              //   maximum: controller.maxValue,
                                              // ),
                                              backgroundColor: Colors.white,

                                              // onPlotAreaSwipe:
                                              //     (ChartSwipeDirection direction) =>
                                              //         controller
                                              //             .performSwipe(direction),
                                              enableAxisAnimation: false,

                                              primaryYAxis: NumericAxis(
                                                  maximumLabels: 1,
                                                  anchorRangeToVisiblePoints:
                                                      true,
                                                  enableAutoIntervalOnZooming:
                                                      true,
                                                  minimum: controller.minValue,
                                                  // maximum: controller.maxValue,
                                                  rangePadding:
                                                      ChartRangePadding.round),
                                              primaryXAxis: CategoryAxis(
                                                  //Hide the gridlines of x-axis
                                                  interval: 1,
                                                  labelStyle: textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color:
                                                              colorNeutral80),
                                                  majorGridLines:
                                                      MajorGridLines(width: 0),
                                                  // autoScrollingDelta: 7,
                                                  labelRotation: -30,
                                                  plotBands: getPloatBand()),

                                              series: <
                                                  ChartSeries<ChartProgress,
                                                      String>>[
                                                LineSeries<ChartProgress,
                                                        String>(
                                                    // Bind data source(
                                                    //  splineType: SplineType.monotonic,
                                                    color: colorSecondary,
                                                    dataSource: controller.chart
                                                        .value.yourProgress!,
                                                    markerSettings:
                                                        MarkerSettings(
                                                            isVisible: true,
                                                            color: colorBlue,
                                                            borderWidth: 1,
                                                            borderColor:
                                                                colorSecondary),
                                                    emptyPointSettings:
                                                        EmptyPointSettings(
                                                            mode: EmptyPointMode
                                                                .drop),
                                                    xValueMapper:
                                                        (ChartProgress sales,
                                                            _) {
                                                      controller.labelColor =
                                                          sales.isCurrentWeek ==
                                                                  1
                                                              ? colorBlue
                                                              : colorBlack;
                                                      return sales.xaxis;
                                                    },
                                                    // emptyPointSettings:
                                                    //     EmptyPointSettings(
                                                    //         mode: EmptyPointMode
                                                    //             .average),
                                                    yValueMapper:
                                                        (ChartProgress sales,
                                                                _) =>
                                                            sales.yaxis),
                                                LineSeries<ChartProgress,
                                                        String>(
                                                    dataSource: controller.chart
                                                        .value.projectedPlan!,
                                                    // splineType: SplineType.monotonic,
                                                    color: colorGreyText,
                                                    enableTooltip: false,
                                                    width: 1,
                                                    // Dash values for spline
                                                    dashArray: <double>[5, 5],
                                                    xValueMapper:
                                                        (ChartProgress data,
                                                                _) =>
                                                            data.xaxis,
                                                    yValueMapper:
                                                        (ChartProgress data,
                                                                _) =>
                                                            data.yaxis),
                                              ],
                                              plotAreaBorderColor:
                                                  Colors.transparent,
                                              tooltipBehavior: TooltipBehavior(
                                                  enable: true,
                                                  // Tooltip will be displayed on long press
                                                  activationMode:
                                                      ActivationMode.singleTap),
                                              onTooltipRender:
                                                  (TooltipArgs args) {
                                                args.text =
                                                    'Logged ${AppGlobal.removeDecimalZeroFormat(args.dataPoints![args.pointIndex!.toInt()].y)}kg';
                                                args.header =
                                                    '${controller.chart.value.yourProgress![args.pointIndex!.toInt()].date}';
                                              },
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                                  child: Text(
                                    tr('measure.progress'),
                                    style: textTheme.headline5,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  margin:
                                      EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 5.w),
                                  decoration: boxDecorationDashboard(),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: Text(
                                        //         tr('measure.progress'),
                                        //         style: textTheme.headline4!.copyWith(
                                        //             fontWeight: FontWeight.w600, fontSize: 19),
                                        //         textAlign: TextAlign.start,
                                        //       ),
                                        //     ),
                                        //     GestureDetector(
                                        //       onTap: () {
                                        //         final HomeController homeController =
                                        //             Get.put(HomeController());
                                        //         homeController.page.value = 1;
                                        //         final ProgressTrackerController pTController =
                                        //             Get.put(ProgressTrackerController());
                                        //         pTController.selectedIndex.value = 1;
                                        //         //Get.offAndToNamed(Routes.PROGRESS);
                                        //       },
                                        //       child: Text(tr('common.view_more'),
                                        //           style: textTheme.bodyText1!.copyWith(
                                        //               fontWeight: FontWeight.w600,
                                        //               color: colorSecondary),
                                        //           textAlign: TextAlign.start),
                                        //     ),
                                        //   ],
                                        // ),

                                        if (controller.measure.value.progress !=
                                            null)
                                          Container(
                                            width: 100.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Text(
                                                          tr("measure.start"),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  color:
                                                                      colorNeutral90),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            AppGlobal.removeDecimalZeroFormat(
                                                                controller
                                                                    .measure
                                                                    .value
                                                                    .progress!
                                                                    .startweight!),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1!
                                                                .copyWith(
                                                                    color:
                                                                        colorSecondary),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Text(
                                                              ' kg',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          colorSecondary),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Text(
                                                          tr("measure.last_logged"),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  color:
                                                                      colorNeutral90),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            AppGlobal.removeDecimalZeroFormat(
                                                                controller
                                                                    .measure
                                                                    .value
                                                                    .progress!
                                                                    .lastlog!),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1!
                                                                .copyWith(
                                                                    color:
                                                                        colorSecondary),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Text(
                                                              ' kg',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          colorSecondary),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Text(
                                                          tr("measure.goal"),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  color:
                                                                      colorNeutral90),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            AppGlobal
                                                                .removeDecimalZeroFormat(
                                                                    controller
                                                                        .measure
                                                                        .value
                                                                        .progress!
                                                                        .goal!),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1!
                                                                .copyWith(
                                                                    color:
                                                                        colorSecondary),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Text(
                                                              ' kg',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          colorSecondary),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                getFieldSeparator(),
                                Center(
                                  child: Showcase(
                                    tooltipBorderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    targetBorderRadius:
                                        BorderRadius.circular(30),
                                    key: AppGlobal.seven,
                                    //targetPadding: EdgeInsets.only(left: 100),
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
                                        "Input your measurements once a week",
                                    child: ButtonView1(
                                      width: 250,
                                      text: controller.measure.value
                                                  .measurementAddedForWeek ==
                                              0
                                          ? tr("measure.add_measurements")
                                          : tr("measure.edit_measurements"),
                                      onPressed: () {
                                        if (!controller.isEdit.value) {
                                          controller.reInitiateDetail();
                                        } else {
                                          controller
                                                  .todayWeightController.text =
                                              AppGlobal.removeDecimalZeroFormat(
                                                  controller
                                                      .measure
                                                      .value
                                                      .lastLoggedWeight!
                                                      .weight!);
                                          controller.waistController.text =
                                              controller
                                                          .measure
                                                          .value
                                                          .lastLoggedWeight!
                                                          .waist !=
                                                      null
                                                  ? AppGlobal
                                                      .removeDecimalZeroFormat(
                                                          controller
                                                              .measure
                                                              .value
                                                              .lastLoggedWeight!
                                                              .waist!)
                                                  : "";
                                          controller.selectedItem.value =
                                              controller.measure.value
                                                  .lastLoggedWeight!.feel
                                                  .toString();
                                          controller.commentController.text =
                                              controller.measure.value
                                                  .lastLoggedWeight!.comment
                                                  .toString();
                                          controller.date = controller.measure
                                              .value.lastLoggedWeight!.date
                                              .toString();
                                        }
                                        Get.toNamed(Routes.ADD_MEASURE);
                                      },
                                    ),
                                  ),
                                ),
                                getFieldSeparator(),
                              ],
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                ),
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

  getPloatBand() {
    int? a;
    int? b;
    List<PlotBand> plb = [];
    for (int i = 0; i < controller.chart.value.yourProgress!.length; i++) {
      if (controller.chart.value.yourProgress![i].weekPhase == 2) {
        if (a == null) {
          b = i;
        }
        a = i;
      } else {
        a = null;
      }

      if (a == null &&
          controller.chart.value.yourProgress![i != 0 ? i - 1 : 0].weekPhase ==
              2) {
        plb.add(PlotBand(
            isVisible: true, start: b, end: i, color: colorCustomizeGrey));
      }
      if (a != null && controller.chart.value.yourProgress!.length - 1 == i) {
        plb.add(PlotBand(
            isVisible: true, start: b, end: i + 1, color: colorCustomizeGrey));
      }
    }

    return plb;
  }
}
