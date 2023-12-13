import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../config.dart';

class UsageControlAllTextBoxDesktop extends StatelessWidget {
  const UsageControlAllTextBoxDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsageControlController>(builder: (usageCtrl) {
      return Column(
        children: [
          const VSpace(Sizes.s20),
          SmoothContainer(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: Insets.i20),
            padding: const EdgeInsets.symmetric(vertical: Insets.i15,horizontal: Insets.i20),
            color: appCtrl.appTheme.primary.withOpacity(.08),
            smoothness: 1,
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                Icon(Icons.circle,color: appCtrl.appTheme.primary,size: Sizes.s10,),
                const HSpace(Sizes.s15),
                Text(
                  fonts.usageControl.tr,
                  style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: appCtrl.appTheme.primary),
                ),
              ],
            ),
          ),

          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DesktopTextFieldCommon(
                          width: Sizes.s236,
                          validator: (number) =>
                              Validation().groupValidation(number),
                          title: fonts.groupMemberLimit,
                          controller: usageCtrl.groupMemberLimit),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          width: Sizes.s236,
                          validator: (number) =>
                              Validation().maxContactValidation(number),
                          title: fonts.maxContactSelectForward,
                          controller: usageCtrl.maxContactSelectForward),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          width: Sizes.s236,
                          validator: (number) =>
                              Validation().maxFileValidation(number),
                          title: fonts.maxFileSize,
                          controller: usageCtrl.maxFileSize)
                    ],
                  ).marginOnly(top: Insets.i15),
                ),
                const HSpace(Sizes.s30),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      DesktopTextFieldCommon(
                          width: Sizes.s236,
                          validator: (number) =>
                              Validation().maxFileMultiValidation(number),
                          title: fonts.maxFileMultiShare,
                          controller: usageCtrl.maxFileMultiShare),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          width: Sizes.s236,
                          validator: (number) =>
                              Validation().broadCastValidation(number),
                          title: fonts.broadcastMemberLimit,
                          controller: usageCtrl.broadCastMemberLimit),
                      const VSpace(Sizes.s30),
                      DesktopTextFieldCommon(
                          width: Sizes.s236,
                          isNote: true,
                          validator: (number) =>
                              Validation().statusValidation(number),
                          title: fonts.statusDeleteTime,
                          controller: usageCtrl.statusDeleteTime),
                    ]).marginOnly(top: Insets.i15)),
              ],
            ).paddingAll(Insets.i30),
          ),
        ],
      ).boxExtension().marginOnly(top: Insets.i15);
    });
  }
}
