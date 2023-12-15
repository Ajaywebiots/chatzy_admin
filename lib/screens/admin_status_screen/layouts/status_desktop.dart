import 'dart:developer';

import 'package:chatzy_admin/widgets/common_switcher.dart';
import 'package:chatzy_admin/widgets/common_widget_class.dart';
import 'package:intl/intl.dart';

import '../../../config.dart';

class StatusDesktop extends StatelessWidget {
  final List<PhotoUrl>? snapShot;

  const StatusDesktop({Key? key, this.snapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminStatusController>(builder: (dashboardCtrl) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r6),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(flex: 1),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth()
          },
          children: [
            TableRow(
                decoration: BoxDecoration(
                  color: appCtrl.appTheme.textBoxColor.withOpacity(.06),
                ),
                children: [
                  CommonWidgetClass().commonTitleText(fonts.dateTime),
                  CommonWidgetClass().commonTitleText(fonts.image),
                  CommonWidgetClass().commonTitleText(fonts.statusSeenBy),
                  CommonWidgetClass().commonTitleText(fonts.delete),
                ]),
            ...snapShot!.asMap().entries.map((e) {
              return TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color:
                                  const Color(0xFF313232).withOpacity(0.15)))),
                  children: [

                    CommonWidgetClass().commonValueText(
                        "${DateFormat("dd/MM/yyyy").format( DateTime.fromMillisecondsSinceEpoch(int.parse(e.value.timestamp!)))} | ${DateFormat("hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(e.value.timestamp!)))}"),
                    CommonWidgetClass().commonValueText(
                        e.value.image ?? "",
                        isImage: true),
                    CommonWidgetClass()
                        .commonValueText(e.value.seenBy!.length.toString() ),
                    SvgPicture.asset(svgAssets.delete)
                        .marginSymmetric(vertical: Insets.i15)
                        .inkWell(
                            onTap: () => accessDenied(
                                isDelete: true,
                                fonts.deleteCharacterConfirmation.tr,
                                isModification: false,
                                onTap: () =>
                                    dashboardCtrl.deleteData(e.key)))
                  ]);
            }).toList()
          ],
        ).decorated(borderRadius: BorderRadius.circular(AppRadius.r6)),
      );
    });
  }
}
