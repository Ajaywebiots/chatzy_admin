import 'dart:developer';


import 'package:chatzy_admin/models/user_setting_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../config.dart';

class AdShowHide extends StatelessWidget {
  final UserAppSettingModel? userAppSettingModel;

  const AdShowHide({Key? key, this.userAppSettingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAppSettingsController>(builder: (settingCtrl) {
      settingCtrl.isGoogleAd == "google"
          ? userAppSettingModel!.isFacebookAdEnable = false
          : userAppSettingModel!.isFacebookAdEnable = true;
      return Stack(
        children: [
          SizedBox(
            child: Column(
              children: [
                SmoothContainer(
                  width: MediaQuery.of(context).size.width,
                  //margin: const EdgeInsets.symmetric(horizontal: Insets.i20),
                  padding: const EdgeInsets.symmetric(vertical: Insets.i15,horizontal: Insets.i20),
                  color: appCtrl.appTheme.primary.withOpacity(.08),
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(6),
                  child: Row(
                    children: [
                      Icon(Icons.circle,color: appCtrl.appTheme.primary,size: Sizes.s10,),
                      const HSpace(Sizes.s15),
                      Text(
                        fonts.adShowHide.tr,
                        style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: appCtrl.appTheme.primary),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DesktopSwitchCommon(
                              title: fonts.isAddEnable,
                              value: userAppSettingModel!.isAdmobEnable,
                              onChanged: (val) => settingCtrl
                                  .commonSwitcherValueChange("isAdmobEnable", val)),

                          if (userAppSettingModel!.isAdmobEnable!)
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(fonts.googleAdmobEnable.tr,style: AppCss.manropeMedium14
                                        .textColor(appCtrl.isTheme ?appCtrl.appTheme.white :appCtrl.appTheme.dark)),
                                    leading: Radio(
                                      value: "google",
                                      groupValue: settingCtrl.isGoogleAd,
                                      onChanged: (value) {
                                        settingCtrl.isGoogleAd = value!;
                                        log("settingCtrl.isGoogleAd  : ${settingCtrl.isGoogleAd}");
                                        if (settingCtrl.isGoogleAd == "google") {
                                          userAppSettingModel!.isGoogleAdEnable = true;
                                          userAppSettingModel!.isFacebookAdEnable = false;
                                        } else {
                                          userAppSettingModel!.isGoogleAdEnable = false;
                                          userAppSettingModel!.isFacebookAdEnable = true;
                                        }
                                        settingCtrl.update();
                                        settingCtrl.commonSwitcherValueChange(
                                            "isGoogleAdmobEnable",
                                            userAppSettingModel!.isGoogleAdEnable);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                      title: Text(fonts.facebookAdmobEnable.tr,style: AppCss.manropeMedium14
                                          .textColor(appCtrl.isTheme ?appCtrl.appTheme.white :appCtrl.appTheme.dark)),
                                      leading: Radio(
                                          value: "facebook",
                                          groupValue: settingCtrl.isGoogleAd,
                                          onChanged: (value) {
                                            settingCtrl.isGoogleAd = value!;
                                            log("settingCtrl.isGoogleAd  : ${settingCtrl.isGoogleAd}");
                                            if (settingCtrl.isGoogleAd ==
                                                "facebook") {
                                              userAppSettingModel!.isGoogleAdEnable =
                                                  false;
                                              userAppSettingModel!.isFacebookAdEnable =
                                                  true;
                                            } else {
                                              userAppSettingModel!.isGoogleAdEnable =
                                                  true;
                                              userAppSettingModel!.isFacebookAdEnable =
                                                  false;
                                            }
                                            settingCtrl.update();
                                            settingCtrl.commonSwitcherValueChange(
                                                "isGoogleAdmobEnable",
                                                userAppSettingModel!.isGoogleAdEnable);
                                          })),
                                )
                              ],
                            )
                        ],
                      ).marginOnly(top: Insets.i15),
                    ),
                  ],
                )
              ],
            ).paddingAll(Insets.i30),
          ).boxExtension().marginOnly(top: Insets.i15),
          /*CommonButton(
            title: fonts.adShowHide.tr.toUpperCase(),
            style: AppCss.manropeMedium12.textColor(appCtrl.appTheme.white),
            width: Sizes.s250,
            margin: Insets.i15,
          ),*/
        ],
      );
    });
  }
}
