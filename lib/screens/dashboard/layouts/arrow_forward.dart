
import '../../../config.dart';

class ArrowForward extends StatelessWidget {
  final GestureTapCallback? onPressed;
  const ArrowForward({Key? key,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPressed,
      child: Icon(Icons.arrow_forward_ios, size: 16,color: appCtrl.appTheme.blackText),

    );
  }
}
