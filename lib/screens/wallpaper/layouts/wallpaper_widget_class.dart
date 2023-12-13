

import 'package:chatzy_admin/widgets/common_widget_class.dart';

import '../../../config.dart';

class WallpaperWidgetClass {
  //table title
  TableRow tableWidget() => TableRow(
          decoration:  BoxDecoration(
            color: appCtrl.appTheme.textBoxColor.withOpacity(.06)
          ),
          children: [
            CommonWidgetClass().commonTitleText(fonts.type),
            CommonWidgetClass().commonTitleText(fonts.image),
            CommonWidgetClass().commonTitleText(fonts.action),

          ]);

  //action layout
  Widget actionLayout({GestureTapCallback? onTap,deleteTap}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(svgAssets.edit).inkWell(
              onTap:onTap),
        const HSpace(Sizes.s20),
        SvgPicture.asset(svgAssets.delete).inkWell(
              onTap: deleteTap)
        ])
      ]);
}
