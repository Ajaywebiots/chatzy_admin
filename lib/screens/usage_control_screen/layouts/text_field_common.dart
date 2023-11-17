import '../../../config.dart';

class MobileTextFieldCommon extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final bool? isNote;

  const MobileTextFieldCommon(
      {Key? key, this.title, this.controller, this.validator, this.isNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title!.tr,
            style: AppCss.muktaVaaniSemiBold16
                .textColor(appCtrl.appTheme.blackColor)),
        if (isNote == true)
          SizedBox(
              width: Sizes.s140,
              child: Text(fonts.note.tr,
                  style: AppCss.muktaVaaniSemiBold12
                      .textColor(appCtrl.appTheme.error)
                      .textHeight(1.2)))
      ]),
      const HSpace(Sizes.s10),
      SizedBox(
              width: Sizes.s90,
              child: TextFormField(
                  style: TextStyle(color: appCtrl.appTheme.blackColor),
                  validator: validator,
                  cursorColor: appCtrl.appTheme.primary,
                  controller: controller!,
                  decoration: InputDecoration(
                      errorStyle: AppCss.muktaVaaniMedium10,
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: appCtrl.appTheme.primary, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: appCtrl.appTheme.primary)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: Insets.i10, horizontal: Insets.i10),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: appCtrl.appTheme.primary)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: appCtrl.appTheme.primary)))))
          .paddingOnly(right: Insets.i10)
    ]).paddingOnly(bottom: Insets.i20);
  }
}
