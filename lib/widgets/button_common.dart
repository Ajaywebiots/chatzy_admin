import '../config.dart';

class UpdateButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;

  const UpdateButton({Key? key, this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r8)),
            padding: const EdgeInsets.symmetric(
                vertical: Insets.i20, horizontal: Insets.i25),
            backgroundColor: appCtrl.appTheme.primary),
        child: Text(title!.tr,
            style: AppCss.muktaVaaniMedium16.textColor(appCtrl.appTheme.white)));
  }
}
