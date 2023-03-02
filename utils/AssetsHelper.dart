import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetsHelper {
  static AssetImage getIcon(String name) {
    return AssetImage("assets/icons/" + name);
  }

  static SvgPicture getSvgIcon(String name, {double? height, double? width}) {
    return SvgPicture.asset(
      "assets/icons/" + name,
      height: height,
      width: width,
    );
  }

  static AssetImage getImage(String name) {
    return AssetImage("assets/images/" + name);
  }
}
