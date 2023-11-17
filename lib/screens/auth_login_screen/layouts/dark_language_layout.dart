import '../../../../config.dart';

class DarkLanguageLayout extends StatelessWidget {
  const DarkLanguageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: Sizes.s55,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          DarkModeLayout(),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.i15),
              child: VerticalDivider(
                  width: 1.0, thickness: 1.0, indent: 14.0, endIndent: 14.0)),
           LanguageLayout(),
           SizedBox(width: Sizes.s16 * 0.5)
        ]));
  }
}
