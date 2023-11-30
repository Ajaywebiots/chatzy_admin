import 'dart:developer';

import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';
import 'package:desktop_drop/desktop_drop.dart';

import '../../../config.dart';

class ImageLayout extends StatelessWidget {
  final StateSetter? setState;
  final String? image;
  final bool isWallPaper;

  const ImageLayout(
      {Key? key, this.setState, this.image, this.isWallPaper = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(builder: (bannerCtrl) {
      return SizedBox(
          height: Sizes.s50,
          child: Stack(alignment: Alignment.center, children: [
            DropTarget(
                onDragDone: (detail) async {
                  bannerCtrl.imageName = detail.files.first.name;
                  bannerCtrl.update();
                  final bytes = await detail.files.first.readAsBytes();
                  bannerCtrl.getImage(dropImage: bytes);

                  log("detail.files :${detail.files}");
                },
                onDragEntered: (detail) {
                  log("ENTER : $detail");
                },
                onDragExited: (detail) {
                  log("ExIt : $detail");
                },
                child: bannerCtrl.imageUrl.isNotEmpty &&
                        bannerCtrl.pickImage != null
                    ? CommonDottedBorder(
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r16),
                                child: Image.memory(bannerCtrl.webImage,
                                    fit: BoxFit.fill,
                                    width: Sizes.s200,
                                    height: Sizes.s200)))
                        .inkWell(
                            onTap: () => bannerCtrl.getImage(
                                source: ImageSource.gallery, context: context))
                    : bannerCtrl.imageUrl.isNotEmpty
                        ? CommonDottedBorder(
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.r16),
                                    child: Image.network(bannerCtrl.imageUrl,
                                        fit: BoxFit.fill,
                                        width: Sizes.s200,
                                        height: Sizes.s200)))
                            .inkWell(
                                onTap: () => bannerCtrl.getImage(
                                    source: ImageSource.gallery,
                                    context: context))
                        : bannerCtrl.pickImage == null
                            ? CommonDottedBorder(
                                    child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                                Image.asset(imageAssets.gallery,
                                    height: Sizes.s100),
                                const VSpace(Sizes.s10),
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: fonts.clickToUpload.tr,
                                          style: AppCss.muktaVaaniMedium14
                                              .textColor(
                                                  appCtrl.appTheme.primary)
                                              .textDecoration(
                                                  TextDecoration.underline)),
                                      TextSpan(
                                          text: fonts.orDragDrop.tr,
                                          style: AppCss.muktaVaaniMedium14
                                              .textColor(appCtrl.appTheme.dark))
                                    ])).marginSymmetric(horizontal: Insets.i10)
                              ]).width(200))
                                .inkWell(onTap: () => bannerCtrl.onImagePickUp(setState, context, ""))
                            : CommonDottedBorder(child: ClipRRect(borderRadius: BorderRadius.circular(AppRadius.r16), child: Image.memory(bannerCtrl.webImage, fit: BoxFit.fill, width: Sizes.s200, height: Sizes.s200))).inkWell(onTap: () => bannerCtrl.getImage(source: ImageSource.gallery, context: context)))
          ]));
    });
  }
}
