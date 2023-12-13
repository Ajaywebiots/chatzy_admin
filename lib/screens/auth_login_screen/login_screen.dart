import '../../config.dart';

class LoginScreen extends StatelessWidget {
  final loginCtrl = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (_) {
          return Scaffold(
              backgroundColor: appCtrl.appTheme.loginBg,
              body: Stack(
                children: [
                  /* Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        imageAssets.loginBg1,
                        height: Sizes.s180,
                        width: Sizes.s160,
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        imageAssets.loginBg2,
                        width: Sizes.s180,
                        height: Sizes.s100,
                        fit: BoxFit.fill,
                      ).paddingOnly(right: Insets.i20)),*/
                  Image.asset(
                    imageAssets.loginBg,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                  /*Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 4,
                        width: 1300,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: appCtrl.appTheme.textBoxColor
                                      .withOpacity(.30),
                                ))))

                        .paddingOnly(top: MediaQuery.of(context).size.height /2.2),
                  )*/
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(imageAssets.loginBg5,width: 1250,height: 500,fit: BoxFit.fill).paddingOnly( bottom:
                      MediaQuery.of(context).size.height / 10.5)),
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /*if (Responsive.isDesktop(context))
                            Image.asset(
                              imageAssets.loginBg3,
                              height: Sizes.s500,
                              fit: BoxFit.fill,
                            ).paddingOnly(
                                bottom:
                                MediaQuery.of(context).size.height / 10.5),*/

                          Row(
                            children: [
                              Responsive.isDesktop(context)
                                  ? const LoginLayout()
                                  : const Expanded(child: LoginLayout()),
                              /* if (Responsive.isDesktop(context))
                                Image.asset(
                                  imageAssets.loginBg4,
                                  height: Sizes.s500,
                                ).paddingOnly(
                                    bottom:
                                    MediaQuery.of(context).size.height / 10.5)*/
                            ],
                          )
                        ],
                      )),
                ],
              ));
        }),
      );
    });
  }
}
