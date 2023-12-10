import '../../../../config.dart';

class CommonTextBox extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hinText;
  final String labelText;
  final InputBorder? border;
  final Color? fillColor;
  final FormFieldValidator<String>? validator;
  final bool filled;
  final bool obscureText;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  final String? errorText;
  final int? maxLength;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;

  const CommonTextBox(
      {Key? key,
        this.controller,
        this.suffixIcon,
        this.prefixIcon,
        this.border,
        this.hinText = "",
        this.labelText = "",
        this.fillColor,
        this.validator,
        this.focusNode,
        this.errorText,
        this.obscureText = false,
        this.readOnly = false,
        this.keyboardType,
        this.textInputAction,
        this.maxLength,
        this.maxLines,
        this.onTap,
        this.onFieldSubmitted,
        this.onChanged,
        this.filled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r5),
      borderSide: BorderSide(
          style: BorderStyle.solid, color: appCtrl.appTheme.textBoxColor.withOpacity(.15)),
    );
    return GetBuilder<AppController>(builder: (appCtrl) {
      return TextFormField(
          maxLines: maxLines ?? 1,
          style: AppCss.manropeSemiBold14.textColor(appCtrl.appTheme.textBoxColor),
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          onChanged: onChanged,

          maxLength: maxLength,
          decoration: InputDecoration(

              fillColor: fillColor ?? appCtrl.appTheme.textBoxColor.withOpacity(0.05),
              filled: true,
              isDense: true,
              disabledBorder: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8)),
                  borderSide: BorderSide(width: 1, color: appCtrl.appTheme.borderColor)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8)),
                  borderSide: BorderSide(width: 1, color: appCtrl.appTheme.borderColor)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8)),
                  borderSide: BorderSide(width: 1, color: appCtrl.appTheme.borderColor)
              ),
              border:
              OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8)),
                  borderSide: BorderSide(width: 1, color: appCtrl.appTheme.borderColor)),
              contentPadding:  EdgeInsets.symmetric(
                  horizontal: Insets.i15, vertical:  Insets.i20),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintStyle: AppCss.manropeMedium14.textColor(appCtrl.appTheme.textBoxColor),
              hintText: hinText));
    });
  }
}
