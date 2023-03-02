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

class JourneyPage extends GetView<RegisterController> {
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
            padding: mainPadding(),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading(textTheme),
                      const LinearProgressIndicator(
                        color: colorWhite,
                        backgroundColor: colorGrey,
                        valueColor: AlwaysStoppedAnimation<Color>(colorTeal),
                        value: 0.8,
                        minHeight: 3,
                      ),
                      getFieldSeparator(height: 30),
                      Expanded(
                          child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 20),
                        child: form(textTheme, context),
                      )),
                      getFieldSeparator()
                    ],
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: Container(
        padding: mainPadding().copyWith(bottom: 30),
        child: ButtonView(
          text: tr("form.next"),
          onPressed: () {
            Get.toNamed(Routes.HAPPY);
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
        Text('form.understand_journey', style: textTheme.headline5).tr(),
        getFieldSeparator(height: 20),
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
                      'form.lowest_adult_weight',
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
                              controller: controller.lWController,
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
                          style: textTheme.bodyText1!
                              .copyWith(color: colorNeutral80),
                          textAlign: TextAlign.start,
                        ).tr(),
                      ],
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
                      'form.highest_adult_weight',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ).tr(),
                  ),
                  Expanded(
                    child: Container(
                        width: 80,
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.hWController,
                                decoration: inputDecorationNone(context, "")
                                    .copyWith(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5, 5, 5, 5),
                                        hintText: "0",
                                        hintStyle: textTheme.bodyText1!
                                            .copyWith(color: colorGrey)),
                                textAlign: TextAlign.end,
                                cursorColor: colorBlack,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.bodyText1,
                                autocorrect: false,
                              ),
                            ),
                            Text(
                              'form.kg',
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
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'form.regained_weight',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ).tr(),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectedGainedW.value =
                                controller.selectedGainedW.value ?? 0;
                            WidgetHelper.showIOSBottomPicker(
                                context, controller.gainedWList, (value) {
                              controller.selectedGainedW.value = value;
                            }, selected: controller.selectedGainedW.value);
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Obx(
                                () => Text(
                                  controller.selectedGainedW.value != null
                                      ? controller.gainedWList[
                                          controller.selectedGainedW.value!]
                                      : "Select",
                                  style: textTheme.bodyText1!.copyWith(
                                      color: controller.selectedGainedW.value !=
                                              null
                                          ? colorBlack
                                          : colorGrey),
                                ),
                              )),
                        ),
                        SizedBox(height: 5),
                        Obx(
                          () => Visibility(
                            visible: controller.selectedGainedW.value != null &&
                                controller.gainedWList[
                                        controller.selectedGainedW.value!] ==
                                    "Yes",
                            child: TextFormField(
                              // controller: controller.waistController,
                              decoration:
                                  inputDecorationNone(context, "Which diet?")
                                      .copyWith(
                                          hintStyle: textTheme.bodyText1!
                                              .copyWith(color: colorNeutral60),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5)),
                              textAlign: TextAlign.end,
                              cursorColor: colorBlack,
                              style: Theme.of(context).textTheme.bodyText1,
                              autocorrect: false,
                            ),
                          ),
                        ),
                      ],
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
                      'How long has it been since you were at your lowest weight?',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.lowestWeightSelected.value =
                            controller.lowestWeightSelected.value ?? 0;
                        WidgetHelper.showIOSBottomPicker(
                            selected: controller.lowestWeightSelected.value,
                            context,
                            controller.lowestWeightList, (value) {
                          controller.lowestWeightSelected.value = value;
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Text(
                              controller.lowestWeightSelected.value != null
                                  ? controller.lowestWeightList[
                                      controller.lowestWeightSelected.value!]
                                  : "Select",
                              style: textTheme.bodyText1!.copyWith(
                                  color:
                                      controller.lowestWeightSelected.value !=
                                              null
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
                      'Which best describes your current status?',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.relationSelected.value =
                            controller.relationSelected.value ?? 0;
                        WidgetHelper.showIOSBottomPicker(
                            selected: controller.relationSelected.value,
                            context,
                            controller.relationList, (value) {
                          controller.relationSelected.value = value;
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Text(
                              controller.relationSelected.value != null
                                  ? controller.relationList[
                                      controller.relationSelected.value!]
                                  : "Select",
                              style: textTheme.bodyText1!.copyWith(
                                  color:
                                      controller.relationSelected.value != null
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'How did you hear about us? ',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.hereSelected.value =
                            controller.hereSelected.value ?? 0;
                        WidgetHelper.showIOSBottomPicker(
                            selected: controller.hereSelected.value,
                            context,
                            controller.hereList, (value) {
                          controller.hereSelected.value = value;
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Text(
                              controller.hereSelected.value != null
                                  ? controller
                                      .hereList[controller.hereSelected.value!]
                                  : "Select",
                              style: textTheme.bodyText1!.copyWith(
                                  color: controller.hereSelected.value != null
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Have you been following IWL after reading the books?',
                      style: textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.howFollowSelected.value =
                            controller.howFollowSelected.value ?? 0;
                        WidgetHelper.showIOSBottomPicker(
                            selected: controller.howFollowSelected.value,
                            context,
                            controller.howFollowList, (value) {
                          controller.howFollowSelected.value = value;
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Text(
                              controller.howFollowSelected.value != null
                                  ? controller.howFollowList[
                                      controller.howFollowSelected.value!]
                                  : "Select",
                              style: textTheme.bodyText1!.copyWith(
                                  color:
                                      controller.howFollowSelected.value != null
                                          ? colorBlack
                                          : colorGrey),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            getDivider(height: 30),
            Text(
              'Explain in more detail your personal health goals.',
              style: textTheme.subtitle1,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100.w * 0.02),
              decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: colorNeutral50,
                  )),
              margin: EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                // controller: _commentController,
                style: textTheme.bodyText1!.copyWith(color: colorBlack),
                maxLines: 5,
                minLines: 5,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: InputBorder.none,
                  fillColor: Colors.grey,
                  alignLabelWithHint: true,
                  hintText: "Type here...",
                  hintStyle:
                      textTheme.bodyText1!.copyWith(color: colorNeutral80),
                  //create lable
                  // labelText: tr("measure.add_comment"),
                  // //lable style
                  // labelStyle: textTheme.headline5!.copyWith(),
                ),
              ),
            ),
            // getDivider(height: 30),
            // Text(
            //   'Please tell us a little about your weight and dieting history.',
            //   style: textTheme.headline5!.copyWith(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //       color: colorDarkText),
            //   textAlign: TextAlign.start,
            // ),
            // SizedBox(height: 10),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 100.w * 0.02),
            //   decoration: BoxDecoration(
            //       color: colorWhite,
            //       borderRadius: BorderRadius.circular(8),
            //       border: Border.all(
            //         width: 1,
            //         color: colorNeutral50,
            //       )),
            //   margin: EdgeInsets.symmetric(vertical: 4),
            //   child: TextFormField(
            //     // controller: _commentController,
            //     style: textTheme.headline5!.copyWith(color: colorBlack),
            //     maxLines: 5,
            //     minLines: 5,
            //     textAlign: TextAlign.left,
            //     decoration: InputDecoration(
            //       focusColor: Colors.white,
            //       border: InputBorder.none,
            //       fillColor: Colors.grey,
            //       alignLabelWithHint: true,
            //       hintText: "Type here...",
            //       hintStyle:
            //           textTheme.headline5!.copyWith(color: colorNeutral80),
            //       //create lable
            //       // labelText: tr("measure.add_comment"),
            //       // //lable style
            //       // labelStyle: textTheme.headline5!.copyWith(),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
