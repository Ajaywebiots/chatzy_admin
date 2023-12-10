import 'package:google_fonts/google_fonts.dart';

import '../../../../config.dart';

class LoginCommonClass {
  //login body
  Widget loginBody({Widget? child}) => Center(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Insets.i15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 32,
                  color: Color.fromRGBO(127, 131, 132, 0.06),
                )
              ]),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: child)));

  //logo layout
  Widget logoLayout({String? image}) =>Image.asset(image!,
      height: Sizes.s50, fit: BoxFit.fill);

  //title layout
  Widget titleLayout({String? title}) => Text(title.toString().tr,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: appCtrl.appTheme.blackColor,
            letterSpacing: .4
          ))
      .alignment(Alignment.centerLeft);

  //forgot password
  Widget forgotPassword() => IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Icon(Icons.lock,
                size: Sizes.s15, color: appCtrl.appTheme.blackColor),
            const HSpace(Sizes.s5),
            Text(fonts.forgotPassword.tr,
                style:
                    AppCss.manropeblack16.textColor(appCtrl.appTheme.blackColor))
          ]));
}
