import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iwl/rest_api/api_repository.dart';
import 'package:iwl/rest_api/api_utils.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/base_response.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';

class ForgetController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  FocusNode recoveryEmailFocus = new FocusNode();

  TextEditingController recoveryEmailController = TextEditingController();

  Rx<Enum> status = Status.INITIAL.obs;

  requestResetPassword() async {
    if (formKey.currentState!.validate()) {
      status.value = Status.LOADING;
      dynamic data = {
        "iwltoken": AppGlobal.getJTWToken(),
        "email": recoveryEmailController.text.toString(),
      };
      BaseResponse? response;
      try {
        var res = await ApiRepo().requestResetPassword(data);
        response = BaseResponse.fromJson(res.data);
        if (response.status!) {
          Get.offAndToNamed(Routes.OTP,
              arguments: {"email": recoveryEmailController.text.toString()});
          showSnackBar(StatusEnum.SUCCESS,
              title: "Success", desc: response.message);
        } else {
          showSnackBar(StatusEnum.ERROR,
              title: "Error", desc: response.message);
        }
        status.value = Status.SUCCESS;
      } catch (error) {
        status.value = Status.ERROR;
        return apiUtils.handleError(error);
      }
    }
  }

  requestResetAgain() async {
    status.value = Status.LOADING;
    dynamic data = {
      "iwltoken": AppGlobal.getJTWToken(),
      "email": Get.arguments['email'],
    };
    BaseResponse? response;
    try {
      var res = await ApiRepo().requestResetPassword(data);
      response = BaseResponse.fromJson(res.data);
      if (response.status!) {
        showSnackBar(StatusEnum.SUCCESS,
            title: "Success", desc: response.message);
      } else {
        showSnackBar(StatusEnum.ERROR, title: "Error", desc: response.message);
      }
      status.value = Status.SUCCESS;
    } catch (error) {
      status.value = Status.ERROR;
      return apiUtils.handleError(error);
    }
  }
}
