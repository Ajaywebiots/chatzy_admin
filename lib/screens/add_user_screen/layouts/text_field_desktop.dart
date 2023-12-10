import '../../../config.dart';

class TextFieldDesktop extends StatelessWidget {
  final String? title, hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const TextFieldDesktop(
      {Key? key,
      this.title,
      this.controller,
      this.validator,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width < 1500 ? Sizes.s230 : Sizes.s350,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title!.tr,
              style:
                  AppCss.manropeBold16.textColor(appCtrl.appTheme.blackColor)),
          const VSpace(Sizes.s10),
          CommonTextBox(
              controller: controller,
              validator: validator,
              hinText: hintText!.tr)
        ]));
  }
}
