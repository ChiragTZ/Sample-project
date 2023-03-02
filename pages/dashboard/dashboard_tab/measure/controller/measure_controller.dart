import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/model/chart_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/model/measure_response.dart';
import 'package:iwl/rest_api/api_repository.dart';
import 'package:iwl/rest_api/api_utils.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/base_response.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MeasureController extends GetxController {
  Rx<Enum> status = Status.INITIAL.obs;
  Rx<Enum> statusChartLoading = Status.INITIAL.obs;
  Rx<Measure> measure = Measure().obs;
  Rx<Chart> chart = Chart().obs;
  RxBool isPullToRefresh = false.obs;
  RxString selectedItem = "".obs;
  Color? labelColor;
  Rx<ScrollController> scrollController = ScrollController().obs;

  TextEditingController todayWeightController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController commentController = new TextEditingController();
  String date = apiFormat.format(kToday).toString();
  RxBool isEdit = false.obs;

  double? maxValue;
  double? minValue;

  refreshIndicator() async {
    isPullToRefresh.value = true;
    await getMeasure();
    await getMeasureChart();
    isPullToRefresh.value = false;
  }

  late ZoomPanBehavior zoomPanBehavior;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (AppGlobal.isWeekStart) {
      getMeasure();
      getMeasureChart();
    }
    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );

    print("========== call init");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("========== call ready");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("========== call close");
  }

  @override
  notifyChildrens() {
    // TODO: implement notifyChildrens
    super.notifyChildrens();
    scrollScreen();
    print("========== call notifyChildrens");
  }

  @override
  void $configureLifeCycle() {
    // TODO: implement $configureLifeCycle
    print("========== call configureLifeCycle");
    super.$configureLifeCycle();
  }

  void selectSample(int index) {
    selectedItem.value = measure.value.howYouFeel![index];
  }

  getMeasure() async {
    status.value = Status.LOADING;
    BaseResponse? response;
    try {
      var res = await ApiRepo().getMeasure();
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        measure.value = response.measure!;
        selectedItem.value = measure.value.howYouFeel!.first;
        isEdit.value =
            measure.value.measurementAddedForWeek == 1 ? true : false;
        refresh();
      } else {
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }

    // if (listTreat[index].count != 0) {
    //   listTreat[index].count = listTreat[index].count! - 1;
    // }
    // listTreat.refresh();
  }

  getMeasureChart() async {
    statusChartLoading.value = Status.LOADING;
    BaseResponse? response;
    try {
      var res = await ApiRepo().getMeasureChart();
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        chart.value = response.chart!;
        maxValue = chart.value.projectedPlan!
            .reduce((value, element) =>
                value.yaxis! > element.yaxis! ? value : element)
            .yaxis!
            .ceilToDouble();
        minValue = chart.value.projectedPlan!
            .reduce((value, element) =>
                value.yaxis! < element.yaxis! ? value : element)
            .yaxis!
            .ceilToDouble();
        print(maxValue!.toString());
        print(minValue!.toString());

        refresh();
      }
      statusChartLoading.value = Status.SUCCESS;
    } catch (error) {
      statusChartLoading.value = Status.ERROR;
      return apiUtils.handleError(error);
    }

    // if (listTreat[index].count != 0) {
    //   listTreat[index].count = listTreat[index].count! - 1;
    // }
    // listTreat.refresh();
  }

  addMeasure() async {
    if (todayWeightController.text.isEmpty) {
      showSnackBar(StatusEnum.ERROR,
          title: "Error", desc: "Please enter today's weight");
      return;
    }
    status.value = Status.LOADING;
    BaseResponse? response;
    var data = {
      "weight": todayWeightController.text.toString(),
      "waist": waistController.text.toString(),
      "feel": selectedItem.value,
      "comment": commentController.text.toString(),
      "date": apiFormat.format(kToday).toString()
    };
    //listSample
    //           .where((element) => (element.isSelected == true))
    //           .first
    //           .title
    try {
      var res = await ApiRepo().addMeasure(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        //measure.value = response.measure!;
        Get.toNamed(Routes.SUCCESS, arguments: {
          "title": "Keep going!",
          "desc": "Your weekly measurement has been submitted",
          "goToText": "Return to Overview",
        });
        getMeasure();
        getMeasureChart();
      } else {
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }

    //response
    //   {
    //   "status": true,
    //   "message": "Your weekly measurement has been submitted",
    //   "no_opt_popup": 0,
    //   "isnot_valid_for_newgoal": 0,
    //   "isvalid_for_newgoal": 0
    // }
  }

  editLastWeek() {
    if (isEdit.value) {
      isEdit.value = false;
      todayWeightController.text = "";
      waistController.text = "";
      selectedItem.value = measure.value.howYouFeel!.first;
      commentController.text = "";
      date = apiFormat.format(kToday).toString();
    } else {
      isEdit.value = true;
      todayWeightController.text = AppGlobal.removeDecimalZeroFormat(
          measure.value.lastLoggedWeight!.weight!);
      waistController.text = measure.value.lastLoggedWeight!.waist != null
          ? AppGlobal.removeDecimalZeroFormat(
              measure.value.lastLoggedWeight!.waist!)
          : "";
      selectedItem.value = measure.value.lastLoggedWeight!.feel.toString();
      commentController.text =
          measure.value.lastLoggedWeight!.comment.toString();
      date = measure.value.lastLoggedWeight!.date.toString();
    }

    this.refresh();
  }

  updateMeasure() async {
    status.value = Status.LOADING;
    if (todayWeightController.text.isEmpty) {
      showSnackBar(StatusEnum.ERROR,
          title: "Error", desc: "Please enter today's weight");
      return;
    }
    status.value = Status.LOADING;
    BaseResponse? response;
    var data = {
      "weight": todayWeightController.text.toString(),
      "waist": waistController.text.toString(),
      "feel": selectedItem.value,
      "comment": commentController.text.toString(),
      "date": date,
      "id": measure.value.lastLoggedWeight!.id.toString()
    };
    //listSample
    //           .where((element) => (element.isSelected == true))
    //           .first
    //           .title
    try {
      var res = await ApiRepo().updateMeasure(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        // measure.value = response.measure!;
        Get.toNamed(Routes.SUCCESS, arguments: {
          "title": "Keep going!",
          "desc": "Your weekly measurement has been submitted",
          "goToText": "Return to Overview",
        });
        getMeasure();
        getMeasureChart();
      } else {
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }

    //{"status":true,"message":"Your weekly measurement has been updated","no_opt_popup":0,"isnot_valid_for_newgoal":0,"isvalid_for_newgoal":0}
  }

  void reInitiateDetail() {
    todayWeightController.text = "";
    waistController.text = "";
    commentController.text = "";
    date = apiFormat.format(kToday).toString();
    isEdit.value = false;
    print("========== ${isEdit.value}");
  }

  performSwipe(ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      return Container(
        color: colorGrey,
      );
      // seriesController?.updateDataSource(addedDataIndex: chartData.length - 1);
    }

    return null;
  }

  void scrollScreen() async {
    if (scrollController.value.hasClients && !AppGlobal.iSFirstTime) {
      scrollController.value.animateTo(100,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      update();
      await Future.delayed(Duration(seconds: 1));
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ShowCaseWidget.of(Get.context!).startShowCase([
          AppGlobal.seven,
        ]);
      });
    }
  }
}
