import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/forget_controller.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';

class OtpPage extends GetView<ForgetController> {
  final ForgetController controller = Get.put(ForgetController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetHelper.getHeader(context, ''),
      body: Obx(
        () => SingleChildScrollView(
          child: showLoader(
            isLoading: controller.status.value == Status.LOADING,
            child: Container(
              padding: mainPadding(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading(textTheme, context),
                    getFieldSeparator(height: 50),
                    // form(context),
                    // getFieldSeparator(height: 30),
                    Center(
                      child: ButtonView(
                          onPressed: () {
                            controller.requestResetAgain();
                          },
                          text: 'Didn\'t work? Send again'),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  heading(TextTheme textTheme, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getFieldSeparator(height: 30),
        Text(
          'otp.check_email',
          style: textTheme.headline5,
        ).tr(),
        SizedBox(height: 10),
        Text(
          'We have sent you an email to reset your password. ',
          style: textTheme.bodyText1,
        ),
      ],
    );
  }

  // form(BuildContext context) {
  //   return PinCodeTextField(
  //     length: 4,
  //     obscureText: false,
  //     animationType: AnimationType.fade,
  //     pinTheme: PinTheme(
  //         shape: PinCodeFieldShape.underline,
  //         borderRadius: BorderRadius.circular(0),
  //         fieldHeight: 50,
  //         fieldWidth: 50,
  //         selectedColor: colorPrimary,
  //         activeColor: colorPrimary,
  //         errorBorderColor: colorPrimary,
  //         inactiveColor: colorBlack),
  //     animationDuration: const Duration(milliseconds: 300),
  //     backgroundColor: Colors.white,
  //     cursorColor: colorPrimary,
  //     enableActiveFill: false,
  //     controller: otpController,
  //     onCompleted: (v) {
  //       debugPrint("Completed");
  //     },
  //     onChanged: (value) {
  //       debugPrint(value);
  //       //controller.otp = value;
  //     },
  //     beforeTextPaste: (text) {
  //       return true;
  //     },
  //     appContext: context,
  //   );
  // }
}
