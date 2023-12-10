import '../config.dart';

class CustomSnackBar extends StatelessWidget {
  final bool isAlert;

  const CustomSnackBar({Key? key, this.isAlert = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isAlert ? Sizes.s42 : 0,
      width:  isAlert ? Sizes.s200 :0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCirc,
      child: FittedBox(
        child: Container(
          height: Sizes.s50,
          width:  isAlert ? Sizes.s200 :0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: appCtrl.appTheme.blackColor,
              borderRadius: BorderRadius.circular(AppRadius.r5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cancel,
                color: isAlert
                    ? appCtrl.appTheme.whiteColor
                    : appCtrl.appTheme.transparentColor,
                size: Sizes.s15
              ),
              const HSpace(Sizes.s8),
              Text(fonts.svgNotAllowed.tr,
                  style: AppCss.manropeMedium14
                      .textColor(appCtrl.appTheme.whiteColor)
                      .textDecoration(TextDecoration.none)),
            ],
          ),
        ),
      ),
    );
  }
}
