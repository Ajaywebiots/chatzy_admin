import 'package:chatzy_admin/screens/report/layouts/user_list_mobile_layout.dart';

import '../../../config.dart';

class UserMobileLayout extends StatelessWidget {
  final AsyncSnapshot<dynamic>? snapShot;

  const UserMobileLayout({Key? key, this.snapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(builder: (userCtrl) {
      return Column(children: [
        ...snapShot!.data!.docs.asMap().entries.map((e) {
          return UserListMobileLayout(
            data: e.value.data(),
            id: e.value.id,
          ).marginOnly(bottom: Insets.i15);
        }).toList()
      ]);
    });
  }
}
