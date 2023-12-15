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
        return Responsive.isDesktop(context) ? Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(alignment: Alignment.topCenter, children: [
              appCtrl.isTheme ?  SvgPicture.asset(
                svgAssets.rectangle,
                width: !Responsive.isDesktop(context) ? Sizes.s120 :  Sizes.s80,
                height: Sizes.s100,
                colorFilter: ColorFilter.mode(appCtrl.appTheme.textBoxColor, BlendMode.srcIn),
                fit: BoxFit.fill,
              ).paddingOnly(top: 20) :  SvgPicture.asset(
                  svgAssets.rectangle,
                  width: !Responsive.isDesktop(context) ? Sizes.s120 :  Sizes.s80,
                  height: Sizes.s100,
                  fit: BoxFit.fill,
                ).paddingOnly(top: 20),
                Align(
                    alignment: Alignment.topCenter,
                    child: Column(children: [
                      Container(
                        height:  !Responsive.isDesktop(context) ? Sizes.s40 :  Sizes.s50 ,
                        width:  !Responsive.isDesktop(context) ? Sizes.s40 :Sizes.s50,
                        decoration: BoxDecoration(
                            color: appCtrl.appTheme.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xFFE9E9E9))),
                        child: Container(
                                height:  !Responsive.isDesktop(context) ? Sizes.s30  : Sizes.s40,
                                width:  !Responsive.isDesktop(context) ? Sizes.s30 :Sizes.s40 ,
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: appCtrl.appTheme.lightGrey,
                                    shape: BoxShape.circle),
                                child: Image.asset(image!))
                            .border(color: Color(0xFFF7F8F8)),
                      ),
                      const VSpace(Sizes.s5),
                      Text(title! ,
                          style: GoogleFonts.manrope(
                              fontSize:  !Responsive.isDesktop(context) ?12 :MediaQuery.of(Get.context!).size.width < 1420? 14:  16 ,
                              fontWeight: FontWeight.w500,
                              color:appCtrl.isTheme ?  appCtrl.appTheme.white : appCtrl.appTheme.textBoxColor)),
                      if(dash.isDisplay)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        SvgPicture.asset(svgAssets.user),
                        const HSpace(Sizes.s2),
                            Text(count ?? "0",
                                style: GoogleFonts.manrope(
                                    fontSize:  !Responsive.isDesktop(context) ?16 :MediaQuery.of(Get.context!).size.width < 1420? 14:  20 ,
                                    fontWeight: FontWeight.w800,
                                    color: appCtrl.appTheme.primary))
                      ])
                    ]))
              ]),
            ],
          )
        ) : Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(alignment: Alignment.topCenter, children: [
              appCtrl.isTheme ?      SvgPicture.asset(
                svgAssets.rectangle,
                width: !Responsive.isDesktop(context) ? Sizes.s120 :  Sizes.s80,
                height: Sizes.s100,
                colorFilter: ColorFilter.mode(appCtrl.appTheme.textBoxColor, BlendMode.srcIn),
                fit: BoxFit.fill,
              ).paddingOnly(top: 20) : SvgPicture.asset(
                svgAssets.rectangle,
                width: !Responsive.isDesktop(context) ? Sizes.s120 :  Sizes.s80,
                height: Sizes.s100,
                fit: BoxFit.fill,
              ).paddingOnly(top: 20),
              Align(
                  alignment: Alignment.topCenter,
                  child: Column(children: [
                    Container(
                      height:Sizes.s50 ,
                      width:  Sizes.s50,
                      decoration: BoxDecoration(
                          color: appCtrl.appTheme.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xFFE9E9E9))),
                      child: Container(
                          height:  Sizes.s40,
                          width: Sizes.s40 ,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: appCtrl.appTheme.lightGrey,
                              shape: BoxShape.circle),
                          child: Image.asset(image!))
                          .border(color: Color(0xFFF7F8F8)),
                    ),
                    const VSpace(Sizes.s5),
                    Text(title! ,
                        style: GoogleFonts.manrope(
                            fontSize:  16 ,
                            fontWeight: FontWeight.w500,
                            color: appCtrl.isTheme ?  appCtrl.appTheme.white : appCtrl.appTheme.textBoxColor)),
                    if(dash.isDisplay)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(svgAssets.user),
                            const HSpace(Sizes.s2),
                            Text(count ?? "0",
                                style: GoogleFonts.manrope(
                                    fontSize:  20 ,
                                    fontWeight: FontWeight.w800,
                                    color: appCtrl.appTheme.primary))
                          ])
                  ]))
            ]),
          ],
        );
      }
    );
  }
}
