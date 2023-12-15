import 'dart:developer';

import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';
import 'package:chatzy_admin/widgets/common_switcher.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';

import '../../../../config.dart';

class WallpaperMobileLayout extends StatelessWidget {
  final List? snapShot;
final String? id;
  const WallpaperMobileLayout({Key? key, this.snapShot,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(builder: (wallpaperCtrl) {
      return Column(children: [
        ...snapShot!.asMap().entries.map((e) {

          return Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    e.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.r50),
                            child: Image.network(e.value,fit: BoxFit.fill,
                                height: Sizes.s50,width: Sizes.s50,))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.r50),
                            child: Image.asset(imageAssets.addUser,
                                height: Sizes.s50,width: Sizes.s50)),
                    const HSpace(Sizes.s10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            CommonWidgetClass().commonValueText("${fonts.type} - "),
                            CommonWidgetClass().commonValueText(
                                wallpaperCtrl.dropdownValue.capitalizeFirst),
                          ]),

                        ])
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(svgAssets.edit)
                            .inkWell(
                                onTap: () {
                                  wallpaperCtrl.imageUrl =
                                      e.value;
                                  wallpaperCtrl.characterId =
                                      id!;
                                  wallpaperCtrl.selectedIndex =e.key;
                                  wallpaperCtrl.update();
                                }),
                        const HSpace(Sizes.s10),
                        SvgPicture.asset(svgAssets.delete).inkWell(onTap: (){
                          accessDenied(
                              fonts.deleteThisWallPaper.tr,
                              isModification: false,
                              isDelete: true, onTap: () {
                            Get.back();
                            wallpaperCtrl
                                .deleteData(id,e.key);
                          });
                        })
                      ])
                ]).paddingAll(Insets.i10),
          ).marginOnly(bottom: Insets.i15);
        }).toList()
      ]);
    });
  }
}
