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
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(Get.context!).size.width < 1420? 14: 16,
                color: appCtrl.appTheme.blackText),
          ),
        ],
      ).paddingSymmetric(vertical: Insets.i20);

  //common value text
  Widget commonValueText(value, {isImage = false}) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isImage
              ? Container(
                  height: Sizes.s42,
                  width: Sizes.s42,
                  decoration: BoxDecoration(

                      shape: BoxShape.circle,
                      image: value != null && value != ""
                          ? DecorationImage(
                              image: NetworkImage(value), fit: BoxFit.fill)
                          : DecorationImage(
                              image: AssetImage(imageAssets.addUser),
                              fit: BoxFit.fill)),
                ).marginOnly(top: 10)
              : SelectableText(
                  value,
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize:MediaQuery.of(Get.context!).size.width < 1420? 14: 16,
                    fontFamily: GoogleFonts.poppins().fontFamily
                  )
                ).marginOnly(top: 20)
        ],
      );

  //credential copy
  Widget credentialCopy(title, val, context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("$title : ",
                  style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: appCtrl.appTheme.blackColor)),
              Text(val,
                  style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: appCtrl.appTheme.blackColor)),
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
      ).inkWell(onTap: () {
        Clipboard.setData(ClipboardData(text: val));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Copy Text'),
        ));
      });

  //action layout
  Widget actionLayout({GestureTapCallback? onTap, isUser = true}) =>
      Column(children: [
        Icon(Icons.delete_forever, color: appCtrl.appTheme.primary)
            .inkWell(onTap: onTap)
      ]).marginSymmetric(vertical: Insets.i15);
}
