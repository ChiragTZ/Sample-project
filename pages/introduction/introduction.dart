import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/introduction/introduction_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:widget_marquee/widget_marquee.dart';

class IntroductionPage extends GetView<IntroductionController> {
  // for (var url in slides) {
  // precacheImage(CachedNetworkImageProvider(url['banner_image']), context);
  // }
  final IntroductionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Obx(() => getView(textTheme)),
      bottomNavigationBar: Container(
        padding: mainPadding(),
        height: 17.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonView(
              text: tr("introduction.create_account"),
              onPressed: () {
                Get.toNamed(Routes.REGISTER);
              },
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr('introduction.have_account'),
                  style: textTheme.bodyText1!.copyWith(color: colorBlack),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Text(
                    'introduction.log_in',
                    style: textTheme.bodyText1!.copyWith(
                        color: colorBlack,
                        decoration: TextDecoration.underline),
                    textAlign: TextAlign.center,
                  ).tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getView(TextTheme textTheme) {
    switch (controller.status.value) {
      case Status.LOADING:
        return showLoader(child: Container(), isLoading: true);
      case Status.SUCCESS:
        return Center(
          child: Container(
            height: 100.h,
            width: 100.w,
            child: Stack(
              children: [
                Container(
                  height: 80.h,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return AnimatedPhysicalModel(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.bounceIn,
                        elevation: 0.0,
                        shape: BoxShape.rectangle,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // width: 100.w,
                                padding: EdgeInsets.fromLTRB(30, 60, 30, 30),
                                // alignment: Alignment.topCenter,
                                // color: colorGreen,
                                child: index == 3
                                    ? Column(
                                        children: [
                                          Expanded(
                                            child: RotatedBox(
                                              quarterTurns: 2,
                                              child: Marquee(
                                                  loopDuration: const Duration(
                                                      milliseconds: 5000),
                                                  child: RotatedBox(
                                                    quarterTurns: 2,
                                                    child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child: Image.asset(
                                                                "assets/slide/1.png"),
                                                          ),
                                                          SizedBox(width: 10),
                                                          SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Image.asset(
                                                                  "assets/slide/2.png")),
                                                          SizedBox(width: 10),
                                                          SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Image.asset(
                                                                  "assets/slide/3.jpg")),
                                                          SizedBox(width: 10),
                                                          SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Image.asset(
                                                                  "assets/slide/4.png")),
                                                        ]),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Marquee(
                                                loopDuration: const Duration(
                                                    milliseconds: 5000),
                                                child: ListView(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    children: [
                                                      SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                        child: Image.asset(
                                                            "assets/slide/5.png"),
                                                      ),
                                                      SizedBox(width: 10),
                                                      SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Image.asset(
                                                              "assets/slide/6.png")),
                                                      SizedBox(width: 10),
                                                      SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Image.asset(
                                                              "assets/slide/7.png")),
                                                      SizedBox(width: 10),
                                                      SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Image.asset(
                                                              "assets/slide/8.png")),
                                                    ])),
                                          ),
                                          Expanded(
                                            child: RotatedBox(
                                              quarterTurns: 2,
                                              child: Marquee(
                                                  loopDuration: const Duration(
                                                      milliseconds: 5000),
                                                  child: RotatedBox(
                                                    quarterTurns: 2,
                                                    child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child: Image.asset(
                                                                "assets/slide/9.png"),
                                                          ),
                                                          SizedBox(width: 10),
                                                          SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Image.asset(
                                                                  "assets/slide/10.png")),
                                                          SizedBox(width: 10),
                                                          SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Image.asset(
                                                                  "assets/slide/11.png")),
                                                          SizedBox(width: 10),
                                                          SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Image.asset(
                                                                  "assets/slide/12.png")),
                                                        ]),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            // color: colorError,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.network(
                                            controller
                                                .slides![controller
                                                    .currentPage.value]
                                                .image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 30, right: 30, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller
                                              .slides![
                                                  controller.currentPage.value]
                                              .title ??
                                          '',
                                      style: textTheme.headline5,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      controller
                                              .slides![
                                                  controller.currentPage.value]
                                              .description ??
                                          '',
                                      style: textTheme.bodyText1!
                                          .copyWith(color: colorNeutral80),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: controller.slides!.length,
                    //boucingscrollphysics() membuat efek mantul saat discroll ke samping
                    physics: BouncingScrollPhysics(),
                    controller: controller.pageController,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                // Container(
                //   height: 50.h,
                //   color: Colors.white,
                //   padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
                //   child: CarouselSlider(
                //     carouselController: controller.carouselController,
                //     options: CarouselOptions(
                //       height: 50.h,
                //       viewportFraction: 1.0,
                //       enlargeCenterPage: false,
                //       enableInfiniteScroll: true,
                //       onPageChanged: (index, reason) =>
                //           controller.currentPage.value = index,
                //       autoPlay: true,
                //     ),
                //     items: controller.slides!.map((slide) {
                //       return Builder(
                //         builder: (BuildContext context) {
                //           return ClipRRect(
                //               borderRadius: BorderRadius.circular(20),
                //               child: CachedNetworkImage(
                //                 imageUrl: slide.image!,
                //                 fit: BoxFit.cover,
                //                 errorWidget: (context, url, error) {
                //                   return Container(
                //                     color: colorGrey,
                //                   );
                //                 },
                //               ));
                //         },
                //       );
                //     }).toList(),
                //   ),
                // ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: controller.slides!
                        .map<Widget>((e) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: controller.currentPage.value ==
                                        controller.slides!.indexOf(e)
                                    ? colorTeal
                                    : colorGrey,
                                shape: BoxShape.circle,
                              ),
                              height: 8,
                              width: 8,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      case Status.ERROR:
        return Container();
      default:
        return Container();
    }
  }
}
