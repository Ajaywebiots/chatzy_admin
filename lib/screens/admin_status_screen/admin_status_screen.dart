import 'dart:developer';

import 'package:chatzy_admin/screens/admin_status_screen/layouts/status_desktop.dart';
import 'package:chatzy_admin/screens/wallpaper/layouts/image_layout.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../config.dart';

class AdminStatusScreen extends StatelessWidget {
  final StateSetter? setState;

  AdminStatusScreen({Key? key, this.setState}) : super(key: key);
  final adminStatusCtrl = Get.put(AdminStatusController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminStatusController>(
        builder: (_) {
          log("adminStatusCtrl.imageFile: ${adminStatusCtrl.imageFile}");
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(fonts.uploadImage.tr,
                          style: AppCss.manropeSemiBold22.textColor(
                              appCtrl.appTheme.number)).paddingOnly(top: Insets.i10),
                      UpdateButton(title: fonts.addStatus,
                          onPressed: adminStatusCtrl.pickImage != null
                              ? () => adminStatusCtrl.uploadImage()
                              : () {
                            adminStatusCtrl.isAlert = true;
                            adminStatusCtrl.update();
                          }).alignment(Alignment.bottomRight)
                    ],
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: SmoothContainer(
                          color: appCtrl.appTheme.textBoxColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(6),
                          smoothness: 1,
                          height: Sizes.s200,
                          width: Sizes.s200,
                          padding: EdgeInsets.all(Insets.i20),
                          child: Stack(alignment: Alignment.centerLeft, children: [
                             DragDropLayout(
                                      onCreated: (ctrl) =>
                                      adminStatusCtrl.controller1 = ctrl,
                                      onDrop: (ev) async {

                                        adminStatusCtrl.imageName = ev.name;
                                        adminStatusCtrl.update();
                                        final bytes = await adminStatusCtrl
                                            .controller1!.getFileData(ev);
                                        adminStatusCtrl.getImage(
                                            dropImage: bytes);
                                      }),
                       adminStatusCtrl.imageUrl.isNotEmpty &&  adminStatusCtrl.imageUrl != ""&&
                                    adminStatusCtrl.pickImage != null
                                    ? CommonDottedBorder(child: ClipRRect(borderRadius: BorderRadius.circular(AppRadius.r16), child: Image.memory(adminStatusCtrl.webImage, fit: BoxFit.fill))).inkWell(
                                    onTap: () => adminStatusCtrl.getImage(
                                        source: ImageSource.gallery, context: context))
                                    : adminStatusCtrl.imageUrl.isNotEmpty
                                    ? CommonDottedBorder(child: Image.network(adminStatusCtrl.imageUrl))
                                    .inkWell(
                                    onTap: () => adminStatusCtrl.getImage(
                                        source: ImageSource.gallery,
                                        context: context))
                                    : adminStatusCtrl.pickImage == null
                                    ? CommonDottedBorder(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(svgAssets.export,),
                                          const VSpace(Sizes.s10),
                                          RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: fonts.clickToUpload.tr,
                                                    style: AppCss.manropeMedium14
                                                        .textColor(
                                                        appCtrl.appTheme.primary)
                                                        .textDecoration(
                                                        TextDecoration.underline)),
                                                TextSpan(
                                                    text: " ${fonts.image.tr}",
                                                    style: AppCss.manropeMedium14
                                                        .textColor(appCtrl.appTheme.dark))
                                              ])).marginSymmetric(horizontal: Insets.i10)
                                        ]).width(200))
                                    .inkWell(
                                    onTap: () => adminStatusCtrl.onImagePickUp(
                                        setState, context))
                                    : CommonDottedBorder(child: ClipRRect(borderRadius: BorderRadius.circular(AppRadius.r16), child: Image.memory(adminStatusCtrl.webImage, fit: BoxFit.fill)))
                                    .inkWell(
                                    onTap: () => adminStatusCtrl.getImage(
                                        source: ImageSource.gallery,
                                        context: context))
                          ]))).boxExtension().paddingSymmetric(vertical: Insets.i20),
                  if (adminStatusCtrl.isAlert == true &&
                      adminStatusCtrl.pickImage == null)
                    Text("Please Upload Image",
                        style: AppCss.manropeSemiBold14
                            .textColor(appCtrl.appTheme.redColor)),
                  const VSpace(Sizes.s20),
                  SmoothContainer(
                      color: appCtrl.appTheme.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Insets.i22, vertical: Insets.i23),
                      smoothness: 1,
                      borderRadius: BorderRadius.circular(Insets.i8),
                      side: BorderSide(
                          color: appCtrl.appTheme.textBoxColor.withOpacity(.15)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              fonts.image.tr,
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: appCtrl.appTheme.blackText),
                            ),
                            const VSpace(Sizes.s20),
                            StreamBuilder(
                                stream:  adminStatusCtrl.last != null
                                    ? FirebaseFirestore.instance
                                    .collection(collectionName.adminStatus)
                                    .startAfterDocument(adminStatusCtrl.last!)
                                    .limit(adminStatusCtrl.currentPerPage!)
                                    .snapshots()
                                    : FirebaseFirestore.instance
                                    .collection(collectionName.adminStatus)
                                    .limit(adminStatusCtrl.currentPerPage!)
                                    .snapshots(),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    if (snapShot.data != null &&
                                        snapShot.data!.docs.isNotEmpty) {
                                      adminStatusCtrl.lastVisible =
                                          snapShot.data!.docs.length - 1;
                                      adminStatusCtrl.lastIndexId = snapShot
                                          .data!.docs[snapShot.data!.docs.length - 1].id;
                                      adminStatusCtrl.last = snapShot.data!.docs.last;
                                      adminStatusCtrl.status = Status.fromJson(snapShot.data!.docs[0].data());
                                    }
                                    
                                    return StatusDesktop(snapShot: adminStatusCtrl.status != null ? adminStatusCtrl.status!.photoUrl :[]);
                                  } else {
                                    return Container();
                                  }
                                }),
                            const VSpace(Sizes.s20),
                           // const UserPagination()
                          ])),

                ]
              ),


              if (adminStatusCtrl.isLoading)
                Container(
                    child: Text("Status Update Successfully",
                      style: AppCss.manropeBold12.textColor(
                          appCtrl.appTheme.whiteColor),
                    ).paddingAll(Insets.i10).decorated(
                        color: appCtrl.appTheme.green,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r50)))).paddingSymmetric(horizontal: Insets.i15,vertical: Insets.i15)
            ]
          );
        }
    );
  }
}
