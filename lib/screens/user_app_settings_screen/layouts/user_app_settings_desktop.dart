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
          DesktopSwitchCommon(
              title: fonts.allowUserBlock,
              value: userAppSettingModel!.allowUserBlock,
              onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                  "allowUserBlock", val)),
          DesktopSwitchCommon(
              title: fonts.approvalNeeded,
              value: userAppSettingModel!.approvalNeeded,
              onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                  "approvalNeeded", val)),
          DesktopSwitchCommon(
              isDivider: true,
              title: fonts.isMaintenanceMode,
              value: userAppSettingModel!.isMaintenanceMode,
              onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                  "isMaintenanceMode", val))
        ]).marginOnly(bottom: Insets.i15).boxExtension().marginOnly(top: Insets.i15),

      ]);
    });
  }
}
