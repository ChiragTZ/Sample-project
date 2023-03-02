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

class DescribePage extends GetView<RegisterController> {
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
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading(textTheme),
                  getFieldSeparator(height: 20),
                  const LinearProgressIndicator(
                      color: colorWhite,
                      backgroundColor: colorGrey,
                      valueColor: AlwaysStoppedAnimation<Color>(colorTeal),
                      value: 0.6,
                      minHeight: 3),
                  getFieldSeparator(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listHabit.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.listHabit[index].isSelected.value) {
                            controller.listHabit[index].isSelected.value =
                                false;
                          } else {
                            controller.listHabit[index].isSelected.value = true;
                          }
                        },
                        child: Obx(
                          () => Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            decoration: boxdecoration(
                                controller.listHabit[index].isSelected.value
                                    ? colorTeal50
                                    : colorAnswerBackground,
                                controller.listHabit[index].isSelected.value
                                    ? colorTeal50
                                    : colorAnswerBackground,
                                8.0,
                                1.0),
                            child: Text(
                              controller.listHabit[index].title!,
                              style: textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: controller
                                          .listHabit[index].isSelected.value
                                      ? colorTealDark
                                      : colorDarkText),
                              textAlign: TextAlign.start,
                            ).tr(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
              // ButtonView(
              //   text: tr("forget_password.continue"),
              //   onPressed: () {
              //     Get.toNamed(Routes.JOURNEY);
              //   },
              // ),
              // getFieldSeparator()
            ],
          )),
      bottomNavigationBar: Container(
        padding: mainPadding().copyWith(bottom: 30),
        child: ButtonView(
          text: tr("form.next"),
          onPressed: () {
            Get.toNamed(Routes.FOCUS_ON);
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
          'form.describes_you',
          style: textTheme.headline5,
        ).tr(),
        getFieldSeparator(height: 20),
        Text(
          'form.Healthy_habits',
          style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
          textAlign: TextAlign.start,
        ).tr(),
      ],
    );
  }
}
