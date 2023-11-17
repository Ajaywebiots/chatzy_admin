

import '../config.dart';

class CommonSwitcher extends StatelessWidget {
  final bool? isActive;
  final ValueChanged<bool>? onToggle;
  const CommonSwitcher({Key? key,this.isActive,this.onToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterSwitch(
          width: Sizes.s50,
          height: Sizes.s26,
          toggleSize: Sizes.s20,
          value: isActive ?? true,
          borderRadius: 30.0,
          activeToggleColor: appCtrl.appTheme.white,
          inactiveToggleColor: appCtrl.appTheme.primary,
          activeColor: appCtrl.appTheme.primary,
          inactiveColor:
          appCtrl.appTheme.primary.withOpacity(0.2),

          onToggle: onToggle!,
        )
      ],
    ).marginSymmetric(vertical: Insets.i15);
  }
}
