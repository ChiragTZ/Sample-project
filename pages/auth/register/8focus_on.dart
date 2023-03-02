import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:iwl/widgets/decoration/boxDecoration.dart';

class FocusOnPage extends StatefulWidget {
  const FocusOnPage({Key? key}) : super(key: key);

  @override
  State<FocusOnPage> createState() => FocusOnPageState();
}

class FocusOnPageState extends State<FocusOnPage> {
  late TextTheme textTheme;
  List<HabitModel> listHabit = [
    HabitModel(tr("form.portion_control"), true),
    HabitModel(tr("form.overcoming_food_addiction"), false),
    HabitModel(tr("form.exercise"), false),
    HabitModel(tr("form.better_spleep"), false),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
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
                  heading(),
                  const LinearProgressIndicator(
                    color: colorWhite,
                    backgroundColor: colorGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(colorTeal),
                    value: 1,
                    minHeight: 3,
                  ),
                  getFieldSeparator(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: listHabit.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            for (var h in listHabit) {
                              h.isSelected = false;
                            }
                            listHabit[index].isSelected = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          height: 50,
                          width: double.infinity,
                          decoration: boxdecoration(
                              listHabit[index].isSelected!
                                  ? colorTeal50
                                  : colorAnswerBackground,
                              listHabit[index].isSelected!
                                  ? colorTeal50
                                  : colorAnswerBackground,
                              8.0,
                              1.0),
                          child: Text(
                            listHabit[index].title!,
                            style: textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: listHabit[index].isSelected!
                                    ? colorTealDark
                                    : colorDarkText),
                            textAlign: TextAlign.start,
                          ).tr(),
                        ),
                      );
                    },
                  ),
                ],
              )),
              // ButtonView(
              //   text: tr("forget_password.continue"),
              //   onPressed: () {
              //     Get.toNamed(Routes.PLAN);
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
            Get.toNamed(Routes.PLAN);
          },
        ),
      ),
    );
  }

  heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getFieldSeparator(),
        Text(
          'form.want_to_focus_on',
          style: textTheme.headline5,
        ).tr(),
        getFieldSeparator(),
      ],
    );
  }
}

class HabitModel {
  String? title;
  bool? isSelected;

  HabitModel(this.title, this.isSelected);
}
