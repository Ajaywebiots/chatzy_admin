import 'dart:developer';

import 'package:chatzy_admin/widgets/common_switcher.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';
import 'package:intl/intl.dart';

import '../../../config.dart';

class UserLayoutDesktop extends StatelessWidget {
  final AsyncSnapshot<dynamic>? snapShot;

  const UserLayoutDesktop({Key? key, this.snapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r6),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(flex: 1),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
            4: FlexColumnWidth(),
            5: FlexColumnWidth(),
            6: FlexColumnWidth(),
          },
          children: [
            TableRow(
                decoration: BoxDecoration(
                  color: appCtrl.appTheme.textBoxColor.withOpacity(.06),
                ),
                children: [
                  CommonWidgetClass().commonTitleText(fonts.image),
                  CommonWidgetClass().commonTitleText(fonts.name),
                  CommonWidgetClass().commonTitleText(fonts.email),
                  CommonWidgetClass().commonTitleText(fonts.phoneNumber),
                  CommonWidgetClass().commonTitleText(fonts.joiningDate),
                  CommonWidgetClass().commonTitleText(fonts.activeDeactive),
                  CommonWidgetClass().commonTitleText(fonts.action),
                ]),
            ...snapShot!.data!.docs.asMap().entries.map((e) {

              return TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0x313232).withOpacity(0.15)))),
                  children: [
                    CommonWidgetClass()
                        .commonValueText(e.value.data()["image"] ?? "",
                            isImage: true)

                    ,
                    CommonWidgetClass()
                        .commonValueText(e.value.data()["name"] ?? "-")
                       ,
                    CommonWidgetClass()
                        .commonValueText(e.value.data()["email"] ?? "-")

                    ,
                    CommonWidgetClass()
                        .commonValueText("${e.value.data()["dialCode"] != null ? "(${e.value.data()["dialCode"]}) " :""} ${e.value.data()["phone"].toString().replaceAll(e.value.data()["dialCode"] ?? "", "")}")

                    ,
                    CommonWidgetClass()
                        .commonValueText(e.value.data()["createdDate"] != null
                            ? DateFormat("dd/MM/yyyy")
                                .format(e.value.data()["createdDate"])
                            : "-")

                    ,
                    CommonSwitcher(
                        isActive: e.value.data()["isActive"] ?? true,
                        onToggle: (val) =>
                            dashboardCtrl.userActiveDeActive(e.value.id, val)),
                    /*onToggle: (val) => ddash
                          .isActiveChange(e.value.id, val)*/
                    SvgPicture.asset(svgAssets.delete)
                        .marginSymmetric(vertical: Insets.i15)
                        .inkWell(
                            onTap: () => accessDenied(
                                isDelete: true,
                                fonts.deleteCharacterConfirmation.tr,
                                isModification: false,
                                onTap: () =>
                                    dashboardCtrl.deleteData(e.value.id)))
                  ]);
            }).toList()
          ],
        ).decorated(borderRadius: BorderRadius.circular(AppRadius.r6)),
      );
    });
  }
}
