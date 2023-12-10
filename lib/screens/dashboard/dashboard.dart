import 'package:chatzy_admin/screens/dashboard/layouts/dashboard_box_layout.dart';
import 'package:chatzy_admin/screens/dashboard/layouts/user_layout.dart';
import 'package:chatzy_admin/screens/dashboard/layouts/user_pagination.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../config.dart';

class Dashboard extends StatelessWidget {
  final dashboardCtrl = Get.put(DashboardController());

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    gridDelegate: Responsive.isMobile(context)
                        ? const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 100,
                    )
                        : MediaQuery.of(context).size.width < 1500
                        ? const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 180,
                    )
                        : SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 120,
                    ),
                    itemCount: dashboardCtrl.listItem.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DashboardBoxLayout(index: index);
                    }),
              ),
              const VSpace(Sizes.s20),
              SmoothContainer(
                  color: appCtrl.appTheme.white,

                  padding: EdgeInsets.symmetric(
                      horizontal: Insets.i22, vertical: Insets.i23),
                  smoothness: 1,
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
                            Text("Recent Join",style: GoogleFonts.manrope(fontWeight: FontWeight.w800,fontSize: 20,color: appCtrl.appTheme.blackText),),
                            CommonTextBox(
                                controller: dashboardCtrl.textSearch,
onChanged: (value)=>dashboardCtrl.filterData(value),
                                hinText: fonts.searchHere.tr).width(514),
                          ],
                        ),
                        const VSpace(Sizes.s20),
                        StreamBuilder(
                            stream: dashboardCtrl.textSearch.text.isNotEmpty
                                ? dashboardCtrl.getChatsFromRefs()
                                : FirebaseFirestore.instance
                                .collection(collectionName.users)
                                .limit(dashboardCtrl.currentPerPage!)
                                .snapshots(),
                            builder: (context, snapShot) {
                              if (snapShot.hasData) {
                                if(snapShot.data.docs.length > 0) {
                                  dashboardCtrl.lastVisible = snapShot.data.docs.length - 1;
                                  dashboardCtrl.lastIndexId =
                                      snapShot.data.docs[snapShot.data.docs.length - 1].id;
                                }
                                return UserLayoutDesktop(snapShot: snapShot);
                              } else {
                                return Container();
                              }
                            }),
                        const VSpace(Sizes.s20),
                        const UserPagination()
                      ])),
            ],
          );
        }
      );
    });
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
