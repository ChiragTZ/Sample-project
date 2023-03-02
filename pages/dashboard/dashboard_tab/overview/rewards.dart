import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/controller/overview_controller.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/Enum.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/routes/app_pages.dart';
import 'package:iwl/widgets/decoration/boxDecoration.dart';
import 'package:sizer/sizer.dart';

class RewardsPage extends GetView<OverviewController> {
  final OverviewController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetHelper.getHeader(context, tr("rewards.rewards")),
      body: Obx(
        () => showLoader(
          isLoading: controller.status.value == Status.LOADING,
          child: controller.rewards.value.tier != null
              ? ListView.builder(
                  itemCount: controller.rewards.value.tier!.length,
                  padding: mainPadding(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100.w,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 20),
                      decoration: boxDecorationDashboard(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 130,
                            width: 100,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            decoration: boxDecorationDashboard().copyWith(
                                color: index != 0
                                    ? index != 1
                                        ? colorGold
                                        : colorSilver
                                    : colorBronze,
                                borderRadius: BorderRadius.circular(20)),
                            child: SvgPicture.asset(
                              index != 0
                                  ? index != 1
                                      ? "assets/icons/gold.svg"
                                      : "assets/icons/silver.svg"
                                  : "assets/icons/bronz_batch.svg",
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.listRewards[index].title!,
                                  style: textTheme.subtitle1,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  controller.listRewards[index].desc!,
                                  style: textTheme.bodyText2!
                                      .copyWith(color: colorNeutral90),
                                  textAlign: TextAlign.start,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (controller
                                            .listRewards[index].isClaim! &&
                                        !controller
                                            .listRewards[index].isClaimed!) {
                                      controller.clickedReward.value =
                                          controller.listRewards[index];
                                      Get.toNamed(Routes.CLAIM_REWARD);
                                    }
                                  },
                                  child: getButton(
                                      controller.listRewards[index], textTheme),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(),
        ),
      ),
    );
  }

  getButton(RewardsModel reward, TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(top: 2.w),
      decoration: BoxDecoration(
          color: reward.isClaim! || reward.isClaimed!
              ? colorPrimary
              : colorNeutral20,
          borderRadius: BorderRadius.circular(50)),
      child: Text(
        reward.isClaim! && !reward.isClaimed!
            ? tr("rewards.claim_prize")
            : reward.isClaimed!
                ? tr("rewards.claimed")
                : tr("rewards.unlock_at") + ' ${reward.pts}',
        style: textTheme.bodyText1!.copyWith(
            fontSize: 15,
            color: reward.isClaim! || reward.isClaimed!
                ? colorBlack
                : colorNeutral70),
        textAlign: TextAlign.start,
      ),
    );
  }
}
