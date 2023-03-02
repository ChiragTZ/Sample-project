import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/introduction/model/common_response.dart';
import 'package:iwl/rest_api/api_repository.dart';
import 'package:iwl/rest_api/api_utils.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/base_response.dart';

class IntroductionController extends GetxController {
  CarouselController carouselController = CarouselController();
  RxInt currentPage = 0.obs;
  bool isProgress = false;
  Rx<Enum> status = Status.INITIAL.obs;

  RxList<HomeCarouselSlider>? slides = <HomeCarouselSlider>[].obs;

  final pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    //page controller is always listening
    //every pageview is scrolled sideways it will take the index page
    pageController.addListener(() {
      currentPage.value = pageController.page!.toInt();
    });

    getCommon();

    // slides = [
    //   HomeCarouselSlider(
    //       image:
    //           "http://iwltest.kyqk53p4br-ez94d2pm93mr.p.temp-site.link/assets/frontside/img/home/iStock-1198401641.jpg",
    //       title: 'Welcome to Interval Weight Loss',
    //       description:
    //           "Our mission is to ensure we provide affordable access to a long-term proven solution"),
    //   HomeCarouselSlider(
    //       image:
    //           "http://iwltest.kyqk53p4br-ez94d2pm93mr.p.temp-site.link/assets/frontside/img/home/bannerimg-2.jpg",
    //       title: 'Six principles to achieve long-term success',
    //       description:
    //           "We are here to guide you towards a healthier, happier life"),
    //   HomeCarouselSlider(
    //       image:
    //           "http://iwltest.kyqk53p4br-ez94d2pm93mr.p.temp-site.link/assets/frontside/img/home/bannerimg-3.jpg",
    //       title: 'Science-backed, developed and tested',
    //       description:
    //           "From leading researcher Dr. Nick Fuller and supported by accredited dietitians"),
    //   HomeCarouselSlider(
    //       image:
    //           "http://iwltest.kyqk53p4br-ez94d2pm93mr.p.temp-site.link/assets/frontside/img/home/iStock-1198401641.jpg",
    //       title: 'Featured nationally',
    //       description:
    //           "On-boarding people into their healthier, happier selves"),
    // ];
  }

  getCommon() async {
    BaseResponse response;
    try {
      status.value = Status.LOADING;
      var res = await ApiRepo().getCommon();
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        slides!.value = response.homeCarouselSlider!;
        AppGlobal.commonSignup = response.signup!;
      } else {
        slides!.value = [];
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }
}
