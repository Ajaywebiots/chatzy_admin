import 'dart:ui';
import '../../../../config.dart';


class LoginLayout extends StatelessWidget {
  const LoginLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
margin: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context) ?0: Insets.i20),
          width: 547,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: appCtrl.appTheme.whiteColor,
            border: Border.all(color: appCtrl.appTheme.border.withOpacity(.28))
          ),
          child: const LoginBodyLayout()),
    )
    ;
  }
}
