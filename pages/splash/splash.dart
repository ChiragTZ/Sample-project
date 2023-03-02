import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iwl/controller/connectivity_controller.dart';
import 'package:iwl/pages/auth/model/user_response.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/AppGlobal.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/preference.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final ConnectivityController _networkManager =
      Get.find<ConnectivityController>();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    startTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Center(
        child: GetBuilder<ConnectivityController>(
          builder: (builder) => (_networkManager.connectionType == 0)
              ? SvgPicture.asset(
                  'assets/images/iwl_logo.svg',
                  width: 80.w,
                )
              : SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.horizontal,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/iwl_logo.svg',
                      width: 80.w,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  startTime(context) {
    Timer(const Duration(milliseconds: 2500), () async {
      // Get.to(
      //     InApp(userid: 1, bgImage: "", title: "", description: "description"));
      // return;
      if (_networkManager.connectionType != 0) {
        AppGlobal.isLogin = await PM.read(prefIsLogin, PrefEnum.BOOL);
        AppGlobal.iSFirstTime = await PM.read(preIsFirstTime, PrefEnum.BOOL);

        if (AppGlobal.isLogin) {
          AppGlobal.token = await PM.read(prefKeyToken, PrefEnum.STRING);
          var data1 = await PM.read(prefKeyUserModel, PrefEnum.MODEL);
          AppGlobal.userData = UserData.fromJson(data1);
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.INTRODUCTION);
        }
      } else {
        Get.snackbar("Error", "No Internet Found",
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}
