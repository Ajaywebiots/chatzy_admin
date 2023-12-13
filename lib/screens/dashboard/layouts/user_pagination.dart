

import 'dart:developer';

import 'package:chatzy_admin/screens/dashboard/layouts/arrow_back.dart';
import 'package:chatzy_admin/screens/dashboard/layouts/arrow_forward.dart';

import '../../../config.dart';

class UserPagination extends StatelessWidget {
  const UserPagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: Insets.i15),
              child: Text(
                fonts.rowPerPage.tr,
                style:
                AppCss.manropeMedium14.textColor(appCtrl.appTheme.primary),
              )),

          Container(
              padding: const EdgeInsets.symmetric(horizontal: Insets.i15),
              child: Text(
                "${dashboardCtrl.currentPage} - ${dashboardCtrl.currentPerPage} of ${dashboardCtrl.total}",
                style: AppCss.manropeMedium14
                    .textColor(appCtrl.appTheme.blackColor),
              )),
          ArrowBack(
            onPressed: dashboardCtrl.currentPage == 1
                ? null
                : () {
              var nextSet = dashboardCtrl.currentPage -
                  dashboardCtrl.currentPerPage!;
              dashboardCtrl.currentPage = nextSet > 1 ? nextSet : 1;
              dashboardCtrl.resetData(
                  start: dashboardCtrl.currentPage - 1);
              dashboardCtrl.update();
            },
          ),
          ArrowForward(
              onPressed: dashboardCtrl.currentPage + dashboardCtrl.currentPerPage! - 1 >
                  dashboardCtrl.total
                  ? null
                  : () {
                var nextSet =
                    dashboardCtrl.currentPage + dashboardCtrl.currentPerPage!;
                dashboardCtrl.currentPage = nextSet < dashboardCtrl.total
                    ? nextSet
                    : dashboardCtrl.total - dashboardCtrl.currentPerPage!;
                dashboardCtrl.resetData(start: nextSet - 1);
                dashboardCtrl.getChatsFromRefs();
                dashboardCtrl.update();
              })
        ],
      );
    });
  }
}
