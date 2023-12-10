

import '../../../config.dart';

class ArrowBack extends StatelessWidget {
  final VoidCallback? onPressed;
  const ArrowBack({Key? key,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      icon:  Icon(Icons.arrow_back_ios, size: 16,color: appCtrl.appTheme.gray,),
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
