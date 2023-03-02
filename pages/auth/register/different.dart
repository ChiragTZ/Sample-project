import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/register_controller.dart';
import 'package:iwl/pages/auth/register/3setting_up_program.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:sizer/sizer.dart';

class DifferentPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.05, horizontal: size.width * 0.05),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 5.h),
                      // backBar(context),
                      SizedBox(height: 4.h),
                      Text(
                        'form.what_makes_diff',
                        style: textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w700, color: colorDarkText),
                        textAlign: TextAlign.start,
                      ).tr(),
                      ListView.builder(
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/icons/checkbox.png',
                                    height: MediaQuery.of(context).size.width *
                                        0.08,
                                    color: colorTeal,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        controller.listDiff[index],
                                        style: textTheme.headline6!.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: colorBlack),
                                        textAlign: TextAlign.start,
                                      ).tr())
                                ],
                              ));
                        }),
                        itemCount: controller.listDiff.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
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
            Get.to(SettingUpProgramPage());
          },
        ),
      ),
    );
  }
}
