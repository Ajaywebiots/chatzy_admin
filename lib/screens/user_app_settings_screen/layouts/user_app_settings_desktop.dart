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
        ]).paddingAll(Insets.i55).boxExtension().marginOnly(top: Insets.i15),
        CommonButton(
          title: fonts.adShowHide.tr.toUpperCase(),
          style: AppCss.muktaVaaniMedium12.textColor(appCtrl.appTheme.white),
          width: Sizes.s250,
          margin: Insets.i15,
        ),
      ]);
    });
  }
}
