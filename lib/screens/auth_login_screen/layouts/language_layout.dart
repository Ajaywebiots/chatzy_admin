import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class LanguageLayout extends StatelessWidget {
  const LanguageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
            padding: EdgeInsets.zero,
            color: appCtrl.appTheme.whiteColor,
            position: PopupMenuPosition.under,
            tooltip: fonts.showLanguage.tr,
            child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minWidth: Sizes.s48),
                child: Row(children: [
                  SvgPicture.asset(svgAssets.languages, height: Sizes.s25),
                  Visibility(
                      visible: (MediaQuery.of(context).size.width > Sizes.s768),
                      child: Text(fonts.selectLanguage.tr,
                              style: AppCss.manropeMedium14
                                  .textColor(appCtrl.appTheme.blackColor))
                          .paddingSymmetric(horizontal: Insets.i16 * 0.5)),
                  Icon(CupertinoIcons.chevron_down,
                      color: appCtrl.appTheme.blackColor,size: Sizes.s15,)
                ]).paddingSymmetric(horizontal: Insets.i10)),
            itemBuilder: (context) {
              return [
                ...appArray.actionList
                    .asMap()
                    .entries
                    .map((e) => PopupMenuItem<int>(
                        value: 0,
                        onTap: () {
                          if (e.value['title'] == "english" ||
                              e.value['title'] == 'अंग्रेजी' ||
                              e.value['title'] == 'انجليزي' ||
                              e.value['title'] == '영어') {
                            var locale = const Locale("en", 'US');
                            Get.updateLocale(locale);
                            appCtrl.languageVal = "en";
                            appCtrl.storage.write(session.languageCode, "en");
                            appCtrl.storage.write(session.countryCode, "US");
                          } else if (e.value['title'] == "arabic" ||
                              e.value['title'] == 'अरबी' ||
                              e.value['title'] == 'عربي' ||
                              e.value['title'] == '아랍어') {
                            var locale = const Locale("ar", 'AE');
                            Get.updateLocale(locale);
                            appCtrl.languageVal = "ar";
                            appCtrl.storage.write(session.languageCode, "ar");
                            appCtrl.storage.write(session.countryCode, "AE");
                          } else if (e.value['title'] == "korean" ||
                              e.value['title'] == 'कोरियाई' ||
                              e.value['title'] == 'كوري' ||
                              e.value['title'] == '한국어') {
                            var locale = const Locale("ko", 'KR');
                            Get.updateLocale(locale);

                            appCtrl.languageVal = "ko";
                            appCtrl.storage.write(session.languageCode, "ko");
                            appCtrl.storage.write(session.countryCode, "KR");
                          } else if (e.value['title'] == "hindi" ||
                              e.value['title'] == 'हिंदी' ||
                              e.value['title'] == 'هندي' ||
                              e.value['title'] == '힌디어') {
                            appCtrl.languageVal = "hi";
                            var locale = const Locale("hi", 'IN');
                            Get.updateLocale(locale);
                            appCtrl.storage.write(session.languageCode, "hi");
                            appCtrl.storage.write(session.countryCode, "IN");
                          }
                          appCtrl.update();

                          Get.forceAppUpdate();
                          log("message");
                          /* Get.back();*/
                          log("message1");
                        },
                        child: Text(
                            "${e.value["title"].toString().tr} - ${e.value["title"].toString().toUpperCase()}",
                            style: AppCss.manropeMedium14
                                .textColor(appCtrl.appTheme.blackColor))))
                    .toList()
              ];
            })
        .height(45)
        .decorated(
            color: appCtrl.appTheme.whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r8)),
            boxShadow: [
          BoxShadow(
              color: appCtrl.appTheme.bgGray, spreadRadius: 4, blurRadius: 4)
        ]).paddingOnly(right: Insets.i30, left: Insets.i5);
  }
}
