import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';

import '../../../config.dart';

class CountryUserCount extends StatelessWidget {
  final String? image, title, count;

  const CountryUserCount({super.key, this.image, this.title, this.count});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DashboardController>(
      builder: (dash) {
        return Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(alignment: Alignment.topCenter, children: [
                SvgPicture.asset(
                  svgAssets.rectangle,
                  width: Sizes.s80,
                  height: Sizes.s100,
                  fit: BoxFit.fill,
                ).paddingOnly(top: 20),
                Align(
                    alignment: Alignment.topCenter,
                    child: Column(children: [
                      Container(
                        height:Sizes.s50 ,
                        width:Sizes.s50,
                        decoration: BoxDecoration(
                            color: appCtrl.appTheme.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: appCtrl.appTheme.redColor)),
                        child: Container(
                                height:Sizes.s40,
                                width:Sizes.s40 ,
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: appCtrl.appTheme.lightGrey,
                                    shape: BoxShape.circle),
                                child: Image.asset(image!))
                            .border(color: appCtrl.appTheme.redColor),
                      ),
                      const VSpace(Sizes.s5),
                      Text(title! ,
                          style: GoogleFonts.manrope(
                              fontSize:16 ,
                              fontWeight: FontWeight.w500,
                              color: appCtrl.appTheme.textBoxColor)),
                      if(dash.isDisplay)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        SvgPicture.asset(svgAssets.user),
                        const HSpace(Sizes.s2),
                            Text(count ?? "0",
                                style: GoogleFonts.manrope(
                                    fontSize:20 ,
                                    fontWeight: FontWeight.w800,
                                    color: appCtrl.appTheme.primary))
                      ])
                    ]))
              ]),
            ],
          )
        );
      }
    );
  }
}
