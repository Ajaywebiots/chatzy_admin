

import '../../../config.dart';
import '../../../controllers/app_pages_controller/wallpaper_controller.dart';

class AddWallpaper extends StatelessWidget {
  const AddWallpaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return GetBuilder<WallpaperController>(builder: (wallpaperCtrl) {
            return Stack(alignment: Alignment.topCenter, children: [
              AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                      decoration: BoxDecoration(
                          color: appCtrl.appTheme.whiteColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: appCtrl.isTheme ?  1 :0,
                                spreadRadius: appCtrl.isTheme ?  1 :0,
                                color: appCtrl.appTheme.blackColor
                            )
                          ]),
                      width: Sizes.s600,
                      child:
                      Stack(alignment: Alignment.topRight, children: <Widget>[
                        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          Container(
                              height: Sizes.s50,
                              width: Sizes.s500,
                              decoration: BoxDecoration(
                                  color: appCtrl.appTheme.whiteColor,
                                  border: Border(
                                      bottom:
                                      BorderSide(color: appCtrl.appTheme.gray.withOpacity(0.3)))),
                              child: Center(
                                  child: Text(fonts.addWallPaper.tr,
                                      style: AppCss.muktaVaaniSemiBold16
                                          .textColor(appCtrl.appTheme.blackColor)))),
                          const VSpace(Sizes.s10),

                          //const VSpace(Sizes.s10),
                          //ImageLayout(image:wallpaperCtrl.imageUrl,).height(wallpaperCtrl.isUploadSize ? Sizes.s150  : wallpaperCtrl.imageUrl.isNotEmpty ?Sizes.s150 : Sizes.s50),
                         /* DarkImageLayout(image:wallpaperCtrl.imageUrl2,).height(wallpaperCtrl.isDarkUploadFile2 ? Sizes.s150  : wallpaperCtrl.imageUrl2.isNotEmpty ?Sizes.s150 : Sizes.s50),*/
                         /* Row(
                            children: [
                               Expanded(child:),
                               const HSpace(Sizes.s15),
                               Expanded(child: DarkImageLayout(image: wallpaperCtrl.imageUrl2,)),
                            ],
                          ),*/
                          const VSpace(Sizes.s10),
                          if (wallpaperCtrl.isUploadSize)
                            Column(children: [
                              const VSpace(Sizes.s5),
                              Text(fonts.imageError.tr,
                                  style: AppCss.muktaVaaniMedium12
                                      .textColor(appCtrl.appTheme.redColor))
                            ]),
                          const VSpace(Sizes.s25),
                          CommonButton(
                              icon: wallpaperCtrl.isLoading
                                  ? CircularProgressIndicator(
                                  color: appCtrl.appTheme.white)
                                  .paddingSymmetric(vertical: Insets.i10)
                                  : Container(),
                              title: wallpaperCtrl.characterId != "" ? fonts.update.tr: fonts.submit.tr,
                              onTap: () => wallpaperCtrl.characterId != "" ? wallpaperCtrl.addData() :wallpaperCtrl.uploadFile(),
                              style: AppCss.muktaVaaniRegular12
                                  .textColor(appCtrl.appTheme.white)),
                          const VSpace(Sizes.s15)
                        ]),
                        Positioned(
                            right: 15.0,
                            top: 15.0,
                            child: InkResponse(
                                onTap: () => Navigator.of(context).pop(),
                                child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: appCtrl.appTheme.primary,
                                    child: Icon(Icons.close,
                                        size: 18, color: appCtrl.appTheme.white))))
                      ]))),
              CustomSnackBar(isAlert: wallpaperCtrl.isAlert)
            ]);
          });
        });
  }
}
