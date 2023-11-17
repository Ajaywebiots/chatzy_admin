import '../config.dart';

class ImagePickUp extends StatelessWidget {
  const ImagePickUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonDottedBorder(
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center,children: [
      Image.asset(imageAssets.gallery, height: Sizes.s120),
      const VSpace(Sizes.s10),
      RichText(
          text: TextSpan(children: [
        TextSpan(
            text: fonts.clickToUpload.tr,
            style: AppCss.muktaVaaniMedium20
                .textColor(appCtrl.appTheme.primary)
                .textDecoration(TextDecoration.underline)),
        TextSpan(
            text: fonts.orDragDrop.tr,
            style: AppCss.muktaVaaniMedium20.textColor(appCtrl.appTheme.dark))
      ]))
    ]).width(MediaQuery.of(context).size.width));
  }
}
