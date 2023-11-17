import 'dart:developer';
import 'package:chatzy_admin/controllers/app_pages_controller/wallpaper_controller.dart';

import '../../../config.dart';

class DarkImageLayout extends StatelessWidget {
  final StateSetter? setState;
  final String? image;

  const DarkImageLayout({Key? key, this.setState, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(builder: (bannerCtrl) {

      return Stack(alignment: Alignment.centerLeft, children: [
        DragDropLayout(
            onCreated: (ctrl) => bannerCtrl.controller2 = ctrl,
            onDrop: (ev) async {
              log('Zone 1 drop: ${ev.name}');
              bannerCtrl.wallpaperImageName2 = ev.name;
              bannerCtrl.update();
              final bytes = await bannerCtrl.controller2!.getFileData(ev);
              bannerCtrl.getImage(dropImage: bytes, title: "image2");
            }),
        image!.isNotEmpty &&
            image != "" &&
            bannerCtrl.wallpaperPickImage2 != null &&
            bannerCtrl.wallpaperWebImage2.isNotEmpty
            ? CommonDottedBorder(
            child: Image.memory(bannerCtrl.wallpaperWebImage2, fit: BoxFit.fill,height: Sizes.s150,width: Sizes.s150,))
            .inkWell(
            onTap: () => bannerCtrl.getImage(
                source: ImageSource.gallery,
                context: context,
                title: "image2"))
            : image!.isNotEmpty
            ? CommonDottedBorder(
            child: Image.network(
              image!,
              height: Sizes.s150,width: Sizes.s150,
            )).inkWell(
            onTap: () => bannerCtrl.getImage(
                source: ImageSource.gallery,
                context: context,
                title: "image2"))
            : bannerCtrl.wallpaperPickImage2 == null
            ? const ImagePickUp().inkWell(
            onTap: () => bannerCtrl.onImagePickUp(
                setState, context, "image1"))
            : CommonDottedBorder(
            child: Image.memory(bannerCtrl.wallpaperWebImage2,
                fit: BoxFit.fill,height: Sizes.s150,width: Sizes.s150))
            .inkWell(
            onTap: () => bannerCtrl.getImage(
                source: ImageSource.gallery,
                context: context,
                title: "image1"))
      ]).height(bannerCtrl.isDarkUploadFile2 ? Sizes.s150  : image!.isNotEmpty ?Sizes.s150 : Sizes.s50);
    });
  }
}
