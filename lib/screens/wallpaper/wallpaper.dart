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
      return Stack(
        children: [
          ListView(
              /*crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,*/
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageLayout(
                          image: wallpaperCtrl.imageUrl,
                        ).height(Sizes.s200).width(Sizes.s200),
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
                          Text(
                              wallpaperCtrl.characterId != ""
                                  ? fonts.pleasUploadAnotherImage.tr
                                  : fonts.pleasUploadImage.tr,
                              style: AppCss.muktaVaaniSemiBold14
                                  .textColor(appCtrl.appTheme.redColor))
                      ]),
                  const HSpace(Sizes.s30),

                  SizedBox(
                      width: Sizes.s120,
                      height: Sizes.s35,
                      child: DropdownButtonFormField(

                          style: AppCss.muktaVaaniMedium16
                              .textColor(appCtrl.appTheme.txt),

                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: appCtrl.appTheme.primary, width: 1),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r5),
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: appCtrl.appTheme.primary, width: 1),
                                borderRadius:
                                BorderRadius.circular(AppRadius.r5),
                              ) ,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: appCtrl.appTheme.primary, width: 1),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r5),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                maxHeight: 10,maxWidth: 10
                              ),
                              labelStyle: AppCss.muktaVaaniblack14
                                  .textColor(appCtrl.appTheme.txt)),
                          validator: (value) =>
                              value == null ? "Select type" : null,
                          dropdownColor: appCtrl.appTheme.white,
                          value: wallpaperCtrl.dropdownValue,
                          onChanged: (String? newValue) {
                            wallpaperCtrl.dropdownValue = newValue!;
                            wallpaperCtrl.update();
                          },
                          items: wallpaperCtrl.dropdownItems))
                ]),
                CommonButton(
                        title: wallpaperCtrl.isLoading ? "Loading..." : wallpaperCtrl.isUpdate == true
                            ? fonts.updateWallPaper.tr
                            : fonts.addWallPaper.tr,
                        width: Sizes.s200,
                        icon:wallpaperCtrl.isLoading ==true?  CircularProgressIndicator(color: appCtrl.appTheme.white,):Container(),
                        onTap: () => wallpaperCtrl.uploadFile(
                            wallpaperCtrl.characterId != "" ? true : false),
                        style: AppCss.muktaVaaniRegular14
                            .textColor(appCtrl.appTheme.whiteColor))
                    .alignment(Alignment.centerRight),
                const VSpace(Sizes.s20),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(collectionName.wallpaper)
                        .where("type", isEqualTo: wallpaperCtrl.dropdownValue)
                        .snapshots(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        List image = [];
                        if (snapShot.data!.docs.isNotEmpty) {
                          image = snapShot.data!.docs[0].data()["image"];
                        }
                        return Responsive.isDesktop(context)
                            ? WallpaperListTable(children: [
                                WallpaperWidgetClass().tableWidget(),
                                ...image.asMap().entries.map((e) {
                                  return TableRow(children: [
                                    CommonWidgetClass()
                                        .commonValueText(wallpaperCtrl
                                            .dropdownValue.capitalizeFirst)
                                        .marginSymmetric(
                                            vertical: Insets.i12,
                                            horizontal: Insets.i10),
                                    CommonWidgetClass()
                                        .commonValueText(e.value, isImage: true)
                                        .marginSymmetric(vertical: Insets.i12),
                                    WallpaperWidgetClass()
                                        .actionLayout(
                                            onTap: () {
                                              wallpaperCtrl.imageUrl = e.value;
                                              wallpaperCtrl.characterId =
                                                  snapShot.data!.docs[0].id;
                                              wallpaperCtrl.selectedIndex =
                                                  e.key;
                                              wallpaperCtrl.isUpdate = true;
                                              wallpaperCtrl.update();
                                            },
                                            deleteTap: () => accessDenied(
                                                    fonts
                                                        .deleteThisWallPaper.tr,
                                                    isModification: false,
                                                    isDelete: true, onTap: () {
                                                  Get.back();
                                                  wallpaperCtrl.deleteData(
                                                      snapShot.data!.docs[0].id,
                                                      e.key);
                                                }))
                                        .marginSymmetric(vertical: Insets.i12)
                                  ]);
                                }).toList()
                              ])
                            : WallpaperMobileLayout(snapShot: snapShot);
                      } else {
                        return Container();
                      }
                    })
              ]).paddingAll(Insets.i25).boxExtension(),

        ],
      ).height(MediaQuery.of(context).size.height);
    });
  }
}
