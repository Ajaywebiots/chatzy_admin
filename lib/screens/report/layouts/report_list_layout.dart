

import 'package:chatzy_admin/screens/report/layouts/user_list_widget_class.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';
import 'package:intl/intl.dart';

import '../../../config.dart';

class UserListLayout extends StatelessWidget {
  final AsyncSnapshot<dynamic>? snapShot;

  const UserListLayout({Key? key, this.snapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name ="";
    return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r6),
        child: Table(columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
        }, children: [
          UserListWidgetClass().tableRow(),
          ...snapShot!.data!.docs.asMap().entries.map((e) {
            return TableRow(children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(collectionName.users)
                      .doc(e.value.data()["reportFrom"])
                      .snapshots(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      name = snap.data!.data()!["name"];
                      return CommonWidgetClass()
                          .commonValueText(snap.data!.data()!["name"])
                          .marginSymmetric(
                              vertical: Insets.i10, horizontal: Insets.i10);
                    } else {
                      return CommonWidgetClass()
                          .commonValueText("")
                          .marginSymmetric(
                              vertical: Insets.i10, horizontal: Insets.i10);
                    }
                  }),
              e.value.data()["isSingleChat"] == true
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(collectionName.users)
                          .doc(e.value.data()["reportTo"])
                          .snapshots(),
                      builder: (context, snap) {

                        if (snap.hasData) {
                          name = snap.data!.data()!["name"];
                          return CommonWidgetClass()
                              .commonValueText(snap.data!.data()!["name"])
                              .marginSymmetric(
                                  vertical: Insets.i10, horizontal: Insets.i10);
                        } else {
                          return CommonWidgetClass()
                              .commonValueText("")
                              .marginSymmetric(
                                  vertical: Insets.i10, horizontal: Insets.i10);
                        }
                      })
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(collectionName.groups)
                          .doc(e.value.data()["reportTo"])
                          .snapshots(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return CommonWidgetClass()
                              .commonValueText(snap.data!.data()!["name"])
                              .marginSymmetric(
                                  vertical: Insets.i10, horizontal: Insets.i10);
                        } else {
                          return CommonWidgetClass()
                              .commonValueText("")
                              .marginSymmetric(
                                  vertical: Insets.i10, horizontal: Insets.i10);
                        }
                      }),
              CommonWidgetClass()
                  .commonValueText(e.value.data()["isSingleChat"] == true
                      ? "Single"
                      : "Group")
                  .marginSymmetric(vertical: Insets.i10),
              CommonWidgetClass()
                  .commonValueText(DateFormat('HH:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(int.parse(
                              e.value.data()['timestamp'].toString()))) )
                  .marginSymmetric(vertical: Insets.i10),
              CommonWidgetClass().actionLayout(
                  onTap: () {

                    accessDenied(
                        "Are you sure you want to Delete the ${e.value.data()["isSingleChat"] == true ? "$name user" : "Group"}",
                        isModification: false,isDelete: true,
                        onTap: () => appCtrl.deleteAccount(
                            e.value.data()["reportTo"],
                            e.value.data()["isSingleChat"]));
                  },
                  isUser: true)
            ]);
          }).toList()
        ]).decorated(

            borderRadius: BorderRadius.circular(AppRadius.r6)));
  }
}
