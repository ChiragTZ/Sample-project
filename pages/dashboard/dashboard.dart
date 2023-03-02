import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends GetView<DashboardController> {
  final DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      height: 100.h,
      width: 100.w,
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.all(20),
            controller: controller.tabController,
            // give the indicator a decoration (color and border radius)
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: colorPrimary,
            ),
            splashBorderRadius: BorderRadius.circular(50),
            onTap: (value) {},
            labelColor: colorBlack,
            labelStyle:
                textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
            unselectedLabelColor: colorNeutral80,
            unselectedLabelStyle:
                textTheme.headline5!.copyWith(fontWeight: FontWeight.w400),
            tabs: controller.tabs,
          ),
          Expanded(
              child: TabBarView(
            controller: controller.tabController,
            children: controller.tabBarViews,
          )),
        ],
      ),
    );
  }
}
