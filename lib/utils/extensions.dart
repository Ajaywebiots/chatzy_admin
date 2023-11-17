import '../config.dart';

extension ChatifyExtansion on Widget {
  // Box extension
  Widget boxExtension() => Container(child: this).decorated(
    border: Border.all(color: appCtrl.appTheme.gray.withOpacity(0.2)),
          color: appCtrl.isTheme
              ? appCtrl.appTheme.accentTxt
              : appCtrl.appTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r18)),
          boxShadow: [
            BoxShadow(
                color: appCtrl.appTheme.primaryLight.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10)
          ]);
}
