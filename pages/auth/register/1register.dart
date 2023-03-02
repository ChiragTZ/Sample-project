import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/controller/register_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/ValidationHelper.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/outLineBorderTextFormField.dart';
import 'package:iwl/utils/routes/app_pages.dart';

class RegisterPage extends GetView<RegisterController> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetHelper.getHeader(context, ""),
      body: SingleChildScrollView(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                  child: RichText(
                    text: TextSpan(
                      text: tr('sign_up.agree'),
                      style: textTheme.bodyText2,
                      children: <TextSpan>[
                        TextSpan(
                            text: tr('sign_up.terms'),
                            style: textTheme.bodyText2!
                                .copyWith(color: colorSecondary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppGlobal.launchUrl(TERMS_OF_SERVICE_URL);
                              }),
                        TextSpan(
                          text: tr('sign_up.and'),
                          style: textTheme.bodyText2,
                        ),
                        TextSpan(
                            text: tr('sign_up.policy'),
                            style: textTheme.bodyText2!
                                .copyWith(color: colorSecondary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppGlobal.launchUrl(PRIVACY_POLICY_URL);
                              }),
                      ],
                    ),
                  ),
                ),
                getFieldSeparator(height: 30),
                Center(
                  child: ButtonView(
                    text: tr("sign_up.sign_up"),
                    onPressed: () {
                      Get.toNamed(Routes.GOOD_HANDS);
                    },
                  ),
                ),
                getFieldSeparator(height: 20),
              ],
            ),
          )),
    );
  }

  heading(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getFieldSeparator(height: 20),
        Text(
          'sign_up.create_account',
          style: textTheme.headline5,
        ).tr(),
        SizedBox(height: 10),
        Text(
          'sign_up.free_trial',
          style: textTheme.bodyText1!.copyWith(color: colorNeutral90),
        ).tr(),
      ],
    );
  }

  form(TextTheme textTheme, BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          OutlineBorderTextFormField(
            labelText: tr("sign_up.first_name"),
            myFocusNode: controller.fNameFocus,
            tempTextEditingController: controller.fNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autofocus: false,
            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(18),
            ],
            onSubmit: () {
              FocusScope.of(context).requestFocus(controller.lNameFocus);
            },
            validation: (value) =>
                ValidationHelper.checkBlankValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
          getFieldSeparator(height: 10),
          OutlineBorderTextFormField(
            labelText: tr("sign_up.last_name"),
            myFocusNode: controller.lNameFocus,
            tempTextEditingController: controller.lNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autofocus: false,

            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(18),
            ],
            onSubmit: () {
              FocusScope.of(context).requestFocus(controller.emailFocus);
            },
            validation: (value) =>
                ValidationHelper.checkBlankValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
          getFieldSeparator(height: 10),
          OutlineBorderTextFormField(
            labelText: tr("login.email"),
            myFocusNode: controller.emailFocus,
            tempTextEditingController: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: false,
            autofillHints: [
              AutofillHints.email,
            ],
            onSubmit: () {
              FocusScope.of(context).requestFocus(controller.passwordFocus);
            },
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
          getFieldSeparator(height: 10),
          OutlineBorderTextFormField(
            labelText: tr("login.password"),
            myFocusNode: controller.passwordFocus,
            tempTextEditingController: controller.passwordController,
            keyboardType: TextInputType.text,
            maxLine: 1,
            textInputAction: TextInputAction.done,
            autofocus: false,
            checkOfErrorOnFocusChange: true,
            obscureText: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(6),
            ],
            validation: (value) =>
                ValidationHelper.checkPasswordValidation(context, value!),
          ),
        ],
      ),
    );
  }
}
