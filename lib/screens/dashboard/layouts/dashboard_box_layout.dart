import 'package:chatzy_admin/screens/dashboard/layouts/dashboard_title_count.dart';
import 'package:figma_squircle/figma_squircle.dart';
import '../../../config.dart';

class DashboardBoxLayout extends StatelessWidget {
  final int? index;

  const DashboardBoxLayout({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return Container(
              height: Sizes.s150,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: const Alignment(8, 9),
                      end: const Alignment(-9, -8),
                      colors: [
                        appCtrl.appTheme.primary.withOpacity(.1),
                        Colors.white,
                        Colors.white
                      ]),
                  borderRadius: BorderRadius.circular(Insets.i16)),
              padding: const EdgeInsets.all(Insets.i40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Container(
                              padding: EdgeInsets.all(Insets.i15),
                              decoration: ShapeDecoration(
                                  color: appCtrl.appTheme.primary,
                                  shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                          cornerRadius: 15,
                                          cornerSmoothing: 2))),
                              child: SvgPicture.asset(
                                dashboardCtrl.listItem[index!]["icon"],
                                height: Sizes.s30,
                                color: appCtrl.appTheme.white,
                              ))
                        ])
                  ]))
          .paddingAll(Insets.i4)
          .decorated(
              borderRadius: BorderRadius.circular(Insets.i18),
              boxShadow: [
                const BoxShadow(
                    color: Color.fromRGBO(49, 100, 189, 0.07), blurRadius: 20)
              ],
              color: appCtrl.appTheme.whiteColor);
    });
  }
}
