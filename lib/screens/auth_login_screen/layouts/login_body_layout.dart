import 'package:chatzy_admin/widgets/common_widget_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config.dart';

class LoginBodyLayout extends StatelessWidget {
  const LoginBodyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (loginCtrl) {
      return Form(
          key: loginCtrl.formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                LoginCommonClass().logoLayout(image: imageAssets.logo),
                const VSpace(Sizes.s15),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: fonts.welcomeBack.tr,
                      style: AppCss.manropeSemiBold26
                          .textColor(appCtrl.appTheme.blackText)),
                  TextSpan(
                      text: " ${fonts.chatzy.tr}",
                      style: AppCss.manropeSemiBold26
                          .textColor(appCtrl.appTheme.primary))
                ])),
                const VSpace(Sizes.s8),
                Text(fonts.helloAgain.tr,
                    textAlign: TextAlign.center,
                    style: AppCss.manropeMedium14
                        .textColor(appCtrl.appTheme.textBoxColor)),
                const VSpace(Sizes.s42),
                LoginCommonClass().titleLayout(title: fonts.email),
                const VSpace(Sizes.s12),
                CommonTextBox(
                    controller: loginCtrl.txtName,
                    validator: (val) =>
                        LoginValidator().checkNameValidation(val),
                    hinText: fonts.enterYourEmail.tr,
                    labelText: fonts.email.tr),
                const VSpace(Sizes.s30),
                LoginCommonClass().titleLayout(title: fonts.password),
                const VSpace(Sizes.s12),
                CommonTextBox(
                    maxLines: 1,
                    controller: loginCtrl.txtPassword,
                    obscureText: loginCtrl.obscureText,
                    validator: (val) =>
                        LoginValidator().checkPasswordValidation(val),
                    suffixIcon: SvgPicture.asset(
                      svgAssets.eye,
                    ).paddingSymmetric(horizontal: Insets.i10).inkWell(onTap: () {
                      loginCtrl.obscureText = !loginCtrl.obscureText;
                      loginCtrl.update();
                    }),
                    hinText: fonts.enterPassword.tr,
                    labelText: fonts.password.tr),
                const VSpace(Sizes.s40),
                CommonButton(
                    title: fonts.signIn.tr,
                    margin: 0,
                    onTap: () => loginCtrl.signIn(context),
                    padding: 0,
                    radius: 12,
                    height: Sizes.s50,
                    style: AppCss.manropeMedium14
                        .textColor(appCtrl.appTheme.white)),
                const VSpace(Sizes.s15),
                Text(
                  fonts.sendSmsCode.tr,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    letterSpacing: .4,
                    color: appCtrl.appTheme.textBoxColor
                  ),
                ),
                const VSpace(Sizes.s40),
              ],
            ).paddingSymmetric(horizontal: Insets.i50),
            Image.asset(imageAssets.dottedDivider),
            Column(
              children: [
                const VSpace(Sizes.s35),
                CommonWidgetClass().credentialCopy(fonts.email.tr,"admin@gmail.com",context),
                const VSpace(Sizes.s12),
                CommonWidgetClass().credentialCopy(fonts.password.tr,"Admin1234",context),
              ],
            ).paddingSymmetric(horizontal: Insets.i50)
          ]).paddingOnly(top: Insets.i50,bottom: Insets.i30));
    });
  }
}
