import 'dart:ui';
import '../../../../config.dart';

class GlassMorphicLayout extends StatelessWidget {
  final LinearGradient? linearGradient;
  final Widget? child;
  const GlassMorphicLayout({Key? key,this.child,this.linearGradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width:  MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,
      color: appCtrl.appTheme.loginBg,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          ClipRRect(
            clipBehavior: Clip.hardEdge,

            child: Container(
              alignment: Alignment.bottomCenter,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}



