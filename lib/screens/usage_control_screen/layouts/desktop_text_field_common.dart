import '../../../config.dart';

class DesktopTextFieldCommon extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final bool? isNote,isAppSettings;
  final double? width;

  const DesktopTextFieldCommon(
      {Key? key, this.title, this.controller, this.validator,this.isNote,this.isAppSettings,this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title!.tr,
          style: AppCss.muktaVaaniMedium18
              .textColor(appCtrl.isTheme ?appCtrl.appTheme.white :appCtrl.appTheme.dark).textHeight(1.5)),
      if(isNote == true)
      Text(fonts.note.tr,
          style: AppCss.muktaVaaniSemiBold12
              .textColor(appCtrl.appTheme.error).textHeight(1.2)),
      const VSpace(Sizes.s15),
      TextFormField(
        style: AppCss.muktaVaaniMedium14.textColor(appCtrl.appTheme.gray),
          validator: validator,

          keyboardType: TextInputType.multiline,
          cursorColor: appCtrl.appTheme.primary,
          controller: controller!,
          decoration: InputDecoration(
                errorStyle: AppCss.muktaVaaniMedium10,
              isDense: true,
              filled: true,
              fillColor: appCtrl.appTheme.gray.withOpacity(0.1),
            border: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide:
                BorderSide(width: 0, style: BorderStyle.none)),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: Insets.i15, horizontal: Insets.i10),
             ))

    ]);
  }
}
