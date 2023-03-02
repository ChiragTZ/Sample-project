import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/videoPlayer/video_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:pod_player/pod_player.dart';

class VideoPage extends GetView<VideoController> {
  final VideoController controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: colorBlack,
          body: Stack(
            children: [
              controller.controller.value.isInitialised
                  ? PodVideoPlayer(controller: controller.controller.value)
                  : Container(),
              Positioned(
                  child: Padding(
                padding: mainPadding(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: colorWhite,
                        size: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.controller.value.toggleVolume();

                        controller.controller.refresh();
                      },
                      child: controller.controller.value.isMute
                          ? Icon(
                              Icons.volume_off,
                              color: colorWhite,
                              size: 25,
                            )
                          : Icon(
                              Icons.volume_up_outlined,
                              color: colorWhite,
                              size: 25,
                            ),
                    ),
                  ],
                ),
              )),
              if (controller.error.isNotEmpty)
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sorry",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colorWhite),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Because of its privacy settings, this video cannot be played here.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: colorWhite),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              if (controller.isLoading.value && controller.error.isEmpty)
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    //color: colorGrey.withAlpha(50),
                    child: CupertinoActivityIndicator(
                      radius: 18.0,
                      animating: true,
                      color: colorWhite,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
