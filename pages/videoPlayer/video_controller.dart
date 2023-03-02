import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/controller/overview_controller.dart';
import 'package:pod_player/pod_player.dart';

class VideoController extends GetxController {
  // late PodPlayerController controller;
  late Rx<PodPlayerController> controller =
      PodPlayerController(playVideoFrom: PlayVideoFrom.network("")).obs;
  String? video;
  String? videoType;
  int? currentWeek;
  RxBool isLoading = true.obs;
  RxString error = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    video = Get.arguments['url'];
    videoType = Get.arguments['type'];
    currentWeek = Get.arguments['currentWeek'];
    if (videoType == "YT") {
      controller.value = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
          video ?? "",
        ),
      )..initialise().then((value) {
          isLoading.value = false;
          controller.value.play();
          controller.refresh();
        }).catchError((e) {
          error.value = e.toString();
        });
    } else if (videoType == "V") {
      controller.value = PodPlayerController(
        playVideoFrom: PlayVideoFrom.vimeo(
          video ?? "",
        ),
      )..initialise().then((value) {
          isLoading.value = false;
          controller.value.play();
          controller.refresh();
        }).catchError((e) {
          error.value = e.toString();
        });
    } else {
      controller.value = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(
          video ?? "",
        ),
      )..initialise().then((value) {
          isLoading.value = false;
          controller.value.play();
          controller.refresh();
        }).catchError((e) {
          error.value = e.toString();
        });
    }
    controller.value.addListener(() {
      if (controller.value.currentVideoPosition ==
          controller.value.totalVideoLength) {
        OverviewController overviewController = Get.find();
        overviewController.watchedWeeklyVideo(currentWeek);
        Get.back();
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.value.dispose();
  }
}
