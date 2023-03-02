import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/preference.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart' as urlLaunch;

import '../pages/auth/model/user_response.dart';
import '../pages/introduction/model/common_response.dart';

class AppGlobal {
  static bool isInternet = false;
  static bool isLogin = false;
  static bool iSFirstTime = false;
  static String token = "";
  static UserData? userData;
  static String? userTimezone;
  static String? localPath;
  static bool? permissionReady;
  static TargetPlatform? platform;
  static Signup? commonSignup;

  static bool isWeekStart = true;

  static final GlobalKey one = GlobalKey();
  static final GlobalKey two = GlobalKey();
  static final GlobalKey three = GlobalKey();
  static final GlobalKey four = GlobalKey();
  static final GlobalKey five = GlobalKey();
  static final GlobalKey six = GlobalKey();
  static final GlobalKey seven = GlobalKey();

  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  static appLogout() {
    PM.write(prefIsLogin, false);
    PM.write(prefKeyToken, "");
    PM.write(prefKeyUserModel, UserData());
    AppGlobal.isLogin = false;
    AppGlobal.token = "";
    AppGlobal.userData = UserData();
    Get.offAllNamed(Routes.INTRODUCTION);
  }

  static Future<void> launchUrl(url) async {
    if (!await urlLaunch.launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static Future<bool> checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  static Future<void> prepareSaveDir() async {
    localPath = (await findLocalPath())!;

    print(localPath);
    final savedDir = Directory(localPath! + "iwl/");
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create(recursive: true);
      print("path not exist");
      localPath = localPath! + "iwl/";
    } else {
      localPath = localPath! + "iwl/";
      print("exist");
    }
  }

  static Future<String?> findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      print(directory.path);
      return directory.path + Platform.pathSeparator;
    }
  }

  static String getJTWToken() {
    final claimSet = JwtClaim(
        expiry: DateTime.now().add(Duration(hours: 2)),
        otherClaims: <String, dynamic>{"alg": "HS256", "typ": "JWT"});
    final token = issueJwtHS256(claimSet, sharedSecret);
    print('JWT: "$token"\n');
    return token;
  }

  static bool checkDayStart(String date) {
    DateTime startDate = DateTime.parse(date).toLocal();
    print('================ $startDate');
    if (startDate.compareTo(DateTime.parse(apiFormat.format(DateTime.now()))) ==
            0 ||
        startDate.compareTo(DateTime.parse(apiFormat.format(DateTime.now()))) <
            0) {
      return true;
    } else {
      print("DT1 is after DT2 ${DateTime.now()} start date :$startDate");
      return false;
    }
  }
}
