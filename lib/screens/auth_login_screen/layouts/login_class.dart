import '../../../../config.dart';

class LoginCommonClass {
  //login body
  Widget loginBody({Widget? child}) => Center(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Insets.i15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: Colors.black12.withOpacity(0.1),
                )
              ]),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r15),
              child: child)));

  //logo layout
  Widget logoLayout({String? image}) =>Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(image!,
          height: Sizes.s50, fit: BoxFit.fill),const HSpace(Sizes.s10),
      Text(fonts.chatzyAdmin.tr,style: AppCss.muktaVaaniExtraBold18.textColor(appCtrl.appTheme.blackText),),
      ],
  );

  //title layout
  Widget titleLayout({String? title}) => Text(title.toString().tr,
          style: AppCss.muktaVaaniBold16.textColor(appCtrl.appTheme.contentColor))
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
                    AppCss.muktaVaaniblack16.textColor(appCtrl.appTheme.blackColor))
          ]));
}
