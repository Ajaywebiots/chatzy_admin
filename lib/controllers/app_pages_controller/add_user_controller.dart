import 'dart:developer';
import 'dart:io' as io;
import 'package:chatzy_admin/config.dart';
import 'package:flutter/foundation.dart';

class AddUserController extends GetxController {

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  String imageName = "",
      imageUrl = "";
  Uint8List webImage = Uint8List(8);
  Uint8List uploadWebImage = Uint8List(8);
  io.File? pickImage;
  bool isUploadSize = false,
      isAlert = false;
  XFile? imageFile;
  XFile? videoFile;

  // GET IMAGE FROM GALLERY
  Future getImage({source, StateSetter? setState, dropImage, context}) async {
    if (dropImage != null) {
      if (imageName.contains("png") ||
          imageName.contains("jpg") ||
          imageName.contains("jpeg")) {
        var image = dropImage;
        uploadWebImage = image;
        Image image1 = Image.memory(uploadWebImage);

        ImageInfo info = await getImageInfo(image1);

        if (info.image.width > 300 && info.image.height > 50) {
          webImage = uploadWebImage;
          pickImage = io.File("a");
          isUploadSize = false;
        } else {
          isUploadSize = true;
        }
        isAlert = false;
      } else {
        isAlert = true;
        update();
        await Future.delayed(DurationClass.s2);
        isAlert = false;
        update();
      }
    } else {
      final ImagePicker picker = ImagePicker();
      imageFile = (await picker.pickImage(source: ImageSource.gallery))!;
      log("imageFile : $imageFile");

      if (imageFile!.name.contains("png") ||
          imageFile!.name.contains("jpg") ||
          imageFile!.name.contains("jpeg")) {
        var image = await imageFile!.readAsBytes();
        uploadWebImage = image;

        Image image1 = Image.memory(uploadWebImage);
        log("image1 : $image1");
        ImageInfo info = await getImageInfo(image1);

        if (info.image.width > 300 && info.image.height > 50) {
          webImage = uploadWebImage;
          pickImage = io.File(imageFile!.path);
          isUploadSize = false;
        } else {
          isUploadSize = true;
        }
        isAlert = false;
        update();
      } else {
        isAlert = true;
        update();
        await Future.delayed(DurationClass.s2);
        isAlert = false;
        update();
      }
    }
  }

  //on click Image
  onImagePickUp(setState, context) {
    if (kIsWeb) {
      getImage(source: ImageSource.gallery, context: context);
    } else {
      imagePickerOption(
          setState: setState,
          cameraTap: () {
            getImage(
                source: ImageSource.camera,
                setState: setState,
                context: context);
            Get.back();
          },
          galleryTap: () {
            getImage(
                source: ImageSource.gallery,
                setState: setState,
                context: context);
            Get.back();
          });
    }
  }





  //user register
  userRegister(User user) async {
    log(" : $user");
    try {
        await FirebaseFirestore.instance.collection(collectionName.users).doc(user.uid).set({
          'chattingWith': null,
          'id': user.uid,
          'image': user.photoURL ?? "",
          'name': user.displayName ?? "",
          'pushToken': "",
          'status': "Offline",
          "typeStatus": "Offline",
          "phone": numberCtrl.text,
          "email": emailCtrl.text,
          "deviceName": appCtrl.deviceName,
          "isActive":true,
          "device": appCtrl.device,
          "statusDesc": "Hello, I am using Chatter"
        }).catchError((err) {
          log("fir : $err");
        });
    } on FirebaseAuthException catch (e) {
      log("firebase : $e");
    }
  }


}