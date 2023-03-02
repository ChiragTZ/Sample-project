import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/Constants.dart';
import 'package:iwl/utils/Enum.dart';

showSnackBar(StatusEnum type,
    {String? title, String? desc, bool? isShowIcon = true}) {
  // Get.snackbar(title ?? "", desc??"",
  //     colorText: colorWhite,
  //     backgroundColor: getColor(type),
  //     // icon: isShowIcon! ? getIcon(type) : null,
  //     icon: null,
  //     shouldIconPulse: false);
  Get.rawSnackbar(
      message: desc,
      snackPosition: SnackPosition.TOP,
      backgroundColor: getColor(type),
      borderRadius: 8,
      margin: EdgeInsets.all(10),
      icon: getIcon(type),
      shouldIconPulse: false);
}

getIcon(type) {
  switch (type) {
    case StatusEnum.SUCCESS:
      return Icon(Icons.check_circle, color: colorWhite);
    case StatusEnum.ERROR:
      return Icon(Icons.error, color: colorWhite);
    case StatusEnum.WARNING:
      return Icon(Icons.warning, color: colorWhite);
    case StatusEnum.INFO:
      return Icon(Icons.info, color: colorWhite);
    default:
      return null;
  }
}

getColor(type) {
  switch (type) {
    case StatusEnum.SUCCESS:
      return colorGreen;
    case StatusEnum.ERROR:
      return colorError;
    case StatusEnum.WARNING:
      return colorProgress;
    case StatusEnum.INFO:
      return colorBlue;
    default:
      return colorGrey;
  }
}

getColorProgressOuter(int i) {
  switch (i + 1) {
    case 1:
      return colorProgressBronze;
    case 2:
      return colorProgressSilver;
    case 3:
      return colorProgressGold;
    default:
      return colorError;
  }
}

getColorProgressInner(int i) {
  switch (i + 1) {
    case 1:
      return colorBack;
    case 2:
      return colorProgressGoldBack;
    case 3:
      return colorBack;
    default:
      return colorError;
  }
}

showLoader({required Widget child, required bool isLoading}) {
  return Stack(children: [
    child,
    if (isLoading)
      Positioned.fill(
        child: Container(
          alignment: Alignment.center,
          //color: colorGrey.withAlpha(50),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorCustomizeGrey,
            ),
            child: CupertinoActivityIndicator(
              radius: 18.0,
              animating: true,
            ),
          ),
        ),
      ),
  ]);
}

EdgeInsets mainPadding() {
  return EdgeInsets.only(left: 20, right: 20);
}

Widget getFieldSeparator({double? height}) {
  return SizedBox(height: height ?? 20);
}

Widget getDivider(
    {double? height, double? thickness, double? space, Color? color}) {
  return Divider(
    height: height ?? 1,
    color: color ?? colorGrey,
    thickness: thickness ?? 0,
    indent: space ?? 0,
  );
}

Widget noDataFound() {
  return Center(
    child: Container(
      padding: EdgeInsets.all(10),
      child: Text(
        "No Data Found",
        style: TextStyle(
            color: colorGreyText, fontFamily: SFProSemiBold, fontSize: 14),
      ),
    ),
  );
}

// This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
showActionDialog(BuildContext context,
    {String? title,
    String? desc,
    String? positiveButton,
    String? negativeButton,
    Function? functionCallBack}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      message: desc != null
          ? Text(
              desc,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 13, color: colorNeutral80),
            )
          : null,
      title: title != null
          ? Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
      cancelButton: CupertinoActionSheetAction(
        child: Text(negativeButton ?? 'Cancel',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: colorSecondary)),
        isDefaultAction: true,
        onPressed: () {
          Get.back();
        },
      ),
      actions: <CupertinoActionSheetAction>[
        // CupertinoActionSheetAction(
        //   /// This parameter indicates the action would be a default
        //   /// defualt behavior, turns the action's text to bold text.
        //   isDefaultAction: true,
        //   onPressed: () {
        //    Get.back();
        //   },
        //   child: const Text('Default Action'),
        // ),
        CupertinoActionSheetAction(
          onPressed: () {
            Get.back();
            if (functionCallBack != null) {
              functionCallBack(true);
            }
          },
          child: Text(
            positiveButton ?? 'Delete',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: colorError),
          ),
        ),
      ],
    ),
  );
}
