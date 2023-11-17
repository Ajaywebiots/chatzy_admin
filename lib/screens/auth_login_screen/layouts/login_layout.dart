import 'dart:ui';
import '../../../../config.dart';


class LoginLayout extends StatelessWidget {
  const LoginLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginCommonClass().loginBody(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 450, maxHeight: 700),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r15),
                    color: appCtrl.appTheme.whiteColor),
                child: const Padding(
                    padding:  EdgeInsets.all(Insets.i35),
                    child: SingleChildScrollView(
                        child: LoginBodyLayout())))));
  }
}
