
import 'package:chatzy_admin/widgets/common_widget_class.dart';

import '../../../config.dart';

class UserListWidgetClass{

  //table row
  TableRow tableRow() =>TableRow(
      decoration: BoxDecoration(
        color: appCtrl.appTheme.primary,

      ),
      children: [
        CommonWidgetClass().commonTitleText(fonts.reportFrom),
        CommonWidgetClass().commonTitleText(fonts.reportTo),
        CommonWidgetClass().commonTitleText(fonts.isSingleChat),
        CommonWidgetClass().commonTitleText(fonts.dateTime),
        CommonWidgetClass().commonTitleText(fonts.actions)
      ]);
}