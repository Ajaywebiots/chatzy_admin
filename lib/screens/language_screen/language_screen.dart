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
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Language Selection",
                  style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: appCtrl.appTheme.blackText)),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text("Primary Language",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appCtrl.appTheme.primary)),
                    SmoothContainer(
                      smoothness: 0.6,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      borderRadius: BorderRadius.circular(6),
                      color: appCtrl.appTheme.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: Insets.i10),
                      side: BorderSide(
                          color:
                              appCtrl.appTheme.textBoxColor.withOpacity(.15)),
                      child: Text(langCtrl.defaultLan != null? langCtrl.defaultLan["title"] :""),
                    ),
                    Text(":").paddingOnly(right: Insets.i10),
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
                                  Visibility(
                                      visible:
                                          (MediaQuery.of(context).size.width >
                                              Sizes.s768),
                                      child: Text(langCtrl.defaultLan["title"],
                                              style: AppCss.manropeMedium14
                                                  .textColor(appCtrl
                                                      .appTheme.blackColor))
                                          .paddingSymmetric(
                                              horizontal: Insets.i16 * 0.5)),
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
                                    .map((e) => PopupMenuItem<int>(
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
                    VerticalDivider(color: appCtrl.appTheme.textBoxColor.withOpacity(.15),width: 0,endIndent: 10,indent: 10,).paddingSymmetric(horizontal: 15),
                    CommonButton(title: "Save",width: 80,margin: 0,style: TextStyle(color: appCtrl.appTheme.whiteColor),onTap: ()=>langCtrl.save(),)
                  ],
                ),
              ),
            ],
          ),
          GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: Insets.i100),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: langCtrl.languagesLists.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisExtent: 50,
                  mainAxisSpacing: 20.0,
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Row(
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
                                  image: NetworkImage(langCtrl
                                      .languagesLists[index]["image"]))),
                        ).paddingAll(Insets.i4).decorated(
                            color: appCtrl.appTheme.white,
                            border: Border.all(color: Color(0xFFE9E9E9)),
                            shape: BoxShape.circle),
                        const HSpace(Sizes.s10),
                        Text(
                          langCtrl.languagesLists[index]["title"],
                          style: GoogleFonts.manrope(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: appCtrl.appTheme.blackText),
                        )
                      ],
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          FlutterSwitch(
                              width: Sizes.s35,
                              height: 23,
                              padding: 2,
                              inactiveColor: Color(0xFFEBEBEC),
                              activeColor: appCtrl.appTheme.primary,
                              toggleSize: 15,
                              value: langCtrl.languagesLists[index]["isActive"],
                              onToggle: (val) {
                                langCtrl.languagesLists[index]["isActive"] =
                                    val;
                                langCtrl.update();
                                int id = langCtrl.isActiveList.indexWhere(
                                    (element) =>
                                        element["title"] ==
                                        langCtrl.languagesLists[index]
                                            ["title"]);
                                if(id >0){
                                  langCtrl.isActiveList.removeAt(id);
                                }else{
                                  langCtrl.isActiveList.add(langCtrl.languagesLists[index]);
                                }
                                langCtrl.update();
                              }),
                          Image.asset(imageAssets.line,height: MediaQuery.of(context).size.height,)
                              .paddingSymmetric(horizontal: Insets.i40)
                        ],
                      ),
                    )
                  ],
                );
              }).paddingAll(Insets.i20)
        ],
      )
          .paddingSymmetric(horizontal: Insets.i30, vertical: Insets.i20)
          .boxExtension();
    });
  }
}
