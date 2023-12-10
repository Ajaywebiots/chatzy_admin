import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/image_layout.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_layout.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_table.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_widget_class.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                     /* DropzoneView(
                        operation: DragOperation.copy,
                        cursor: CursorType.grab,
                        onCreated: (DropzoneViewController ctrl) => controller = ctrl,
                        onLoaded: () => print('Zone loaded'),
                        onError: (String? ev) => print('Error: $ev'),
                        onHover: () => print('Zone hovered'),
                        onDrop: (dynamic ev) => print('Drop: $ev'),
                        onDropMultiple: (List<dynamic> ev) => print('Drop multiple: $ev'),
                        onLeave: () => print('Zone left'),
                      ),*/
                      const VSpace(Sizes.s20),

                      if (wallpaperCtrl.isAlert == true &&
                          wallpaperCtrl.pickImage == null)
                        Text("Please Upload Image",
                            style: AppCss.manropeSemiBold14
                                .textColor(appCtrl.appTheme.redColor))
                    ]
                  )
                ),
                Expanded(
                  child: DropdownMenu<String>(
                    initialSelection: wallpaperCtrl.dropdownValue,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      wallpaperCtrl.dropdownValue = value!;
                      wallpaperCtrl.update();
                    },
                    dropdownMenuEntries: wallpaperCtrl.wallpaperTypeList.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                  ).alignment(Alignment.topLeft),
                ),
              ]
            ),
            CommonButton(
              title: wallpaperCtrl.characterId != ""
                  ? fonts.updateWallPaper.tr
                  : fonts.addWallPaper.tr,
              width: Sizes.s200,
              onTap: () => wallpaperCtrl.uploadFile(),
              style: AppCss.manropeRegular14
                  .textColor(appCtrl.appTheme.whiteColor)
            ).alignment(Alignment.centerRight),
            const VSpace(Sizes.s20),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(collectionName.wallpaper).where("type",isEqualTo: wallpaperCtrl.dropdownValue)
                    .snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    List image =[];
                   if(snapShot.data!.docs.isNotEmpty){
                     image = snapShot.data!.docs[0].data()["image"];
                   }
                    return Responsive.isDesktop(context)
                        ? WallpaperListTable(children: [
                            WallpaperWidgetClass().tableWidget(),
                            ...image.asMap().entries.map((e) {

                              return TableRow(children: [
                                CommonWidgetClass()
                                    .commonValueText(wallpaperCtrl.dropdownValue.capitalizeFirst)
                                    .marginSymmetric(
                                        vertical: Insets.i12,
                                        horizontal: Insets.i10),
                                CommonWidgetClass()
                                    .commonValueText(e.value,isImage: true
                                )
                                    .marginSymmetric(vertical: Insets.i12),
                                WallpaperWidgetClass()
                                    .actionLayout(
                                        onTap: () {
                                          wallpaperCtrl.imageUrl =
                                              e.value;
                                          wallpaperCtrl.characterId =
                                              snapShot.data!.docs[0].id;
                                          wallpaperCtrl.selectedIndex =e.key;
                                          wallpaperCtrl.update();

                                        },
                                        deleteTap: () => accessDenied(
                                                fonts.deleteThisWallPaper.tr,
                                                isModification: false,
                                                isDelete: true, onTap: () {
                                              Get.back();
                                              wallpaperCtrl
                                                  .deleteData(snapShot.data!.docs[0].id,e.key);
                                            }))
                                    .marginSymmetric(vertical: Insets.i12)
                              ]);
                            }).toList()
                          ])
                        : WallpaperMobileLayout(
                            snapShot: snapShot
                          );
                  } else {
                    return Container();
                  }
                })
          ]).paddingAll(Insets.i25).boxExtension();
    });
  }
}
