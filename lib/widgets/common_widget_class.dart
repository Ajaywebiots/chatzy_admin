import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../config.dart';

class CommonWidgetClass {
  //common title text
  Widget commonTitleText(title) => Column(
        children: [
          Text(
            title.toString().tr.toUpperCase(),
            style: AppCss.manropeMedium14.textColor(appCtrl.appTheme.blackText),
          ),
        ],
      ).paddingSymmetric(vertical: Insets.i20);

  //common value text
  Widget commonValueText(value, {isImage = false}) => Column(
        children: [
          isImage
              ? value != null
                  ? Container(
                      height: Sizes.s50,
                      width: Sizes.s50,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(AppRadius.r10),
                          image: DecorationImage(
                              image: NetworkImage(value), fit: BoxFit.fill)),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.r50),
                      child: Image.asset(imageAssets.addUser,
                          height: Sizes.s50,
                          width: Sizes.s50,
                          fit: BoxFit.fill))
              : Text(
                  value,
                  style: AppCss.manropeRegular14
                      .textColor(appCtrl.appTheme.blackColor),
                )
        ],
      );

  //credential copy
  Widget credentialCopy(title,val,context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Row(
           children: [
             Text("$title : ",
                 style: GoogleFonts.manrope(
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                   color: appCtrl.appTheme.blackColor
                 )),
             Text(val,
                 style: GoogleFonts.manrope(
                     fontSize: 16,
                     fontWeight: FontWeight.w600,
                     color: appCtrl.appTheme.blackColor
                 )),
           ],
         ),
         SmoothContainer(
           color: appCtrl.appTheme.white,
           borderRadius: BorderRadius.circular(12),
           smoothness: 1,
           padding: const EdgeInsets.all(Insets.i8),
           side: BorderSide(color: appCtrl.appTheme.borderColor),
           child: SvgPicture.asset(svgAssets.copy),
         )
        ],
      ).inkWell(onTap: (){
        Clipboard.setData(ClipboardData(text: val));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(

          content: Text('Copy Text'),

        ));
  });

  //action layout
  Widget actionLayout({GestureTapCallback? onTap, isUser = true}) =>
      Column(children: [
        Icon(Icons.delete_forever,color: appCtrl.appTheme.primary).inkWell(onTap: onTap)
      ]).marginSymmetric(vertical: Insets.i15);
}
