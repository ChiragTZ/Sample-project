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
import 'package:iwl/widgets/decoration/inputDecoration.dart';
import 'package:sizer/sizer.dart';

class SettingUpProgramPage extends GetView<RegisterController> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetHelper.getHeader(context, ""),
      body: GestureDetector(
        onTap: () {
          AppGlobal.hideKeyboard(context);
        },
        child: Container(
            height: 100.h,
            padding: mainPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading(textTheme),
                getFieldSeparator(height: 20),
                LinearProgressIndicator(
                  color: colorWhite,
                  backgroundColor: colorGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(colorTeal),
                  value: 0.2,
                  minHeight: 3,
                ),
                getFieldSeparator(height: 30),
                Expanded(
                    child: SingleChildScrollView(
                  child: form(textTheme, context),
                )),
                getFieldSeparator(height: 20),
              ],
            )),
      ),
      bottomNavigationBar: Container(
        padding: mainPadding().copyWith(bottom: 30),
        child: ButtonView(
          text: tr("form.next"),
          onPressed: () {
            Get.toNamed(Routes.HEALTH_CONDITIONS);
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
          'form.up_your_program',
          style: textTheme.headline5,
        ).tr(),
        SizedBox(height: 20),
        Text(
          'form.personalize_your_plan',
          style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
          textAlign: TextAlign.start,
        ).tr(),
      ],
    );
  }

  form(TextTheme textTheme, BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getDivider(height: 10),
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'form.gender',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ).tr(),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectedGender.value =
                            controller.selectedGender.value ?? 0;
                        WidgetHelper.showIOSBottomPicker(
                            selected: controller.selectedGender.value,
                            context,
                            controller.genderList, (value) {
                          controller.selectedGender.value = value;
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Text(
                              controller.selectedGender.value != null
                                  ? controller.genderList[
                                      controller.selectedGender.value!]
                                  : "Select",
                              style: textTheme.bodyText1!.copyWith(
                                  color: controller.selectedGender.value != null
                                      ? colorBlack
                                      : colorGrey),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            getDivider(height: 10),
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'form.age',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ).tr(),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectedAge.value =
                            controller.selectedAge.value ?? 0;
                        WidgetHelper.showIOSBottomPicker(
                            selected: controller.selectedAge.value,
                            context,
                            controller.ageList, (value) {
                          controller.selectedAge.value = value;
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Text(
                              controller.selectedAge.value != null
                                  ? controller
                                      .ageList[controller.selectedAge.value!]
                                  : "Select",
                              style: textTheme.bodyText1!.copyWith(
                                  color: controller.selectedAge.value != null
                                      ? colorBlack
                                      : colorGrey),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            getDivider(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: 100.w,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'form.height',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ).tr(),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.textHeightController,
                                decoration: inputDecorationNone(context, "")
                                    .copyWith(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5, 5, 5, 5),
                                        hintText: "0",
                                        hintStyle: textTheme.bodyText1!
                                            .copyWith(color: colorGrey)),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                cursorColor: colorBlack,
                                style: Theme.of(context).textTheme.bodyText1,
                                autocorrect: false,
                              ),
                            ),
                            Text(
                              'form.cm',
                              style: textTheme.bodyText1!
                                  .copyWith(color: colorNeutral80),
                              textAlign: TextAlign.start,
                            ).tr(),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            getDivider(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: 100.w,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'form.current_weight',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ).tr(),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              controller: controller.textWeightController,
                              decoration: inputDecorationNone(context, "")
                                  .copyWith(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      hintText: "0",
                                      hintStyle: textTheme.bodyText1!
                                          .copyWith(color: colorGrey)),
                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.number,
                              cursorColor: colorBlack,
                              style: Theme.of(context).textTheme.bodyText1,
                              autocorrect: false,
                            ),
                          ),
                        ),
                        Text(
                          'form.kg',
                          style: textTheme.headline3!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: colorNeutral80),
                          textAlign: TextAlign.start,
                        ).tr(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // getDivider(height: 10),
            // Container(
            //   height: 50,
            //   width: 100.w,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Text(
            //           'form.goal_weight',
            //           style: textTheme.headline3!.copyWith(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w600,
            //               color: colorDarkText),
            //           textAlign: TextAlign.start,
            //         ).tr(),
            //       ),
            //       Expanded(
            //         child: Container(
            //             width: 80,
            //             alignment: Alignment.centerRight,
            //             child: Row(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Expanded(
            //                   child: TextFormField(
            //                     controller: textGoalWeightController,
            //                     decoration: inputDecorationNone(context, "")
            //                         .copyWith(
            //                             contentPadding:
            //                                 EdgeInsets.fromLTRB(5, 5, 5, 5),
            //                             hintText: "0",
            //                             hintStyle: textTheme.headline5!
            //                                 .copyWith(color: colorGrey)),
            //                     textAlign: TextAlign.end,
            //                     cursorColor: colorBlack,
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .headline6!
            //                         .copyWith(
            //                             color: colorBlack,
            //                             fontWeight: FontWeight.w400),
            //                     autocorrect: false,
            //                   ),
            //                 ),
            //                 Text(
            //                   'form.kg',
            //                   style: textTheme.headline3!.copyWith(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w400,
            //                       color: colorNeutral80),
            //                   textAlign: TextAlign.start,
            //                 ).tr(),
            //               ],
            //             )),
            //       ),
            //     ],
            //   ),
            // ),
            getDivider(height: 10),

            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'What is your preferred start day?',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        WidgetHelper.showIOSBottomPicker(
                            context, controller.dayList,
                            selected: controller.selectedDay.value, (value) {
                          controller.selectedDay.value = value;
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Obx(
                          () => Text(
                            controller
                                .dayList[controller.selectedDay.value ?? 0],
                            style: textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Text(
            //   'What is your preferred start day? ',
            //   style: textTheme.headline5!.copyWith(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //       color: colorSecondary),
            //   textAlign: TextAlign.start,
            // ).tr(),
            // InkWell(
            //     onTap: () {
            //       WidgetHelper.showIOSBottomPicker(context, controller.dayList,
            //           selected: controller.selectedDay.value, (value) {
            //         controller.selectedDay.value = value;
            //       });
            //     },
            //     child: Container(
            //         // width: 60.w,
            //         height: 40,
            //         margin: EdgeInsets.only(top: 20),
            //         padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(color: colorBorder)),
            //         child: Row(
            //           children: [
            //             Expanded(
            //                 child: Obx(
            //               () => Text(
            //                 controller
            //                     .dayList[controller.selectedDay.value ?? 0],
            //                 style: textTheme.headline5!.copyWith(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w400,
            //                     color: colorBlack),
            //               ),
            //             )),
            //             Icon(Icons.keyboard_arrow_down),
            //           ],
            //         ))),
            getFieldSeparator()
          ],
        ));
  }
}
