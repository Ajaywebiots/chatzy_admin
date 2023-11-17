

import 'package:chatzy_admin/widgets/common_widget_class.dart';

import '../../../config.dart';

class WallpaperWidgetClass {
  //table title
  TableRow tableWidget() => TableRow(
          decoration:  BoxDecoration(
            color: appCtrl.appTheme.primary ,
          ),
          children: [
            CommonWidgetClass().commonTitleText(fonts.id),
            CommonWidgetClass().commonTitleText(fonts.image),
            CommonWidgetClass().commonTitleText(fonts.action),

          ]);

  //action layout
  Widget actionLayout({GestureTapCallback? onTap,deleteTap}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.edit, color: appCtrl.appTheme.primary).inkWell(
              onTap:onTap),
          Icon(Icons.delete, color: appCtrl.appTheme.primary).inkWell(
              onTap: deleteTap)
        ])
      ]);
}
