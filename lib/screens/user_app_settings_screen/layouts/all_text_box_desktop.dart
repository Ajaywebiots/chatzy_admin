import '../../../config.dart';

class AllTextBoxDesktop extends StatelessWidget {
  const AllTextBoxDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAppSettingsController>(builder: (settingCtrl) {
      return Stack(
        children: [
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().statusValidation(number),
                          title: fonts.rateApp,
                          controller: settingCtrl.txtRateApp),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().statusValidation(number),
                          title: fonts.rateAppIos,
                          controller: settingCtrl.txtRateAppIos),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().statusValidation(number),
                          title: fonts.androidBannerId,
                          controller: settingCtrl.txtAndroidBannerId),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().statusValidation(number),
                          title: fonts.facebookAndroidId,
                          controller: settingCtrl.txtFBAndroidBannerId),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().statusValidation(number),
                          title: fonts.gifApi,
                          controller: settingCtrl.txtGif),
                      const VSpace(Sizes.s30),
                    ],
                  ).marginOnly(top: Insets.i15),
                ),
                const HSpace(Sizes.s30),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().broadCastValidation(number),
                          title: fonts.approvalMessage,
                          controller: settingCtrl.approvalMessage),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().broadCastValidation(number),
                          title: fonts.maintenanceMessage,
                          controller: settingCtrl.maintenanceMessage),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().broadCastValidation(number),
                          title: fonts.iosBannerId,
                          controller: settingCtrl.txtIOSBannerId),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          validator: (number) =>
                              Validation().statusValidation(number),
                          title: fonts.facebookIosId,
                          controller: settingCtrl.txtFBIOSBannerId),
                      const VSpace(Sizes.s30),
                          DesktopTextFieldCommon(
                              validator: (number) =>
                                  Validation().statusValidation(number),
                              title: fonts.firebaseServerToken,
                              controller: settingCtrl.txtFirebaseToken),
                          const VSpace(Sizes.s30),
                    ]).marginOnly(top: Insets.i15)),
              ],
            ).paddingAll(Insets.i30),
          ).boxExtension().marginOnly(top: Insets.i15),
          CommonButton(
            title: fonts.credential.tr,
            style: AppCss.muktaVaaniMedium12.textColor(appCtrl.appTheme.white),
            width: Sizes.s250,
            margin: Insets.i15,
          ),
        ],
      );
    });
  }
}
