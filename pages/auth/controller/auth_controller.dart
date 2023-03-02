import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/auth/model/user_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/controller/overview_controller.dart';
import 'package:iwl/rest_api/api_repository.dart';
import 'package:iwl/rest_api/api_utils.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/base_response.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/preference.dart';
import 'package:iwl/utils/routes/app_pages.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final recoveryFormKey = GlobalKey<FormBuilderState>();
  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserData? userData;

  Rx<Enum> status = Status.INITIAL.obs;

  RxBool isEditProfile = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = new TextEditingController();

  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController currentWeightController = TextEditingController();
  TextEditingController goalWeightController = TextEditingController();

  Rxn<int> selectedGender = Rxn<int>();
  Rxn<int> selectedAge = Rxn<int>();

  List<String> genderList = [
    "Male",
    "Female",
    "Intersex",
  ];
  List<String> ageList = [
    "20's",
    "30's",
    "40's",
    "50's",
    "60's",
    "70+",
  ];

  login() async {
    print('------------ ${DateTime.now().timeZoneName}');
    print('------------ ${DateTime.now().timeZoneOffset}');
    if (formKey.currentState!.validate()) {
      status.value = Status.LOADING;
      dynamic data = {
        "iwltoken": AppGlobal.getJTWToken(),
        "email": emailController.text.toString(),
        "password": passwordController.text.toString(),
        "timezone": AppGlobal.userTimezone,
      };
      BaseResponse? response;
      try {
        var res = await ApiRepo().login(data);
        response = BaseResponse.fromJson(res.data);
        if (response.status!) {
          userData = response.userData!;
          PM.write(prefIsLogin, true);
          PM.write(prefKeyToken, userData!.token!);
          PM.write(prefKeyUserModel, userData!);
          AppGlobal.isLogin = await PM.read(prefIsLogin, PrefEnum.BOOL);
          AppGlobal.token = await PM.read(prefKeyToken, PrefEnum.STRING);
          // AppGlobal.iSFirstTime = await PM.read(preIsFirstTime, PrefEnum.BOOL);
          AppGlobal.iSFirstTime = await PM.read(preIsFirstTime, PrefEnum.BOOL);
          var data1 = await PM.read(prefKeyUserModel, PrefEnum.MODEL);
          AppGlobal.userData = UserData.fromJson(data1);
          ApiUtils();
          Get.offAllNamed(Routes.HOME);
          // showSnackBar(StatusEnum.SUCCESS,
          //     title: "Success", desc: response.message);
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

  updateProfile() async {
    if (firstNameController.text.trim().isEmpty) {
      showSnackBar(StatusEnum.ERROR,
          title: "Error", desc: "Please enter fist name");
      return;
    } else if (lastNameController.text.trim().isEmpty) {
      showSnackBar(StatusEnum.ERROR,
          title: "Error", desc: "Please enter last name");
      return;
    } else if (heightController.text.trim().isEmpty) {
      showSnackBar(StatusEnum.ERROR,
          title: "Error", desc: "Please enter height");
      return;
    } else if (ageController.text.trim().isEmpty) {
      showSnackBar(StatusEnum.ERROR, title: "Error", desc: "Please enter age");
    } else {
      status.value = Status.LOADING;
      dynamic data = {
        "fname": firstNameController.text.toString(),
        "lname": lastNameController.text.toString(),
        "bio": bioController.text.toString(),
        "gender": selectedGender.toString(),
        "age": ageController.text.toString(),
        "height": heightController.text.toString(),
      };
      BaseResponse? response;
      try {
        var res = await ApiRepo().updateProfile(data);
        response = BaseResponse.fromJson(res.data);
        if (response.status!) {
          OverviewController overviewController = Get.find();
          await overviewController.getUserDetail();
          isEditProfile.value = false;
          showSnackBar(StatusEnum.SUCCESS,
              title: "Success", desc: response.message);
          status.value = Status.SUCCESS;
        } else {
          status.value = Status.ERROR;
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

  @override
  void onInit() {
    super.onInit();
    if (AppGlobal.isLogin) {
      UserData data = AppGlobal.userData!;
      if (data.firstname != null) {
        firstNameController.text = data.firstname.toString();
      }
      if (data.lastname != null) {
        lastNameController.text = data.lastname.toString();
      }
      if (data.bio != null) {
        bioController.text = data.bio.toString();
      }
      if (data.height != null) {
        heightController.text = data.height.toString();
      }
      if (data.age != null) {
        ageController.text = data.age.toString();
      }
      selectedGender.value = data.gender!;
      // selectedAge.value = data.age;
      if (data.currentWeight != null) {
        currentWeightController.text = data.currentWeight.toString();
      }
      if (data.goalWeight != null) {
        goalWeightController.text = data.goalWeight.toString();
      }
    }
  }
}
