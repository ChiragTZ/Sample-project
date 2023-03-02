import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/register_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';

class HappyPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetHelper.getHeader(context, ""),
      body: Container(
          padding: mainPadding(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading(textTheme),
                      getFieldSeparator(height: 10),
                      Text(
                        'form.prevent_body_fitting',
                        style: textTheme.bodyText1!
                            .copyWith(color: colorNeutral90),
                        textAlign: TextAlign.start,
                      ).tr(),
                      CarouselSlider(
                        // carouselController: controller.carouselController,
                        options: CarouselOptions(
                          viewportFraction: 0.8,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) =>
                              controller.currentPage.value = index,
                          autoPlay: false,
                        ),
                        items:
                            AppGlobal.commonSignup!.happyToHere!.map((slide) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Obx(
                                () => Row(
                                  children: [
                                    if (controller.currentPage.value == 1)
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 1,
                                                color: colorSecondary)),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: colorSecondary,
                                          size: 25,
                                        ),
                                      ),
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: slide,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: colorGrey,
                                          );
                                        },
                                      ),
                                    ),
                                    if (controller.currentPage.value == 0)
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 1,
                                                color: colorSecondary)),
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: colorSecondary,
                                          size: 25,
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      getFieldSeparator(height: 20),
                      Text(
                        'form.dieting_accelerates',
                        style: textTheme.bodyText1!
                            .copyWith(color: colorNeutral90),
                        textAlign: TextAlign.start,
                      ).tr(),
                      getFieldSeparator(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          )),
      bottomNavigationBar: Container(
        padding: mainPadding().copyWith(bottom: 30),
        child: ButtonView(
          text: tr("form.next"),
          onPressed: () {
            Get.toNamed(Routes.DESCRIBE);
          },
        ),
      ),
    );
  }

  heading(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getFieldSeparator(height: 20),
        Text(
          'form.happy_here',
          style: textTheme.headline5,
        ).tr(),
        getFieldSeparator(height: 20),
      ],
    );
  }
}
