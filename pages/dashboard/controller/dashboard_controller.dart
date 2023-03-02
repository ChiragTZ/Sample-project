import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/daily/daily.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/measure.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/overview.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<Widget> tabBarViews = [
    OverViewPage(),
    DailyPage(), //change name habit
    MeasurePage(),
  ];

  List<Tab> tabs = [
    Tab(text: tr('dashboard_tab.overview')),
    Tab(text: tr('dashboard_tab.habits')),
    Tab(text: tr("dashboard_tab.measure")),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tabController.dispose();
  }
}
