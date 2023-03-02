import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetHelper.getHeader(context, "", onBackClick: () {
        navigate();
      }),
      body: Container(
        height: 100.h,
        width: 100.w,
        margin: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Get.arguments['title'],
              style: textTheme.subtitle2!.copyWith(color: colorDarkText),
              textAlign: TextAlign.start,
            ),
            getFieldSeparator(),
            Text(
              Get.arguments['desc'],
              style: textTheme.bodyText1!.copyWith(color: colorDarkText),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: ButtonView(
        text: Get.arguments['goToText'],
        margin: EdgeInsets.all(30),
        onPressed: () {
          navigate();
        },
      ),
    );
  }

  navigate() {
    if (Get.arguments['goToText'] == "Return to Overview") {
      Get.offAllNamed(Routes.HOME);
    } else if (Get.arguments['goToText'] == "Return to Rewards") {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.back();
    }
  }
}
