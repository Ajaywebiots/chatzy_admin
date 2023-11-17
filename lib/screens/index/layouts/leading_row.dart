import 'dart:developer';
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
                      color: appCtrl.appTheme.dark,
                      child: Image.asset(
                        imageAssets.logo,
                        width: Sizes.s180
                      ).paddingAll(Insets.i20)
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
                          child: Image.asset(imageAssets.logo,
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
                        style: AppCss.muktaVaaniBold16.textColor(
                            appCtrl.appTheme.blackColor)),
                    const VSpace(Sizes.s8),
                    Row(children: [
                      InkWell(
                          mouseCursor:
                          SystemMouseCursors.click,
                          child: Text(fonts.admin.tr,
                              style: AppCss.muktaVaaniMedium12
                                  .textColor(appCtrl
                                  .appTheme.drawerTextColor))),
                      Text('  /  ',
                          style: AppCss.muktaVaaniMedium12
                              .textColor(appCtrl
                              .appTheme.drawerTextColor)),
                      Text(indexCtrl.pageName.tr,
                          style: AppCss.muktaVaaniMedium12
                              .textColor(appCtrl
                              .appTheme.drawerTextColor))
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
