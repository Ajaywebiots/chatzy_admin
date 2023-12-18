import 'dart:developer';

import 'package:chatzy_admin/screens/dashboard/layouts/arrow_back.dart';
import 'package:chatzy_admin/screens/dashboard/layouts/arrow_forward.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config.dart';

class UserPagination extends StatelessWidget {
  const UserPagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (dashboardCtrl.isDisplay)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: Insets.i15),
                child: SelectableText(
                  "${dashboardCtrl.currentPage} - ${dashboardCtrl.currentPerPage} of ${dashboardCtrl.total}",
                  style: TextStyle(
                    color: appCtrl.isTheme
                        ? appCtrl.appTheme.white
                        : appCtrl.appTheme.blackText,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                )),
          ArrowBack(
            onPressed: dashboardCtrl.currentPage == 1
                ? null
                : () {
                    dashboardCtrl.count = 0;
                    dashboardCtrl.listenToChatsRealTime(isPrevious: true);
                    var nextSet = dashboardCtrl.currentPage -
                        dashboardCtrl.currentPerPage!;
                    dashboardCtrl.currentPage = nextSet > 1 ? nextSet : 1;
                    dashboardCtrl.update();
                  },
          ),
          ArrowForward(
              onPressed: dashboardCtrl.currentPage +
                          dashboardCtrl.currentPerPage! -
                          1 >
                      dashboardCtrl.total
                  ? null
                  : () {
                      dashboardCtrl.count = 0;
                      dashboardCtrl.listenToChatsRealTime(isPrevious: false);
                      var nextSet = dashboardCtrl.currentPage +
                          dashboardCtrl.currentPerPage!;
                      dashboardCtrl.currentPage = nextSet < dashboardCtrl.total
                          ? nextSet
                          : dashboardCtrl.total - dashboardCtrl.currentPerPage!;
                      dashboardCtrl.resetData(start: nextSet - 1);
                      dashboardCtrl.update();
                    })
        ],
      );
    });
  }
}
