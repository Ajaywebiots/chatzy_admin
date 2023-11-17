import 'package:chatzy_admin/widgets/common_switcher.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';

import '../../../config.dart';

class UserListMobileLayout extends StatelessWidget {
  final dynamic data;
  final String? id;
  const UserListMobileLayout({Key? key,this.data,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    CommonWidgetClass().commonValueText("${fonts.reportFrom.tr} - "),
                    CommonWidgetClass().commonValueText(
                        data!["email"] ?? "-"),
                  ]),
                  Row(children: [
                    CommonWidgetClass().commonValueText("${fonts.reportTo.tr} - "),
                    CommonWidgetClass().commonValueText(
                        data!["name"] ?? "Not Defined")
                  ]).marginSymmetric(vertical: Insets.i5),
                  Row(children: [
                    CommonWidgetClass().commonValueText("${fonts.dateTime.tr} - "),
                    CommonWidgetClass().commonValueText(
                        data!["phone"] ?? "Not Defined")
                  ])
                ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  CommonSwitcher(
                      isActive: data!["isActive"] ?? true,
                      onToggle: (val) async {
                        bool isLoginTest =
                        appCtrl.storage.read(session.isLoginTest);
                        if (isLoginTest) {
                          accessDenied(fonts.modification.tr);
                        } else {
                          await FirebaseFirestore.instance
                              .collection(collectionName.users)
                              .doc(id!)
                              .update({"isActive": val});
                        }
                      })
                ])
          ]).paddingAll(Insets.i10),
    );
  }
}
