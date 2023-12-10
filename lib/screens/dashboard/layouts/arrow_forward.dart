
import '../../../config.dart';

class ArrowForward extends StatelessWidget {
  final VoidCallback? onPressed;
  const ArrowForward({Key? key,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios, size: 16,color: appCtrl.appTheme.gray),
      onPressed:onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
