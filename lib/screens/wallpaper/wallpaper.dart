import 'dart:developer';

import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';

import 'package:chatzy_admin/screens/wallpaper/layouts/image_layout.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_layout.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_table.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_widget_class.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';
import 'package:desktop_drop/desktop_drop.dart';

import '../../config.dart';

class WallPaper extends StatelessWidget {
  final wallpaperCtrl = Get.put(WallpaperController());

  WallPaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(builder: (_) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageLayout(
                        image: wallpaperCtrl.imageUrl,
                      ).height(wallpaperCtrl.isUploadSize
                          ? Sizes.s200
                          : wallpaperCtrl.imageUrl.isNotEmpty
                              ? Sizes.s200
                            : Sizes.s150),
                      const VSpace(Sizes.s20),

                      if (wallpaperCtrl.isAlert == true &&
                          wallpaperCtrl.pickImage == null)
                        Text("Please Upload Image",
                            style: AppCss.muktaVaaniSemiBold14
                                .textColor(appCtrl.appTheme.redColor))
                    ],
                  ),
                ),
              ],
            ),
            CommonButton(
              title: wallpaperCtrl.characterId != ""
                  ? fonts.updateWallPaper.tr
                  : fonts.addWallPaper.tr,
              width: Sizes.s200,
              onTap: () => wallpaperCtrl.characterId != ""
                  ? wallpaperCtrl.addData()
                  : wallpaperCtrl.uploadFile(),
              style: AppCss.muktaVaaniRegular14
                  .textColor(appCtrl.appTheme.whiteColor),
            ).alignment(Alignment.centerRight),
            const VSpace(Sizes.s20),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(collectionName.wallpaper)
                    .snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return Responsive.isDesktop(context)
                        ? WallpaperListTable(children: [
                            WallpaperWidgetClass().tableWidget(),
                            ...snapShot.data!.docs.asMap().entries.map((e) {
                              return TableRow(children: [
                                CommonWidgetClass()
                                    .commonValueText(e.value.id)
                                    .marginSymmetric(
                                        vertical: Insets.i12,
                                        horizontal: Insets.i10),
                                CommonWidgetClass()
                                    .commonValueText(e.value.data()["image"],
                                        isImage: true)
                                    .marginSymmetric(vertical: Insets.i12),
                                WallpaperWidgetClass()
                                    .actionLayout(
                                        onTap: () {
                                          wallpaperCtrl.imageUrl =
                                              e.value.data()["image"];
                                          wallpaperCtrl.characterId =
                                              e.value.id;
                                          wallpaperCtrl.update();
                                        },
                                        deleteTap: () => accessDenied(
                                                fonts.deleteThisWallPaper.tr,
                                                isModification: false,
                                                isDelete: true, onTap: () {
                                              Get.back();
                                              wallpaperCtrl
                                                  .deleteData(e.value.id);
                                            }))
                                    .marginSymmetric(vertical: Insets.i12)
                              ]);
                            }).toList()
                          ])
                        : WallpaperMobileLayout(
                            snapShot: snapShot,
                          );
                  } else {
                    return Container();
                  }
                })
          ]).paddingAll(Insets.i25).boxExtension();
    });
  }
}
