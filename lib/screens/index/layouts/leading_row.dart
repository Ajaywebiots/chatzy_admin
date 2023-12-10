import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';

import '../../../config.dart';

class LeadingRow extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldDrawerKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const LeadingRow({Key? key, this.scaffoldKey, this.scaffoldDrawerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(builder: (indexCtrl) {
      return Row(children: [
        ValueListenableBuilder<bool>(
            valueListenable: indexCtrl.isOpen,
            builder: (context, value, child) {
              if (Responsive.isDesktop(context) && value) {
                return InkWell(
                    onTap: () {
                      log("message");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: appCtrl.appTheme.blackText,
                        width: value ? Sizes.s220 : Sizes.s70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(imageAssets.logo,height: Sizes.s30,
                              fit: BoxFit.contain),
                          const HSpace(Sizes.s10),
                          Image.asset(imageAssets.logo1,height: Sizes.s28,
                              fit: BoxFit.contain),
                        ],
                      )
                    ));
              }
              return InkWell(
                  onTap: () {
                    log("message : ${indexCtrl.scaffoldDrawerKey}");
                    scaffoldDrawerKey!.currentState?.closeDrawer();
                  },
                  child: Responsive.isDesktop(context)
                      ? Container(
                          width: Sizes.s70,
                          padding: const EdgeInsets.all(Insets.i10),
                          color: appCtrl.appTheme.dark,
                          height: double.infinity,
                          child:  Image.asset(imageAssets.logo,
                              fit: BoxFit.contain))
                      : Container());
            }),
        MaterialButton(
            height: double.infinity,
            hoverColor: Colors.transparent,
            onPressed: () async {
              log("messageMaterial : $scaffoldDrawerKey");
              if (Responsive.isMobile(context) ||
                  Responsive.isTablet(context)) {
                if (scaffoldKey!.currentState!.isDrawerOpen) {
                  scaffoldKey!.currentState!.closeDrawer();
                } else {
                  scaffoldKey!.currentState!.openDrawer();
                }
              } else if (Responsive.isDesktop(context)) {
                scaffoldKey!.currentState!.closeDrawer();
                indexCtrl.isOpen.value = !indexCtrl.isOpen.value;
              }
            },
            child: Icon(Icons.menu, color: appCtrl.appTheme.blackColor)),
        if(Responsive.isDesktop(context))
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(indexCtrl.pageName.tr,
                        style:GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          color: appCtrl.appTheme.blackColor,
                          fontSize: 18
                        )),

                    Row(children: [
                      InkWell(
                          mouseCursor:
                          SystemMouseCursors.click,
                          child: Text(fonts.admin.tr,
                              style: GoogleFonts.manrope(
      fontWeight: FontWeight.normal,
      color: appCtrl.appTheme.textBoxColor,
      fontSize: 14
      ))),
                      Text('  /  ',
                         style:GoogleFonts.manrope(
                          fontWeight: FontWeight.normal,
                          color: appCtrl.appTheme.textBoxColor,
                          fontSize: 14
                        )),
                      Text(indexCtrl.pageName.tr,
                         style:GoogleFonts.manrope(
                          fontWeight: FontWeight.normal,
                          color: appCtrl.appTheme.textBoxColor,
                          fontSize: 14
                        ))
                    ])
                  ]),
              GetBuilder<AppController>(builder: (context) {
                return CustomSnackBar(
                    isAlert: appCtrl.isAlert);
              })
            ]).paddingOnly(top: Insets.i18)
      ]);
    });
  }
}
