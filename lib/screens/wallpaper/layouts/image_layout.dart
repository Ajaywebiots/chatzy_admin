import 'dart:developer';

import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
      log("bannerCtrl.pickImage : ${bannerCtrl.imageUrl.isNotEmpty || bannerCtrl.pickImage != null || bannerCtrl.webImage.isNotEmpty}");
      return SmoothContainer(
          color: appCtrl.appTheme.textBoxColor.withOpacity(.06),
          borderRadius: BorderRadius.circular(6),
          smoothness: 1,
          height: Sizes.s50,
          padding: EdgeInsets.all(Insets.i10),
          child: Stack(alignment: Alignment.centerLeft, children: [
            /* DragDropLayout(
                onCreated: (ctrl) =>
                bannerCtrl.controller1 = ctrl,
                onDrop: (ev) async {

                  bannerCtrl.imageName = ev.name;
                  bannerCtrl.update();
                  final bytes = await bannerCtrl
                      .controller1!.getFileData(ev);
                  bannerCtrl.getImage(
                      dropImage: bytes);
                }),*/
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
                    ? CommonDottedBorder(child: ClipRRect(borderRadius: BorderRadius.circular(AppRadius.r16), child: Image.memory(bannerCtrl.webImage, fit: BoxFit.fill))).inkWell(
                        onTap: () => bannerCtrl.getImage(
                            source: ImageSource.gallery, context: context))
                    : bannerCtrl.imageUrl.isNotEmpty
                        ? CommonDottedBorder(child: Image.network(bannerCtrl.imageUrl))
                            .inkWell(
                                onTap: () => bannerCtrl.getImage(
                                    source: ImageSource.gallery,
                                    context: context))
                        : bannerCtrl.pickImage == null
                            ? CommonDottedBorder(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                    SvgPicture.asset(svgAssets.export,),
                                    const VSpace(Sizes.s10),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: fonts.clickToUpload.tr,
                                          style: AppCss.manropeMedium14
                                              .textColor(
                                                  appCtrl.appTheme.primary)
                                              .textDecoration(
                                                  TextDecoration.underline)),
                                      TextSpan(
                                          text: " ${fonts.image.tr}",
                                          style: AppCss.manropeMedium14
                                              .textColor(appCtrl.appTheme.dark))
                                    ])).marginSymmetric(horizontal: Insets.i10)
                                  ]).width(200))
                                .inkWell(
                                    onTap: () => bannerCtrl.onImagePickUp(
                                        setState, context, ""))
                            : CommonDottedBorder(child: ClipRRect(borderRadius: BorderRadius.circular(AppRadius.r16), child: Image.memory(bannerCtrl.webImage, fit: BoxFit.fill)))
                                .inkWell(
                                    onTap: () => bannerCtrl.getImage(
                                        source: ImageSource.gallery,
                                        context: context)))
          ]));
    });
  }
}
