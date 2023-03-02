import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/register_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:iwl/widgets/decoration/boxDecoration.dart';
import 'package:sizer/sizer.dart';

class PlanPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetHelper.getHeader(context, ""),
      body: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Container(
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      heading(textTheme),
                      getFieldSeparator(height: 30),
                      Container(
                        height: 35,
                        width: 60.w,
                        margin: mainPadding(),
                        decoration: BoxDecoration(
                          color: colorAnswerBackground,
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        child: TabBar(
                          padding:
                              EdgeInsets.fromLTRB(0.5.w, 0.5.w, 0.5.w, 0.5.w),
                          controller: controller.tabController,
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colorWhite,
                          ),
                          splashBorderRadius: BorderRadius.circular(10),
                          onTap: (value) {},
                          labelColor: colorBlack,
                          labelStyle: textTheme.headline6,
                          unselectedLabelColor: colorNeutral80,
                          unselectedLabelStyle: textTheme.headline6,
                          tabs: [
                            Tab(text: "Quarterly"),
                            Tab(text: "Yearly"),
                          ],
                        ),
                      ),
                      getFieldSeparator(),
                      Expanded(
                        child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              quarterlyListview(textTheme),
                              yearlyListview(textTheme),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              getFieldSeparator(height: 10),
              RichText(
                text: TextSpan(
                  text: 'Change plans or cancel anytime. See  ',
                  style: textTheme.bodyText2!.copyWith(color: colorNeutral80),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'terms',
                        style: textTheme.bodyText2!.copyWith(
                          color: colorNeutral80,
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              ),
              getFieldSeparator(height: 10),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: mainPadding().copyWith(bottom: 30),
        child: ButtonView(
          text: tr("Start 30-day free trial"),
          onPressed: () {
            Get.offAllNamed(Routes.INTRODUCTION);
          },
        ),
      ),
    );
  }

  heading(TextTheme textTheme) {
    return Container(
      padding: mainPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getFieldSeparator(height: 20),
          Text(
            'Regain control of your health for less than \$1/day',
            style: textTheme.headline5,
          ),
          SizedBox(height: 20),
          Text(
            'We don’t sell fast, unsustainable results. We help you learn long-term habits to build a healthier you.',
            style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
          ),
          SizedBox(height: 10),
          Text(
            '100% of revenue goes into research and development to ensure we can offer you accessible and affordable plans that work.',
            style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
          ),
        ],
      ),
    );
  }

  quarterlyListview(TextTheme textTheme) {
    return Column(
      children: [
        Container(
          height: 130,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            padding: mainPadding(),
            itemCount: controller.quarterlyPlanList.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            primary: false,
            itemBuilder: (context, index) {
              PlanModel data = controller.quarterlyPlanList[index];
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    for (var h in controller.quarterlyPlanList) {
                      h.isSelected.value = false;
                    }
                    controller.quarterlyPlanList[index].isSelected.value = true;
                    controller.quarterlyMainIndex.value = index;
                  },
                  child: Container(
                    width: 42.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(20),
                    decoration: boxdecoration(
                        data.isSelected.value
                            ? colorPrimary.withAlpha(50)
                            : colorAnswerBackground,
                        data.isSelected.value
                            ? colorPrimary
                            : colorAnswerBackground,
                        15.0,
                        2.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.title ?? "",
                          style: textTheme.subtitle1!.copyWith(
                              fontSize: 19,
                              color: data.isSelected.value
                                  ? colorTealDark
                                  : colorNeutral80),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Text(
                          data.price ?? "",
                          style: textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              color: data.isSelected.value
                                  ? colorTealDark
                                  : colorNeutral80),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Text(
                          data.totalPrice ?? "",
                          style: textTheme.bodyText1!
                              .copyWith(fontSize: 11, color: colorNeutral80),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: controller
                  .quarterlyPlanList[controller.quarterlyMainIndex.value]
                  .itemList!
                  .length,
              shrinkWrap: true,
              primary: false,
              padding: mainPadding().copyWith(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = controller
                    .quarterlyPlanList[controller.quarterlyMainIndex.value]
                    .itemList;
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.done, color: colorTeal),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          data![index],
                          style: textTheme.bodyText1!
                              .copyWith(color: colorNeutral90, fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  yearlyListview(TextTheme textTheme) {
    return Column(
      children: [
        Container(
          height: 130,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            padding: mainPadding(),
            itemCount: controller.yearlyPlanList.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            primary: false,
            itemBuilder: (context, index) {
              PlanModel data = controller.yearlyPlanList[index];
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    for (var h in controller.yearlyPlanList) {
                      h.isSelected.value = false;
                    }
                    controller.yearlyPlanList[index].isSelected.value = true;
                    controller.yearlyMainIndex.value = index;
                  },
                  child: Container(
                    width: 42.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(20),
                    decoration: boxdecoration(
                        data.isSelected.value
                            ? colorPrimary.withAlpha(50)
                            : colorAnswerBackground,
                        data.isSelected.value
                            ? colorPrimary
                            : colorAnswerBackground,
                        15.0,
                        2.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.title ?? "",
                          style: textTheme.subtitle1!.copyWith(
                              fontSize: 19,
                              color: data.isSelected.value
                                  ? colorTealDark
                                  : colorNeutral80),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Text(
                          data.price ?? "",
                          style: textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              color: data.isSelected.value
                                  ? colorTealDark
                                  : colorNeutral80),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Text(
                          data.totalPrice ?? "",
                          style: textTheme.bodyText1!
                              .copyWith(fontSize: 11, color: colorNeutral80),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: controller
                  .yearlyPlanList[controller.yearlyMainIndex.value]
                  .itemList!
                  .length,
              shrinkWrap: true,
              primary: false,
              padding: mainPadding().copyWith(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = controller
                    .yearlyPlanList[controller.yearlyMainIndex.value].itemList;
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.done, color: colorTeal),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          data![index],
                          style: textTheme.bodyText1!
                              .copyWith(color: colorNeutral90, fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

// ListView.builder(
// itemCount: data.itemList!.length,
// primary: false,
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// itemBuilder: (context, index) {
// return Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.only(top: 5),
// child: CircleAvatar(
// backgroundColor: colorBlack,
// radius: 2,
// ),
// ),
// SizedBox(width: 10),
// Expanded(
// child: Text(
// data.itemList![index],
// style: textTheme.bodyText1!
//     .copyWith(color: colorBlack),
// textAlign: TextAlign.start,
// ),
// ),
// ],
// );
// },
// )
