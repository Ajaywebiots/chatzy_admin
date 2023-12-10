import 'dart:developer';

import 'package:chatzy_admin/screens/wallpaper/layouts/image_layout.dart';
import 'package:desktop_drop/desktop_drop.dart';

import '../../config.dart';

class AdminStatusScreen extends StatelessWidget {
  final StateSetter? setState;

  AdminStatusScreen({Key? key, this.setState}) : super(key: key);
  final adminStatusCtrl = Get.put(AdminStatusController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminStatusController>(
        builder: (_) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fonts.uploadImage.tr,
                      style: AppCss.manropeSemiBold22.textColor(
                          appCtrl.appTheme.number)).paddingOnly(top: Insets.i10),
                  SizedBox(
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: Sizes.s400,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                    alignment: Alignment.center, children: [
                                  DropTarget(
                                    onDragDone: (detail) async {
                                      adminStatusCtrl.imageName = detail.files.first.name;
                                      adminStatusCtrl.update();
                                      final bytes =  await detail.files.first.readAsBytes();
                                      adminStatusCtrl.getImage(
                                          dropImage: bytes);

                                      log("detail.files :${detail.files}");
                                    },
                                    onDragEntered: (detail) {
                                      log("ENTER : $detail");
                                    },
                                    onDragExited: (detail) {
                                      log("ExIt : $detail");
                                    },
                                    child:  adminStatusCtrl.imageUrl.isNotEmpty &&
                                        adminStatusCtrl.pickImage != null
                                        ? CommonDottedBorder(
                                        child: Image.memory(
                                            adminStatusCtrl.webImage,
                                            fit: BoxFit.fill))
                                        .inkWell(
                                        onTap: () =>
                                            adminStatusCtrl.getImage(
                                                source: ImageSource.gallery,
                                                context: context))
                                        : adminStatusCtrl.imageUrl.isNotEmpty
                                        ? CommonDottedBorder(
                                        child: Image.network(
                                            adminStatusCtrl.imageUrl))
                                        .inkWell(
                                        onTap: () =>
                                            adminStatusCtrl.getImage(
                                                source: ImageSource.gallery,
                                                context: context))
                                        : adminStatusCtrl.pickImage == null
                                        ? const ImagePickUp().inkWell(
                                        onTap: () =>
                                            adminStatusCtrl.onImagePickUp(
                                                setState, context))
                                        : CommonDottedBorder(
                                        child: Image.memory(
                                            adminStatusCtrl.webImage,
                                            fit: BoxFit.fill))
                                        .inkWell(
                                        onTap: () =>
                                            adminStatusCtrl.getImage(
                                                source: ImageSource.gallery,
                                                context: context))
                                  ),

                                 /* DragDropLayout(
                                      onCreated: (ctrl) =>
                                      adminStatusCtrl.controller1 = ctrl,
                                      onDrop: (ev) async {

                                        adminStatusCtrl.imageName = ev.name;
                                        adminStatusCtrl.update();
                                        final bytes = await adminStatusCtrl
                                            .controller1!.getFileData(ev);
                                        adminStatusCtrl.getImage(
                                            dropImage: bytes);
                                      }),*/

                                ])
                            ),

                          ]).paddingAll(Insets.i30)).boxExtension().paddingSymmetric(vertical: Insets.i20),
                  if (adminStatusCtrl.isAlert == true &&
                      adminStatusCtrl.pickImage == null)
                    Text("Please Upload Image",
                        style: AppCss.manropeSemiBold14
                            .textColor(appCtrl.appTheme.redColor)),
                  UpdateButton(title: fonts.addStatus,
                      onPressed: adminStatusCtrl.imageFile != null
                          ? () => adminStatusCtrl.uploadImage()
                          : () {
                        adminStatusCtrl.isAlert = true;
                        adminStatusCtrl.update();
                      }).alignment(Alignment.bottomRight)
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
