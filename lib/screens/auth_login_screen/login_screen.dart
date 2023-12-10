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
                  Align(
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
                      ).paddingOnly(right: Insets.i20)),
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (Responsive.isDesktop(context))
                            Image.asset(
                              imageAssets.loginBg3,
                              width: 447,
                              height: 500,
                              fit: BoxFit.fill,
                            ).paddingOnly(
                                bottom:
                                    MediaQuery.of(context).size.height / 10.5),
                          Responsive.isDesktop(context)?const LoginLayout():
                          const Expanded(child: LoginLayout()),
                          if (Responsive.isDesktop(context))
                            Image.asset(imageAssets.loginBg4,
                                    width: 447, height: 600)
                                .paddingOnly(
                                    bottom: MediaQuery.of(context).size.height /
                                        18),
                        ],
                      )),
                ],
              ));
        }),
      );
    });
  }
}
