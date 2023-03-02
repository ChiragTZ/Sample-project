import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/auth_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/ValidationHelper.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/outLineBorderTextFormField.dart';
import 'package:iwl/utils/routes/app_pages.dart';

class LoginPage extends GetView<AuthController> {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppGlobal.hideKeyboard(context),
      child: Scaffold(
        appBar: WidgetHelper.getHeader(context, ""),
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Obx(
      () => showLoader(
        isLoading: controller.status.value == Status.LOADING,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: mainPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading(textTheme),
                getFieldSeparator(height: 50),
                form(textTheme, context),
                SizedBox(height: 10),
                Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        child: Text(
                          'login.forget_password',
                          style: textTheme.bodyText2!
                              .copyWith(color: colorNeutral80),
                          textAlign: TextAlign.center,
                        ).tr(),
                        onTap: () {
                          Get.toNamed(Routes.FORGET);
                        })),
                getFieldSeparator(height: 30),
                Center(
                  child: ButtonView(
                      onPressed: () {
                        controller.login();
                      },
                      text: tr("login.log_in")),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'login.notHaveAccount',
                      style: textTheme.bodyText1!
                          .copyWith(fontSize: 15, color: colorNeutral90),
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: Text(
                        'login.sign_up',
                        style: textTheme.bodyText1!.copyWith(
                          fontSize: 15,
                          color: colorNeutral90,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ).tr(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
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
          'login.welcome_back',
          style: textTheme.headline5,
          textAlign: TextAlign.center,
        ).tr(),
        SizedBox(height: 10),
        Text(
          'login.to_account',
          style: textTheme.bodyText1,
          textAlign: TextAlign.center,
        ).tr(),
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
            myFocusNode: controller.emailFocus,
            tempTextEditingController: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: true,
            autofillHints: [
              AutofillHints.email,
            ],
            onSubmit: () {
              FocusScope.of(context).requestFocus(controller.passwordFocus);
            },
            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              LengthLimitingTextInputFormatter(320),
            ],
            validation: (value) =>
                ValidationHelper.checkEmailValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
          getFieldSeparator(height: 10),
          OutlineBorderTextFormField(
            labelText: tr("login.password"),
            myFocusNode: controller.passwordFocus,
            tempTextEditingController: controller.passwordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            autofocus: false,
            checkOfErrorOnFocusChange: true,
            maxLine: 1,
            obscureText: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(6),
            ],
            validation: (value) =>
                ValidationHelper.checkPasswordValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
        ],
      ),
    );
  }
}
