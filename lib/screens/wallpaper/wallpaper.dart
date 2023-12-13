import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/image_layout.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_layout.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_table.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/wallpaper_widget_class.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Add image",style: GoogleFonts.manrope(
                            fontSize: 20,fontWeight: FontWeight.w800,color: appCtrl.appTheme.blackText
                          ),),
                        ],
                      ),
                      const VSpace(Sizes.s22),
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
                /*Expanded(
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
                ),*/
                IntrinsicHeight(
                  child: Row(
                    children: [
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
                                    child: Text(wallpaperCtrl.dropdownValue,
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
                              ...wallpaperCtrl.wallpaperTypeList
                                  .asMap()
                                  .entries
                                  .map((e) => PopupMenuItem<int>(
                                  value: 0,
                                  onTap: () {
                                    wallpaperCtrl.dropdownValue = e.value;
                                    wallpaperCtrl.update();
                                  },
                                  child: Text(e.value.toString(),
                                      style: AppCss.manropeMedium14
                                          .textColor(appCtrl
                                          .appTheme.blackColor))))
                                  .toList()
                            ];
                          }).height(40).decorated(
                        color: appCtrl.appTheme.textBoxColor
                            .withOpacity(.06),

                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r8)),
                      ),
                      const HSpace(Sizes.s10),
                      CommonButton(title:wallpaperCtrl.characterId != ""

                          ? fonts.updateWallPaper.tr:"Save",width: 80,height: 40,margin: 0,style: TextStyle(color: appCtrl.appTheme.whiteColor),onTap: ()=>wallpaperCtrl.uploadFile(),)
                    ],
                  ),
                )
              ]
            ),

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

                              return TableRow(
                                  decoration: BoxDecoration(

                                    border: Border(bottom: BorderSide(
                                      color: Color(0xFF313232).withOpacity(.15)
                                    ))
                                  ),
                                  children: [
                                CommonWidgetClass()
                                    .commonValueText(wallpaperCtrl.dropdownValue.capitalizeFirst)
                                    .marginSymmetric(
                                        vertical: Insets.i25,
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
