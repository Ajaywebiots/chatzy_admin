import 'package:chatzy_admin/screens/report/layouts/report_list_layout.dart';
import 'package:chatzy_admin/screens/report/layouts/user_mobile_layout.dart';

import '../../config.dart';

class Report extends StatelessWidget {
  final reportCtrl = Get.put(ReportController());

  Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(collectionName.report)
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.data!.docs.isNotEmpty) {
                    reportCtrl.lastVisible = snapShot.data!.docs.length - 1;
                    reportCtrl.lastIndexId =
                        snapShot.data!.docs[snapShot.data!.docs.length - 1].id;
                  }
                  return Responsive.isDesktop(context)
                      ? UserListLayout(
                          snapShot: snapShot,
                        )
                      : UserMobileLayout(snapShot: snapShot);
                } else {
                  return Container();
                }
              }),
        ],
      ).paddingAll(Insets.i25).boxExtension();
    });
  }
}
