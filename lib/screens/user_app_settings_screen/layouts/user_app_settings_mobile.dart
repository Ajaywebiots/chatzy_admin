import 'package:chatzy_admin/screens/user_app_settings_screen/layouts/ad_show_hide.dart';

import '../../../config.dart';
import '../../../models/user_setting_model.dart';

class UserAppSettingsMobile extends StatelessWidget {
  final UserAppSettingModel? userAppSettingModel;

  const UserAppSettingsMobile({Key? key, this.userAppSettingModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAppSettingsController>(builder: (userSettingCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MobileSwitchCommon(
                    title: fonts.allowUserBlock,
                    value: userAppSettingModel!.allowUserBlock,

                    onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                        "allowUserBlock", val)),
                MobileSwitchCommon(
                    title: fonts.approvalNeeded,
                    value: userAppSettingModel!.approvalNeeded,
                    onChanged: (val)  => userSettingCtrl.commonSwitcherValueChange(
                        "approvalNeeded", val)),
                MobileSwitchCommon(
                    title: fonts.isMaintenanceMode,
                    value: userAppSettingModel!.isMaintenanceMode,
                    onChanged: (val) => userSettingCtrl.commonSwitcherValueChange(
                        "isMaintenanceMode", val)),
              ],
            ).paddingAll(Insets.i55).boxExtension().marginOnly(top: Insets.i15),
            CommonButton(
              title: fonts.adShowHide.tr.toUpperCase(),
              style: AppCss.muktaVaaniMedium12.textColor(appCtrl.appTheme.white),
              width: Sizes.s250,
              margin: Insets.i15,
            ),
          ],
        ),
        const VSpace(Sizes.s20),
        AdShowHide(userAppSettingModel: userSettingCtrl.usageCtrl),
        const VSpace(Sizes.s20),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.approvalMessage,
            controller: userSettingCtrl.approvalMessage),
        const VSpace(Sizes.s15),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.maintenanceMessage,
            controller: userSettingCtrl.maintenanceMessage),
        const VSpace(Sizes.s15),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.rateApp,
            controller: userSettingCtrl.txtRateApp),
        const VSpace(Sizes.s15),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.rateAppIos,
            controller: userSettingCtrl.txtRateAppIos),
        const VSpace(Sizes.s15),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.androidBannerId,
            controller: userSettingCtrl.txtAndroidBannerId),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.iosBannerId,
            controller: userSettingCtrl.txtIOSBannerId),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.facebookAndroidId,
            controller: userSettingCtrl.txtFBAndroidBannerId),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.facebookIosId,
            controller: userSettingCtrl.txtFBIOSBannerId),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.gifApi,
            controller: userSettingCtrl.txtGif),
        DesktopTextFieldCommon(
            width: Sizes.s400,
            isAppSettings: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.firebaseServerToken,
            controller: userSettingCtrl.txtFirebaseToken),
      ]).paddingAll(Insets.i15);
    });
  }
}
