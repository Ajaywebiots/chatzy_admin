import 'package:chatzy_admin/widgets/common_widget_class.dart';
import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class LoginBodyLayout extends StatelessWidget {
  const LoginBodyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (loginCtrl) {
      return Form(
          key: loginCtrl.formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const VSpace(Sizes.s20),
            LoginCommonClass().logoLayout(image: imageAssets.logo),
            const VSpace(Sizes.s20),
            Text(fonts.welcomeBack.tr,
                style: AppCss.muktaVaaniblack28
                    .textColor(appCtrl.appTheme.blackColor)),
            const VSpace(Sizes.s10),
            Text(fonts.helloAgain.tr,
                    textAlign: TextAlign.center,
                    style: AppCss.muktaVaaniSemiBold14
                        .textColor(appCtrl.appTheme.contentColor))
                .paddingSymmetric(horizontal: Insets.i25),
            const VSpace(Sizes.s25),
            LoginCommonClass().titleLayout(title: fonts.email),
            const VSpace(Sizes.s8),
            CommonTextBox(
                controller: loginCtrl.txtName,
                validator: (val) => LoginValidator().checkNameValidation(val),
                hinText: fonts.enterYourEmail.tr,
                labelText: fonts.email.tr),
            const VSpace(Sizes.s22),
            LoginCommonClass().titleLayout(title: fonts.password),
            const VSpace(Sizes.s8),
            CommonTextBox(
                maxLines: 1,
                controller: loginCtrl.txtPassword,
                obscureText: loginCtrl.obscureText,
                validator: (val) =>
                    LoginValidator().checkPasswordValidation(val),
                suffixIcon: Icon(
                        loginCtrl.obscureText
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye,
                        size: Sizes.s20)
                    .inkWell(onTap: () {
                  loginCtrl.obscureText = !loginCtrl.obscureText;
                  loginCtrl.update();
                }),
                hinText: fonts.enterPassword.tr,
                labelText: fonts.password.tr),
            const VSpace(Sizes.s30),
            CommonButton(
                title: fonts.signIn.tr,
                margin: 0,
                onTap: () => loginCtrl.signIn(context),
                padding: 0,
                height: Sizes.s35,
                style: AppCss.muktaVaaniMedium14.textColor(appCtrl.appTheme.white)),
            const VSpace(Sizes.s40),
            CommonWidgetClass().credentialCopy("admin@gmail.com"),
            const VSpace(Sizes.s5),
            CommonWidgetClass().credentialCopy("Admin1234"),
          ]));
    });
  }
}
