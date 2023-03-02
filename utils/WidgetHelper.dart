import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/home/home_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:sizer/sizer.dart';

import 'AssetsHelper.dart';

class WidgetHelper {
  static AppBar getHeader(
    BuildContext context,
    String title, {
    GlobalKey<ScaffoldState>? key,
    bool? showBackIcon,
    bool? showSearchIcon,
    Function? onSearchClick,
    Function? onSearchTextChange,
    bool? showEditTextIcon,
    Function? onEditTextClick,
    bool? showSaveTextIcon,
    Function? onSaveTextClick,
    bool? showNotificationIcon,
    Function? onNotificationClick,
    bool? showBookmarkIcon,
    bool? isBookmarkFill,
    Function? onBookMarkClick,
    bool? showDownloadIcon,
    Function? onDownloadClick,
    Function? onBackClick,
  }) {
    bool showBack = showBackIcon ?? true;
    bool showSearch = showSearchIcon ?? false;
    bool showNotification = showNotificationIcon ?? false;
    bool showEditText = showEditTextIcon ?? false;
    bool showSaveText = showSaveTextIcon ?? false;
    bool showBookmark = showBookmarkIcon ?? false;
    bool showBookmarkFill = isBookmarkFill ?? false;
    bool showDownload = showDownloadIcon ?? false;
    HomeController? homeController;
    try {
      homeController = Get.find();
    } catch (e) {}

    return AppBar(
      title: homeController != null
          ? Obx(() => Text(
                homeController!.isShow.value
                    ? title
                    : title.isNotEmpty
                        ? title
                        : "",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 19, color: colorDarkText),
              ))
          : Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 19, color: colorDarkText),
            ),
      centerTitle: true,
      titleSpacing: showBack ? 0 : 10,
      backgroundColor: Colors.white,
      leading: showBack
          ? InkWell(
              onTap: () {
                if (onBackClick != null) {
                  onBackClick();
                } else {
                  Get.back();
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
                child: AssetsHelper.getSvgIcon("back.svg"),
              ),
            )
          : InkWell(
              onTap: () {
                key!.currentState!.openDrawer();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: AssetsHelper.getSvgIcon("menu.svg"),
              ),
            ),
      actions: [
        Visibility(
          visible: showEditText,
          child: InkWell(
            onTap: () {
              if (onEditTextClick != null) {
                onEditTextClick();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      tr("weight.edit"),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: colorSecondary),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showSaveText,
          child: InkWell(
            onTap: () {
              if (onSaveTextClick != null) {
                onSaveTextClick();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      tr("weight.save"),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: colorSecondary),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showBookmark,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                icon: showBookmarkFill
                    ? AssetsHelper.getSvgIcon("bookmark_fill.svg",
                        height: 20, width: 20)
                    : AssetsHelper.getSvgIcon("bookmark.svg",
                        height: 20, width: 20),
                onPressed: () {
                  if (onBookMarkClick != null) onBookMarkClick();
                },
              ),
              SizedBox(
                width: 0,
              ),
            ],
          ),
        ),
        Visibility(
          visible: showDownload,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                icon: AssetsHelper.getSvgIcon("download.svg"),
                onPressed: () {
                  if (onDownloadClick != null) onDownloadClick();
                },
              ),
              SizedBox(
                width: 0,
              ),
            ],
          ),
        ),
        Visibility(
          visible: showSearch,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                icon: AssetsHelper.getSvgIcon("search.svg"),
                onPressed: () {
                  if (onSearchClick != null) onSearchClick();
                },
              ),
              SizedBox(
                width: 0,
              ),
            ],
          ),
        ),
        Visibility(
          visible: showNotification,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                icon: AssetsHelper.getSvgIcon("bell.svg"),
                onPressed: () {
                  if (onNotificationClick != null) onNotificationClick();
                },
              ),
              SizedBox(
                width: 0,
              ),
            ],
          ),
        ),
      ],
      automaticallyImplyLeading: false,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  static AppBar getSearchHeader(
    BuildContext context,
    String title, {
    GlobalKey<ScaffoldState>? key,
    bool? showBackIcon,
    bool? showSearchIcon,
    Function? onSearchClick,
    Function? onSearchTextChange,
    bool? showCalendarIcon,
    Function? onCalendarClick,
    bool? showNotificationIcon,
    Function? onNotificationClick,
  }) {
    bool showBack = showBackIcon ?? true;
    bool showSearch = showSearchIcon ?? false;
    bool showNotification = showNotificationIcon ?? false;

    return AppBar(
      title: Container(
        height: 40,
        width: 100.w,
        margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: CupertinoSearchTextField(
                //controller: searchController,
                placeholder: 'Search',
                prefixIcon: Container(),
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      centerTitle: true,
      titleSpacing: showBack ? 0 : 10,
      backgroundColor: Colors.white,
      leading: showBack
          ? InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
                child: AssetsHelper.getSvgIcon("back.svg"),
              ),
            )
          : null,
      //leading: null,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      actions: [
        Visibility(
          visible: showSearch,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                icon: AssetsHelper.getSvgIcon("search.svg"),
                onPressed: () {
                  if (onSearchClick != null) onSearchClick();
                },
              ),
              SizedBox(
                width: 0,
              ),
            ],
          ),
        ),
        Visibility(
          visible: showNotification,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                icon: AssetsHelper.getSvgIcon("bell.svg"),
                onPressed: () {
                  if (onNotificationClick != null) onNotificationClick();
                },
              ),
              SizedBox(
                width: 0,
              ),
            ],
          ),
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  static void showIOSBottomPicker(
      BuildContext context, List<String> genderList, Function callBack,
      {int? selected}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            child: CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  callBack(index);
                },
                scrollController:
                    FixedExtentScrollController(initialItem: selected ?? 0),
                children:
                    new List<Widget>.generate(genderList.length, (int index) {
                  return new Center(
                    child: new Text(genderList[index]),
                  );
                })),
          );
        });
  }
}
