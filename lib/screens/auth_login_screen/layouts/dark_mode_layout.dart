import '../../../../config.dart';

class DarkModeLayout extends StatelessWidget {
  const DarkModeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(appCtrl.isTheme ? fonts.lightMode.tr : fonts.darkMode.tr,
          style:
              AppCss.manropeMedium14.textColor(appCtrl.appTheme.blackColor)),
      const HSpace(Sizes.s10),
      FlutterSwitch(
        width: Sizes.s50,
        height: Sizes.s30,
        toggleSize: Sizes.s20,
        value: appCtrl.isTheme,
        borderRadius: 30.0,
        activeToggleColor: appCtrl.appTheme.primary,
        inactiveToggleColor: appCtrl.appTheme.primary,
        activeColor: appCtrl.appTheme.primary.withOpacity(0.2),
        inactiveColor: appCtrl.appTheme.primary.withOpacity(0.2),
        activeIcon: SvgPicture.asset(svgAssets.sun),
        inactiveIcon: SvgPicture.asset(svgAssets.moon),
        onToggle: (val) async {
          appCtrl.isTheme = val;
          ThemeService().switchTheme(appCtrl.isTheme);
          await appCtrl.storage.write(session.isDarkMode, appCtrl.isTheme);
          appCtrl.update();
        }
      ),
    ]));
  }
}
