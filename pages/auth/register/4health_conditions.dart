import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/register_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';

class HealthConditionsPage extends GetView<RegisterController> {
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
                    getFieldSeparator(height: 10),
                    const LinearProgressIndicator(
                        color: colorWhite,
                        backgroundColor: colorGrey,
                        valueColor: AlwaysStoppedAnimation<Color>(colorTeal),
                        value: 0.4,
                        minHeight: 3),
                    getFieldSeparator(height: 30),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 10),
                        itemExtent: 50,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (controller
                                    .listConditions[index].isSelected.value) {
                                  controller.listConditions[index].isSelected
                                      .value = false;
                                } else {
                                  controller.listConditions[index].isSelected
                                      .value = true;
                                }
                              },
                              child: Row(
                                children: [
                                  Obx(
                                    () => SizedBox(
                                      height: 24.0,
                                      width: 24.0,
                                      child: Checkbox(
                                          value: controller
                                              .listConditions[index]
                                              .isSelected
                                              .value,
                                          checkColor: colorWhite,
                                          activeColor: colorSecondary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          onChanged: ((value) {
                                            controller.listConditions[index]
                                                .isSelected.value = value!;
                                          })),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    controller.listConditions[index].title!,
                                    style: textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ));
                        }),
                        itemCount: controller.listConditions.length,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar: Container(
        padding: mainPadding().copyWith(bottom: 30),
        child: ButtonView(
          text: tr("form.next"),
          onPressed: () {
            Get.toNamed(Routes.JOURNEY);
          },
        ),
      ),
    );
  }

  // List<DropdownMenuItem<String>> _dropDownItem() {
  //   List<String> ddl = [
  //     "Male",
  //     "Female",
  //   ];
  //   return ddl
  //       .map((value) => DropdownMenuItem(
  //             value: value,
  //             child: Text(
  //               value,
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   color: colorAnswer,
  //                   fontWeight: FontWeight.w400),
  //             ),
  //           ))
  //       .toList();
  // }

  heading(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getFieldSeparator(height: 20),
        Text(
          'form.health_conditions',
          style: textTheme.headline5,
        ).tr(),
        SizedBox(height: 20),
      ],
    );
  }
}
