import 'package:google_fonts/google_fonts.dart';

import '../../../config.dart';

class DashboardTitleCount extends StatelessWidget {
  final String? count, title;

  const DashboardTitleCount({Key? key, this.count, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /*Text(title!,
          style: GoogleFonts.manrope(
              fontSize: MediaQuery.of(context).size.width < 1500 ? 16 : 18,
              color: appCtrl.appTheme.textBoxColor,
              fontWeight: FontWeight.normal)),
      VSpace(MediaQuery.of(context).size.width < 1500 ? Sizes.s5 : Sizes.s10),
      Text(count!,
          style: GoogleFonts.manrope(
              fontSize: MediaQuery.of(context).size.width < 1500 ? 18 : 22,
              color: appCtrl.appTheme.primary,
              fontWeight: FontWeight.w800)),*/
      Text(title!,
          style: GoogleFonts.manrope(
              fontSize:  MediaQuery.of(context).size.width < 1400 ?14 : 16 ,
              color: appCtrl.appTheme.textBoxColor,
              fontWeight: FontWeight.normal)),
    const  VSpace( Sizes.s5),
      Text(count!,
          style: GoogleFonts.manrope(
              fontSize: MediaQuery.of(context).size.width < 1400 ? 16: 18 ,
              color: appCtrl.appTheme.primary,
              fontWeight: FontWeight.w800)),
    ]);
  }
}
