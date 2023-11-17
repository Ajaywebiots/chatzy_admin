import '../config.dart';

class CommonDottedBorder extends StatelessWidget {
  final Widget? child;
  const CommonDottedBorder({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(

      color: appCtrl.appTheme.primary,
      radius: const Radius.circular(AppRadius.r16),
      dashPattern: const [6, 6],
      strokeWidth: 1.5,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      child: child!,
    );
  }
}
