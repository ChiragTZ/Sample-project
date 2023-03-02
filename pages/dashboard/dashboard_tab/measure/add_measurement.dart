import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/controller/measure_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/buttons/ButtonView1.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/widgets/decoration/inputDecoration.dart';
import 'package:sizer/sizer.dart';

class AddMeasurementPage extends GetView<MeasureController> {
  final MeasureController controller = Get.put(MeasureController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        appBar: WidgetHelper.getHeader(
            context,
            controller.isEdit.value
                ? tr("measure.edit_last_week_measurement")
                : tr('measure.new_measurement')),
        body: GestureDetector(
          onTap: () {
            AppGlobal.hideKeyboard(context);
          },
          child: Obx(
            () => showLoader(
              isLoading: controller.status.value == Status.LOADING,
              child: Container(
                height: 100.h,
                width: 100.w,
                margin: EdgeInsets.only(left: 25, right: 25),
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!controller.isEdit.value) SizedBox(height: 20),
                        if (!controller.isEdit.value)
                          ButtonView1(
                            text: tr("measure.edit_last_week_measurement"),
                            onPressed: () {
                              controller.editLastWeek();
                            },
                          ),
                        SizedBox(height: 20),
                        Divider(),
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'measure.today_weight',
                                  style: textTheme.subtitle1,
                                  textAlign: TextAlign.start,
                                ).tr(),
                              ),
                              Expanded(
                                child: Container(
                                    width: 80,
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: controller
                                                .todayWeightController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: inputDecorationNone(
                                                    context, "0")
                                                .copyWith(
                                                    hintStyle: textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color:
                                                                colorNeutral60),
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 5, 5, 5)),
                                            textAlign: TextAlign.end,
                                            cursorColor: colorBlack,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(color: colorBlack),
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
                        Divider(),
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'measure.waist',
                                  style: textTheme.subtitle1,
                                  textAlign: TextAlign.start,
                                ).tr(),
                              ),
                              Expanded(
                                child: Container(
                                    width: 80,
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                controller.waistController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: inputDecorationNone(
                                                    context, "0")
                                                .copyWith(
                                                    hintStyle: textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color:
                                                                colorNeutral60),
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 5, 5, 5)),
                                            textAlign: TextAlign.end,
                                            cursorColor: colorBlack,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: colorBlack,
                                                ),
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
                        Divider(),
                        SizedBox(height: 20),
                        Text(
                          'measure.how_do_you_feel',
                          style: textTheme.subtitle1,
                          textAlign: TextAlign.start,
                        ).tr(),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount:
                              controller.measure.value.howYouFeel!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                              () => new GestureDetector(
                                onTap: () {
                                  controller.selectSample(index);
                                },
                                child: radioItem(
                                    textTheme,
                                    controller
                                        .measure.value.howYouFeel![index]),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'measure.comment_on_your_progress_this_week',
                          style: textTheme.subtitle1,
                          textAlign: TextAlign.start,
                        ).tr(),
                        getFieldSeparator(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 100.w * 0.02),
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 1, color: colorNeutral50)),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            controller: controller.commentController,
                            style: textTheme.bodyText1,
                            maxLines: 5,
                            minLines: 5,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              border: InputBorder.none,
                              fillColor: Colors.grey,
                              alignLabelWithHint: true,
                              hintText: tr("measure.add_comment"),
                              hintStyle: textTheme.bodyText1!
                                  .copyWith(color: colorNeutral90),
                              //create lable
                              // labelText: tr("measure.add_comment"),
                              // //lable style
                              // labelStyle: textTheme.headline5!.copyWith(),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ButtonView(
                                text: tr("common.cancel"),
                                color: Colors.transparent,
                                onPressed: () {
                                  if (controller.isEdit.value) {
                                    if (controller.measure.value
                                            .measurementAddedForWeek !=
                                        0) {
                                      Get.back();
                                    } else {
                                      controller.editLastWeek();
                                    }
                                  } else {
                                    Get.back();
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: ButtonView(
                                text: controller.isEdit.value
                                    ? tr("password.save_changes")
                                    : tr("common.submit"),
                                onPressed: () {
                                  if (controller.isEdit.value) {
                                    controller.updateMeasure();
                                  } else {
                                    controller.addMeasure();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        getFieldSeparator(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  radioItem(TextTheme textTheme, item) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 25.0,
            width: 25.0,
            padding: EdgeInsets.all(7),
            child: CircleAvatar(backgroundColor: colorWhite),
            decoration: new BoxDecoration(
              color: item == controller.selectedItem.value
                  ? colorSecondary
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: item == controller.selectedItem.value
                      ? colorSecondary
                      : colorNeutral60),
              borderRadius: const BorderRadius.all(const Radius.circular(50.0)),
            ),
          ),
          Expanded(
            child: Container(
              margin: new EdgeInsets.only(left: 10.0),
              child: new Text(
                item,
                style:
                    textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
