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
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,

            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20 * 2),
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(

                  gradient: linearGradient,
                ),
              ),
            ),
          ),
          GlassMorphicBorder(
            strokeWidth: 2,
            radius: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            gradient: commonLinearGradient(),
          ),
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



