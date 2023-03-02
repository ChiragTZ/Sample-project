import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:iwl/utils/Regex.dart';

class ValidationHelper {
  static checkEmailValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return tr("validation.canNotEmpty");
    } else if (value.isNotEmpty && !Regex.email.hasMatch(value)) {
      return tr("validation.emailValidValidation");
    } else {
      return null;
    }
  }

  static checkMobileNoValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return tr("mobNoValidation");
    } else if (value.length < 7 || value.length > 15) {
      return tr("mobNoValidValidation");
    } else {
      return null;
    }
  }

  static checkBlankValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return tr("validation.canNotEmpty");
    } else {
      return null;
    }
  }

  static checkPasswordValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return tr("validation.canNotEmpty");
    } else if (value.toString().trim().length < 5) {
      return tr("validation.passwordMinimumValidation");
    } else {
      return null;
    }
  }

  static checkConfirmPasswordValidation(
      BuildContext context, String value, String passwordMatch) {
    if (value.isEmpty) {
      return tr("validation.canNotEmpty");
    } else if (value.isNotEmpty && value != passwordMatch) {
      return tr("validation.retypeNewPasswordMatchValidation");
    } else {
      return null;
    }
  }

  /*
  *
  *  static checkBlankValidation() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "Field can't be empty"),
    ]);
  }

  static checkEmailValidation() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "Field can't be empty"),
      FormBuilderValidators.email(errorText: "Enter valid email"),
    ]);
  }

  static checkPasswordValidation() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "emailValidation"),
      FormBuilderValidators.email(errorText: "emailValidation1"),
    ]);
  }

  static checkConfirmPasswordValidation() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "emailValidation"),
      FormBuilderValidators.email(errorText: "emailValidation1"),
    ]);
  }*/
}
