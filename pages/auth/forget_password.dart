import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/forget_controller.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/ValidationHelper.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/outLineBorderTextFormField.dart';

class ForgetPasswordPage extends GetView<ForgetController> {
  final ForgetController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetHelper.getHeader(context, ""),
      body: Obx(
        () => showLoader(
          isLoading: controller.status.value == Status.LOADING,
          child: SingleChildScrollView(
            child: Container(
              padding: mainPadding(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading(textTheme),
                  getFieldSeparator(height: 50),
                  form(textTheme, context),
                  getFieldSeparator(height: 30),
                  Center(
                    child: ButtonView(
                        onPressed: () {
                          controller.requestResetPassword();
                        },
                        text: tr("forget_password.continue")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  heading(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getFieldSeparator(height: 30),
        Text(
          'Reset password',
          style: textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Enter your email address to reset your password',
          style: textTheme.bodyText1,
        ),
      ],
    );
  }

  form(TextTheme textTheme, BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: Column(
        children: [
          OutlineBorderTextFormField(
            labelText: tr("login.email"),
            myFocusNode: controller.recoveryEmailFocus,
            tempTextEditingController: controller.recoveryEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofocus: false,
            autofillHints: [
              AutofillHints.email,
            ],
            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(18),
            ],
            validation: (value) =>
                ValidationHelper.checkEmailValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
        ],
      ),
    );
  }
}
