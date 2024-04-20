import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../config.dart';
import '../../../models/user_setting_model.dart';

class UserAppSettingsDesktop extends StatelessWidget {
  final UserAppSettingModel? userAppSettingModel;

  const UserAppSettingsDesktop({Key? key, this.userAppSettingModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAppSettingsController>(builder: (userSettingCtrl) {
      log(" userAppSettingModel!.isSubscription :${ userAppSettingModel!.isSubscription}");
      log(" userAppSettingModel!.isSubscription :${ userAppSettingModel!.isSubscription}");
      return Stack(children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SmoothContainer(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal:Insets.i25,vertical: Insets.i20),
            padding: const EdgeInsets.symmetric(vertical: Insets.i15,horizontal: Insets.i20),
            color: appCtrl.appTheme.primary.withOpacity(.08),
            smoothness: 1,
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                Icon(Icons.circle,color: appCtrl.appTheme.primary,size: Sizes.s10,),
                const HSpace(Sizes.s15),
                Text(
                  fonts.usageControl.tr,
                  style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: appCtrl.appTheme.primary),
                ),
              ],
            ),
          ),

          IntrinsicHeight(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(

                          children: [
                            DesktopSwitchCommon(
                                isDivider: true,
                                title: fonts.allowUserBlock,
                                value: userAppSettingModel!.allowUserBlock,
                                onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                                    "allowUserBlock", val)),
                            const VSpace(Sizes.s60),
                            DesktopSwitchCommon(
                                isDivider: true,
                                title: fonts.approvalNeeded,
                                value: userAppSettingModel!.approvalNeeded,
                                onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                                    "approvalNeeded", val))
                          ]),
                    ),
                    Image.asset(imageAssets.line,height: Sizes.s140,fit: BoxFit.fill,)
                        .paddingSymmetric(horizontal: Insets.i30),
                    Expanded(
                      child: Column(

                          children: [
                            DesktopSwitchCommon(
                                isDivider: true,
                                title: fonts.isMaintenanceMode,
                                value: userAppSettingModel!.isMaintenanceMode,
                                onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                                    "isMaintenanceMode", val)),
                            const VSpace(Sizes.s60),
                            DesktopSwitchCommon(
                                isDivider: true,
                                title: fonts.isSubscription,
                                value: userAppSettingModel!.isSubscription,
                                onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                                    "isMaintenanceMode", val))
                          ])
                    ),

                  ]).marginSymmetric(horizontal: Insets.i20))


         /* DesktopSwitchCommon(
            isDivider: true,
              title: fonts.allowUserBlock,
              value: userAppSettingModel!.allowUserBlock,
              onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                  "allowUserBlock", val)).paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s20),
          DesktopSwitchCommon(
              isDivider: true,
              title: fonts.approvalNeeded,
              value: userAppSettingModel!.approvalNeeded,
              onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                  "approvalNeeded", val)).paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s20),
          DesktopSwitchCommon(
              isDivider: true,
              title: fonts.isMaintenanceMode,
              value: userAppSettingModel!.isMaintenanceMode,
              onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                  "isMaintenanceMode", val)).paddingSymmetric(horizontal: Insets.i20)*/
        ]).marginOnly(bottom: Insets.i15,).boxExtension().marginOnly(top: Insets.i15),

      ]);
    });
  }
}
