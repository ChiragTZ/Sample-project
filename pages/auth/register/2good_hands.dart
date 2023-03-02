import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:sizer/sizer.dart';

class GoodHandsPage extends GetView<RegisterController> {
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
                      getFieldSeparator(height: 50),
                      CachedNetworkImage(
                        imageUrl: AppGlobal.commonSignup!.inGoodHands ?? "",
                        fit: BoxFit.cover,
                        height: 25.h,
                        width: 100.w,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: colorGrey,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // ButtonView(
              //   text: tr("form.lets_get_start"),
              //   onPressed: () {
              //     Get.toNamed(Routes.SETTING_UP_PROGRAM);
              //   },
              // ),
              // getFieldSeparator(height: 30)
            ],
          )),
      bottomNavigationBar: Container(
        padding: mainPadding().copyWith(bottom: 30),
        child: ButtonView(
          text: tr("form.lets_get_start"),
          onPressed: () {
            Get.toNamed(Routes.SETTING_UP_PROGRAM);
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
          'form.good_hands',
          style: textTheme.headline5,
        ).tr(),
        SizedBox(height: 20),
        Text(
          'form.good_handes_desc1',
          style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
        ).tr(),
        SizedBox(height: 20),
        Text(
          'form.good_handes_desc2',
          style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
        ).tr(),
      ],
    );
  }
}
