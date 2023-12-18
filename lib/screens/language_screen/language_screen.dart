import 'dart:developer';

import 'package:chatzy_admin/config.dart';
import 'package:chatzy_admin/controllers/app_pages_controller/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

class LanguageScreen extends StatelessWidget {
  final langCtrl = Get.put(LanguageController());

  LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(builder: (_) {

      log("WID :${MediaQuery.of(context).size.width}");
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fonts.languageSelection.tr,
                  style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color:  appCtrl.isTheme
                          ? appCtrl.appTheme.white
                          :  appCtrl.appTheme.blackText)),
              if(Responsive.isDesktop(context))
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(fonts.primaryLanguage.tr,
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: appCtrl.appTheme.primary)),
                      SmoothContainer(
                        smoothness: 0.6,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        borderRadius: BorderRadius.circular(6),
                        color: appCtrl.appTheme.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: Insets.i10),
                        side: BorderSide(
                            color:
                            appCtrl.appTheme.textBoxColor.withOpacity(.15)),
                        child: Text(langCtrl.defaultLan != null
                            ? langCtrl.defaultLan["title"]
                            : ""),
                      ),
                      const Text(":").paddingOnly(right: Insets.i10),
                      PopupMenuButton(
                          padding: EdgeInsets.zero,
                          color: appCtrl.appTheme.whiteColor,
                          position: PopupMenuPosition.under,
                          tooltip: fonts.showLanguage.tr,
                          child: Container(
                              alignment: Alignment.center,
                              constraints:
                              const BoxConstraints(minWidth: Sizes.s48),
                              child: Row(children: [
                                Text(
                                    langCtrl.defaultLan != null
                                        ? langCtrl.defaultLan["title"]
                                        : "",
                                    style: AppCss.manropeMedium14
                                        .textColor(
                                        appCtrl.appTheme.blackColor))
                                    .paddingSymmetric(
                                    horizontal: Insets.i16 * 0.5),
                                Icon(
                                  CupertinoIcons.chevron_down,
                                  color: appCtrl.appTheme.blackColor,
                                  size: Sizes.s15,
                                )
                              ]).paddingSymmetric(horizontal: Insets.i10)),
                          itemBuilder: (context) {
                            return [
                              ...langCtrl.isActiveList
                                  .asMap()
                                  .entries
                                  .map((e) =>
                                  PopupMenuItem<int>(
                                      value: 0,
                                      onTap: () {
                                        langCtrl.defaultLan = e.value;
                                        langCtrl.update();
                                      },
                                      child: Text(e.value["title"].toString(),
                                          style: AppCss.manropeMedium14
                                              .textColor(appCtrl
                                              .appTheme.blackColor))))
                                  .toList()
                            ];
                          }).height(40).decorated(
                        color: appCtrl.appTheme.whiteColor,
                        border: Border.all(
                            color: appCtrl.appTheme.textBoxColor
                                .withOpacity(.15)),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r8)),
                      ),
                      VerticalDivider(
                        color: appCtrl.appTheme.textBoxColor.withOpacity(.15),
                        width: 0,
                        endIndent: 10,
                        indent: 10,
                      ).paddingSymmetric(horizontal: 15),
                      CommonButton(
                        title: fonts.save.tr,
                        width: 80,
                        margin: 0,
                        style: TextStyle(color: appCtrl.appTheme.whiteColor),
                        onTap: () => langCtrl.save(),
                      )
                    ],
                  ),
                ),

              if(!Responsive.isDesktop(context))
                CommonButton(
                  title: fonts.save.tr,
                  width: 80,
                  margin: 0,
                  style: TextStyle(color: appCtrl.appTheme.whiteColor),
                  onTap: () => langCtrl.save(),
                )
            ],
          ),
          if(Responsive.isDesktop(context))
            const VSpace(Sizes.s20),
          if(!Responsive.isDesktop(context))
            Row(
              children: [
                Text(fonts.primaryLanguage.tr,
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: appCtrl.appTheme.primary)),
                SmoothContainer(
                  smoothness: 0.6,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  borderRadius: BorderRadius.circular(6),
                  color: appCtrl.appTheme.whiteColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: Insets.i10),
                  side: BorderSide(
                      color:
                      appCtrl.appTheme.textBoxColor.withOpacity(.15)),
                  child: Text(langCtrl.defaultLan != null
                      ? langCtrl.defaultLan["title"]
                      : "",style:  GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appCtrl.isTheme
                          ? appCtrl.appTheme.white
                          : appCtrl.appTheme.blackText),),
                ),
                const Text(":").paddingOnly(right: Insets.i10),
                PopupMenuButton(
                    padding: EdgeInsets.zero,
                    color: appCtrl.appTheme.whiteColor,
                    position: PopupMenuPosition.under,
                    tooltip: fonts.showLanguage.tr,
                    child: Container(
                        alignment: Alignment.center,
                        constraints:
                        const BoxConstraints(minWidth: Sizes.s48),
                        child: Row(children: [
                          Text(
                              langCtrl.defaultLan != null
                                  ? langCtrl.defaultLan["title"]
                                  : "",
                              style: AppCss.manropeMedium14
                                  .textColor(
                                  appCtrl.appTheme.blackColor))
                              .paddingSymmetric(
                              horizontal: Insets.i16 * 0.5),
                          Icon(
                            CupertinoIcons.chevron_down,
                            color: appCtrl.appTheme.blackColor,
                            size: Sizes.s15,
                          )
                        ]).paddingSymmetric(horizontal: Insets.i10)),
                    itemBuilder: (context) {
                      return [
                        ...langCtrl.isActiveList
                            .asMap()
                            .entries
                            .map((e) =>
                            PopupMenuItem<int>(
                                value: 0,
                                onTap: () {
                                  langCtrl.defaultLan = e.value;
                                  langCtrl.update();
                                },
                                child: Text(e.value["title"].toString(),
                                    style: AppCss.manropeMedium14
                                        .textColor(appCtrl
                                        .appTheme.blackColor))))
                            .toList()
                      ];
                    }).height(40).decorated(
                  color: appCtrl.appTheme.whiteColor,
                  border: Border.all(
                      color: appCtrl.appTheme.textBoxColor
                          .withOpacity(.15)),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppRadius.r8)),
                ),
                VerticalDivider(
                  color: appCtrl.appTheme.textBoxColor.withOpacity(.15),
                  width: 0,
                  endIndent: 10,
                  indent: 10,
                ).paddingSymmetric(horizontal: 15),

              ],
            ).marginOnly(top: 20),
          const VSpace(Sizes.s20),
          Divider(color: const Color(0xFF010D21).withOpacity(.12)),
          if(Responsive.isDesktop(context))
          GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: langCtrl.languagesLists.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 7,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                crossAxisCount: MediaQuery
                    .of(context)
                    .size
                    .width < 1420 ? 2 : 4 ,
              ),
              itemBuilder: (context, index) {
                return getWarppedPicture(langCtrl.languagesLists[index], index,
                    langCtrl.languagesLists.length);
              }).paddingSymmetric(vertical: Insets.i20),
          if(!Responsive.isDesktop(context))
            Column(
              children: [
                ...langCtrl.languagesLists.asMap().entries.map((e) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Sizes.s28,
                              width: Sizes.s28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(e.value["image"]))),
                            ).paddingAll(Insets.i4).decorated(
                                color: appCtrl.appTheme.white,
                                border: Border.all(color: const Color(0xFFE9E9E9)),
                                shape: BoxShape.circle),
                            const HSpace(Sizes.s10),
                            Text(
                              e.value["title"],
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: appCtrl.isTheme
                                      ? appCtrl.appTheme.white
                                      :  appCtrl.appTheme.blackText),
                            )
                          ],
                        ),
                        FlutterSwitch(
                            width: Sizes.s35,
                            height: 23,
                            padding: 2,
                            inactiveColor: const Color(0xFFEBEBEC),
                            activeColor: appCtrl.appTheme.primary,
                            toggleSize: 15,
                            value: e.value["isActive"],
                            onToggle: (val) {
                              e.value["isActive"] = val;
                              langCtrl.update();
                              int id = langCtrl.isActiveList.indexWhere(
                                      (element) =>
                                  element["title"] == element["title"]);
                              if (id > 0) {
                                langCtrl.isActiveList.removeAt(id);
                              } else {
                                langCtrl.isActiveList.add(
                                    langCtrl.languagesLists[e.key]);
                              }
                              langCtrl.update();
                            })
                      ],
                    ).width(340),

                  ],
                ).marginOnly(bottom: Insets.i10))
              ],
            ).paddingSymmetric(vertical: Insets.i20)
        ],
      )
          .paddingSymmetric(horizontal: Insets.i30, vertical: Insets.i20)
          .boxExtension();
    });
  }

  Widget getWarppedPicture(element, int index, totalLegth) {
    int tempIndex = index + 1;
 if(MediaQuery
        .of(Get.context!)
        .size
        .width < 1420 ){

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Sizes.s28,
                        width: Sizes.s28,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(element["image"]))),
                      ).paddingAll(Insets.i4).decorated(
                          color: appCtrl.appTheme.white,
                          border: Border.all(color: const Color(0xFFE9E9E9)),
                          shape: BoxShape.circle),
                      const HSpace(Sizes.s10),
                      Text(
                        element["title"],
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: appCtrl.appTheme.blackText),
                      )
                    ],
                  ),
                  FlutterSwitch(
                      width: Sizes.s35,
                      height: 23,
                      padding: 2,
                      inactiveColor: const Color(0xFFEBEBEC),
                      activeColor: appCtrl.appTheme.primary,
                      toggleSize: 15,
                      value: element["isActive"],
                      onToggle: (val) {
                        element["isActive"] = val;
                        langCtrl.update();
                        int id = langCtrl.isActiveList.indexWhere(
                                (element) =>
                            element["title"] == element["title"]);
                        if (id > 0) {
                          langCtrl.isActiveList.removeAt(id);
                        } else {
                          langCtrl.isActiveList.add(
                              langCtrl.languagesLists[index]);
                        }
                        langCtrl.update();
                      })
                ],
              ).width(340),

            ],
          )
        ],
      );
    }else {
      // if bottomRigth
      if (index == 3 || index == 7 || index == 11 || index == 15 ||
          index == 19 ||
          index == 23 || index == 27 || index == 31 || index == 35) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: Sizes.s28,
                          width: Sizes.s28,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(element["image"]))),
                        ).paddingAll(Insets.i4).decorated(
                            color: appCtrl.appTheme.white,
                            border: Border.all(color: const Color(0xFFE9E9E9)),
                            shape: BoxShape.circle),
                        const HSpace(Sizes.s10),
                        Text(
                          element["title"],
                          style: GoogleFonts.manrope(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: appCtrl.appTheme.blackText),
                        )
                      ],
                    ),
                    FlutterSwitch(
                        width: Sizes.s35,
                        height: 23,
                        padding: 2,
                        inactiveColor: const Color(0xFFEBEBEC),
                        activeColor: appCtrl.appTheme.primary,
                        toggleSize: 15,
                        value: element["isActive"],
                        onToggle: (val) {
                          element["isActive"] = val;
                          langCtrl.update();
                          int id = langCtrl.isActiveList.indexWhere(
                                  (element) =>
                              element["title"] == element["title"]);
                          if (id > 0) {
                            langCtrl.isActiveList.removeAt(id);
                          } else {
                            langCtrl.isActiveList.add(
                                langCtrl.languagesLists[index]);
                          }
                          langCtrl.update();
                        })
                  ],
                ).width(340),

              ],
            )
          ],
        );
      }
    }

    // if bottom
    if (tempIndex + 4 >= totalLegth) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Sizes.s28,
                        width: Sizes.s28,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(element["image"]))),
                      ).paddingAll(Insets.i4).decorated(
                          color: appCtrl.appTheme.white,
                          border: Border.all(color: const Color(0xFFE9E9E9)),
                          shape: BoxShape.circle),
                      const HSpace(Sizes.s10),
                      Text(
                        element["title"],
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: appCtrl.appTheme.blackText),
                      )
                    ],
                  ),
                  FlutterSwitch(
                      width: Sizes.s35,
                      height: 23,
                      padding: 2,
                      inactiveColor: const Color(0xFFEBEBEC),
                      activeColor: appCtrl.appTheme.primary,
                      toggleSize: 15,
                      value: element["isActive"],
                      onToggle: (val) {
                        element["isActive"] = val;
                        langCtrl.update();
                        int id = langCtrl.isActiveList.indexWhere(
                                (element) =>
                            element["title"] == element["title"]);
                        if (id > 0) {
                          langCtrl.isActiveList.removeAt(id);
                        } else {
                          langCtrl.isActiveList.add(
                              langCtrl.languagesLists[index]);
                        }
                        langCtrl.update();
                      })
                ],
              ).width(340),
              Image.asset(
                imageAssets.line,
                height: 32,
                width: 2,
                fit: BoxFit.fill,
              )
            ],
          ),
        ],
      );
    }

    // if rigth
    if (index % 4 == 0) {
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Sizes.s28,
                        width: Sizes.s28,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(element["image"]))),
                      ).paddingAll(Insets.i4).decorated(
                          color: appCtrl.appTheme.white,
                          border: Border.all(color: const Color(0xFFE9E9E9)),
                          shape: BoxShape.circle),
                      const HSpace(Sizes.s10),
                      Text(
                        element["title"],
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: appCtrl.appTheme.blackText),
                      )
                    ],
                  ),
                  FlutterSwitch(
                      width: Sizes.s35,
                      height: 23,
                      padding: 2,
                      inactiveColor: const Color(0xFFEBEBEC),
                      activeColor: appCtrl.appTheme.primary,
                      toggleSize: 15,
                      value: element["isActive"],
                      onToggle: (val) {
                        element["isActive"] = val;
                        langCtrl.update();
                        int id = langCtrl.isActiveList.indexWhere(
                                (element) =>
                            element["title"] == element["title"]);
                        if (id > 0) {
                          langCtrl.isActiveList.removeAt(id);
                        } else {
                          langCtrl.isActiveList.add(
                              langCtrl.languagesLists[index]);
                        }
                        langCtrl.update();
                      })
                ],
              ),
              Image.asset(
                imageAssets.line,
                height: 32,
                width: 2,
                fit: BoxFit.fill,
              )
            ],
          )
        ],
      );
    }

    // all the rest
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: Sizes.s28,
                      width: Sizes.s28,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(element["image"]))),
                    ).paddingAll(Insets.i4).decorated(
                        color: appCtrl.appTheme.white,
                        border: Border.all(color: const Color(0xFFE9E9E9)),
                        shape: BoxShape.circle),
                    const HSpace(Sizes.s10),
                    Text(
                      element["title"],
                      style: GoogleFonts.manrope(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: appCtrl.appTheme.blackText),
                    )
                  ],
                ),
                FlutterSwitch(
                    width: Sizes.s35,
                    height: 23,
                    padding: 2,
                    inactiveColor: const Color(0xFFEBEBEC),
                    activeColor: appCtrl.appTheme.primary,
                    toggleSize: 15,
                    value: element["isActive"],
                    onToggle: (val) {
                      element["isActive"] = val;
                      langCtrl.update();
                      int id = langCtrl.isActiveList.indexWhere(
                              (element) =>
                          element["title"] == element["title"]);
                      if (id > 0) {
                        langCtrl.isActiveList.removeAt(id);
                      } else {
                        langCtrl.isActiveList.add(
                            langCtrl.languagesLists[index]);
                      }
                      langCtrl.update();
                    })
              ],
            ).width(340),
            Image.asset(
              imageAssets.line,
              height: 32,
              width: 2,
              fit: BoxFit.fill,
            )
          ],
        )
      ],
    );
  }

}
