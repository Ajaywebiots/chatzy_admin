import '../../../config.dart';

class DesktopSwitchCommon extends StatelessWidget {
  final String? title;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final bool? isDivider;
  const DesktopSwitchCommon({Key? key, this.value, this.title, this.onChanged,this.isDivider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!.tr,
                    style: AppCss.manropeMedium16
                        .textColor(appCtrl.isTheme ?appCtrl.appTheme.white : appCtrl.appTheme.dark)),
                Switch(
                    activeColor: appCtrl.appTheme.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: value!,
                    onChanged: onChanged)
              ]
          ),
          if(isDivider != true)
            Divider(color: appCtrl.appTheme.primary.withOpacity(0.1))
        ]).paddingSymmetric(horizontal: Insets.i30);
  }
}
