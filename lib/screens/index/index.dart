import '../../config.dart';


class IndexLayout extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldDrawerKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const IndexLayout({Key? key, this.scaffoldDrawerKey, this.scaffoldKey})
      : super(key: key);

  @override
  State<IndexLayout> createState() => _IndexLayoutState();
}

class _IndexLayoutState extends State<IndexLayout> {
  final indexCtrl = Get.put(IndexController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(builder: (_) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: widget.scaffoldKey,
            backgroundColor: appCtrl.isTheme ?appCtrl.appTheme.whiteColor : appCtrl.appTheme.bg1,
            appBar: AppBar(
              toolbarHeight: Sizes.s90,
                elevation: 0.0,
                shadowColor: Colors.transparent,
                centerTitle: false,

                backgroundColor: appCtrl.isTheme ?appCtrl.appTheme.whiteColor : appCtrl.appTheme.bg1,
                leadingWidth: Responsive.isDesktop(context) ? Sizes.s500 : Sizes.s100,
                title: !Responsive.isDesktop(context)
                    ? Text(indexCtrl.pageName.tr,style: AppCss.manropeSemiBold16.textColor(appCtrl.appTheme.blackColor),)
                    : Container(),
                leading:  LeadingRow(scaffoldKey: widget.scaffoldKey,scaffoldDrawerKey: widget.scaffoldDrawerKey),
                actions: const [DarkLanguageLayout( )]),
            drawerScrimColor: Colors.transparent,
            drawer:  IndexDrawer(scaffoldKey: widget.scaffoldKey,),
            body: SafeArea(
                child: Scaffold(
 backgroundColor:  appCtrl.isTheme ?appCtrl.appTheme.whiteColor : appCtrl.appTheme.bgColor,

                    key: widget.scaffoldDrawerKey,
                    body: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<bool>(
                              valueListenable: indexCtrl.isOpen,
                              builder: (context, value, child) {
                                return Responsive.isDesktop(context)
                                    ? Container(
                                    height:
                                    MediaQuery.of(context).size.height,
                                    width: value ? Sizes.s220 : Sizes.s70,
                                   decoration: BoxDecoration(
                                     boxShadow:  [BoxShadow(blurRadius: 20,color: appCtrl.appTheme.gray,spreadRadius: 4)],
                                     color: appCtrl.appTheme.blackText,
                                   ),
                                    child: SingleChildScrollView(
                                        controller: ScrollController(),
                                        child: Column(
                                            crossAxisAlignment: value
                                                ? CrossAxisAlignment.start
                                                : CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Divider(
                                                  thickness: 2,
                                                  color: appCtrl.appTheme.textBoxColor,
                                                  indent: 12,
                                                  endIndent: 12),
                                              const VSpace(Sizes.s10),
                                              DrawerList(value: value,scaffoldKey: widget.scaffoldKey,)
                                            ])))
                                    : const SizedBox.shrink();
                              }),
                          const SelectedIndexBodyLayout()
                        ])))),
      );
    });
  }
}
