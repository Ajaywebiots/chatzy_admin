import 'package:chatzy_admin/screens/dashboard/layouts/dashboard_title_count.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../../../config.dart';

class DashboardBoxLayout extends StatelessWidget {
  final int? index;

  const DashboardBoxLayout({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          SmoothContainer(
              color: appCtrl.appTheme.whiteColor,
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.i22, vertical: Insets.i23),

              smoothness: .6,
              borderRadius: BorderRadius.circular(Insets.i8),
              side: BorderSide(
                  color: appCtrl.appTheme.textBoxColor.withOpacity(.15)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashboardTitleCount(
                              count: index == 0
                                  ? dashboardCtrl.totalUser.toString()
                                  : index == 1
                                      ? dashboardCtrl.totalCalls.toString()
                                      : index == 2
                                          ? dashboardCtrl.videoCall.toString()
                                          : dashboardCtrl.audioCall.toString(),
                              title: dashboardCtrl.listItem[index!]["title"]
                                  .toString()
                                  .tr),
                          MediaQuery.of(context).size.width < 1420
                              ? Expanded(
                                  child: SvgPicture.asset(
                                  svgAssets.dashicon,
                                  height:
                                      MediaQuery.of(context).size.width < 1420
                                          ? Sizes.s40
                                          : Sizes.s60,
                                ))
                              : SvgPicture.asset(
                                  svgAssets.dashicon,
                                  height: Sizes.s60,
                                )
                        ])
                  ])).boxExtension(),
          SmoothContainer(
            height: Sizes.s50,
            width: 4,
            color: appCtrl.appTheme.primary,
            smoothness: .6,
            borderRadius: BorderRadius.circular(Insets.i8),
          )
        ],
      );
    });
  }
}
