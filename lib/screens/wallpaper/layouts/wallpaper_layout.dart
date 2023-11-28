import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';
import 'package:chatzy_admin/widgets/common_switcher.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';

import '../../../../config.dart';

class WallpaperMobileLayout extends StatelessWidget {
  final AsyncSnapshot<dynamic>? snapShot;

  const WallpaperMobileLayout({Key? key, this.snapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(builder: (charactersCtrl) {
      return Column(children: [
        ...snapShot!.data!.docs.asMap().entries.map((e) {
          return Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    e.value.data()["image"] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.r50),
                            child: Image.network(e.value.data()["image"],
                                height: Sizes.s50))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.r50),
                            child: Image.asset(imageAssets.addUser,
                                height: Sizes.s50)),
                    const HSpace(Sizes.s10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            CommonWidgetClass().commonValueText("Title - "),
                            CommonWidgetClass().commonValueText(
                                e.value.data()["title"] ?? "-"),
                          ]),
                          Row(children: [
                            CommonWidgetClass().commonValueText("Message - "),
                            CommonWidgetClass().commonValueText(
                                e.value.data()["message"] ?? "Not Defined")
                          ]).marginSymmetric(vertical: Insets.i5)
                        ])
                  ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete, color: appCtrl.appTheme.primary)
                            .inkWell(
                                onTap: () => accessDenied(
                                    fonts.deleteCharacterConfirmation.tr,
                                    isModification: false,
                                    isDelete: false,
                                    onTap: () =>
                                        charactersCtrl.deleteData(e.value.id,e.key))),
                        CommonSwitcher(
                            isActive: e.value.data()["isActive"] ?? true,
                            onToggle: (val) =>
                                charactersCtrl.isActiveChange(e.value.id, val))
                      ])
                ]).paddingAll(Insets.i10),
          ).marginOnly(bottom: Insets.i15);
        }).toList()
      ]);
    });
  }
}
