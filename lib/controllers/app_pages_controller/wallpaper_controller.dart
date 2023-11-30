import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:io' as io;

import '../../config.dart';

class WallpaperController extends GetxController {
  dynamic usageCtrl;
  bool isLoading = false;
  XFile? imageFile;
  bool isUploadSize = false, isDarkUploadFile2 = false, isUpdate = false;
  bool isAlert = false;
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtMessage = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtType = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> wallpaperTypeList = <String>['solid', 'dark', 'light'];
  XFile? wallpaper1File, wallpaper2File;
  late DropzoneViewController? controller1, controller2;
  String dropdownValue = "solid";
  Uint8List wallpaperWebImage1 = Uint8List(8);
  Uint8List wallpaperUploadWebImage2 = Uint8List(8);
  io.File? pickImage, wallpaperPickImage2, wallpaperPickImage3;
  var random = math.Random();
  List<XFile> list = [];
  int? selectedIndex;
  String imageName = "",
      imageUrl = "",
      imageUrl2 = "",
      imageUrl3 = "",
      wallpaperImageUrl2 = "",
      wallpaperImageUrl3 = "",
      wallpaperImageName2 = "",
      wallpaperImageName3 = "";
  Uint8List webImage = Uint8List(8);
  Uint8List wallpaperWebImage2 = Uint8List(8);
  Uint8List wallpaperWebImage3 = Uint8List(8);
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "solid", child: Text(fonts.solid.tr)),
      DropdownMenuItem(value: "dark", child: Text(fonts.dark.tr)),
      DropdownMenuItem(value: "light", child: Text(fonts.light.tr))
    ];
    return menuItems;
  }
  List imageList = [];
  Uint8List uploadWebImage = Uint8List(8);

  bool sortAscending = true;

  final bool showSelect = true;
  List banner = [];
  String characterId = "";

  //get data from firebase
  getData() async {}

  //add data
  addData() async {
    List yourItemList = [];

    await FirebaseFirestore.instance
        .collection(collectionName.wallpaper)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.asMap().entries.forEach((element) {
          if (dropdownValue == element.value.data()["type"]) {
            characterId = element.value.id;
            yourItemList = element.value.data()["image"];
          }
        });
      }
      update();
      yourItemList.add(imageUrl);
    });
    update();
    log("characterId : $characterId");

    bool isLoginTest = appCtrl.storage.read(session.isLoginTest) ?? false;
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      isLoading = true;

      if (imageUrl.isNotEmpty) {
        if (characterId != "") {
          await FirebaseFirestore.instance
              .collection(collectionName.wallpaper)
              .doc(characterId)
              .update({
            'type': dropdownValue,
            "image": FieldValue.arrayUnion(yourItemList),
          }).then((value) {
            webImage = Uint8List(8);
            pickImage = null;
            imageUrl = "";
            pickImage = null;
            imageFile = null;
            characterId = "";
            log("usage3: $usageCtrl");

            isLoading = false;
            update();
          });
          update();
        } else {
          int id = DateTime.now().millisecondsSinceEpoch;
          update();
          await FirebaseFirestore.instance
              .collection(collectionName.wallpaper)
              .doc(id.toString())
              .set({
            'type': dropdownValue,
            "image": FieldValue.arrayUnion(yourItemList),
          }).then((value) {
            log("usage3: $usageCtrl");
            webImage = Uint8List(8);
            webImage = Uint8List(8);
            pickImage = null;
            imageUrl = "";
            pickImage = null;
            imageFile = null;
            Get.back();
            isLoading = false;
            update();
          });
          update();
        }
      } else {
        isLoading = false;
        isAlert = true;
        update();
      }
    }
  }

  //add data
  updateData() async {
    List yourItemList = [];
    await FirebaseFirestore.instance
        .collection(collectionName.wallpaper)
        .doc(characterId)
        .get()
        .then((value) async {
      if (value.exists) {
        yourItemList = value.data()!["image"];
      }

      update();
      yourItemList[selectedIndex!] = imageUrl;
      await Future.delayed(Durations.ms150);

      bool isLoginTest = appCtrl.storage.read(session.isLoginTest) ?? false;
      if (isLoginTest) {
        accessDenied(fonts.modification.tr);
      } else {
        isLoading = true;
        if (imageUrl.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection(collectionName.wallpaper)
              .doc(characterId)
              .update({
            'type': dropdownValue,
            "image": yourItemList,
          }).then((value) {
            webImage = Uint8List(8);
            pickImage = null;
            imageUrl = "";
            pickImage = null;
            imageFile = null;
            isUpdate = false;
            log("usage3: $usageCtrl");
            characterId = "";
            isLoading = false;
            update();
          });

          update();
        } else {
          isLoading = false;
          isAlert = true;
          update();
        }
      }
    });

    update();
    log("characterId : $characterId");
  }

  //on click Image
  onImagePickUp(setState, context, title) {
    if (kIsWeb) {
      getImage(source: ImageSource.gallery, context: context, title: title);
    } else {
      imagePickerOption(
          setState: setState,
          cameraTap: () {
            getImage(
                source: ImageSource.camera,
                setState: setState,
                context: context,
                title: title);
            Get.back();
          },
          galleryTap: () {
            getImage(
                source: ImageSource.gallery,
                setState: setState,
                context: context,
                title: title);
            Get.back();
          });
    }
  }

// GET IMAGE FROM GALLERY
  Future getImage(
      {source,
      StateSetter? setState,
      dropImage,
      context,
      uploadFile,
      title}) async {
    wallpaper1Upload(
        setState: setState,
        source: source,
        dropImage: dropImage,
        title: title,
        context: context,
        uploadFile: uploadFile);
  }

  wallpaper1Upload(
      {source,
      StateSetter? setState,
      dropImage,
      context,
      uploadFile,
      title}) async {
    if (dropImage != null) {
      if (imageName.contains("png") ||
          imageName.contains("jpg") ||
          imageName.contains("jpeg")) {
        var image = dropImage;
        wallpaperWebImage1 = image;
        log("wallpaperWebImage1 : $wallpaperWebImage1");
        Image image1 = Image.memory(wallpaperWebImage1);
        log("image1 : $image1");
        isUploadSize = true;
        webImage = wallpaperWebImage1;
        pickImage = io.File("a");

        isAlert = false;
        update();
      } else {
        isAlert = true;
        update();
        await Future.delayed(Durations.s2);
        isAlert = false;
        update();
      }
    } else {
      final ImagePicker picker = ImagePicker();
      wallpaper1File = (await picker.pickImage(source: ImageSource.gallery))!;
      log("wallpaper1File : $wallpaper1File");

      if (wallpaper1File!.name.contains("png") ||
          wallpaper1File!.name.contains("jpg") ||
          wallpaper1File!.name.contains("jpeg")) {
        var image = await wallpaper1File!.readAsBytes();
        wallpaperWebImage1 = image;

        Image image1 = Image.memory(wallpaperWebImage1);
        log("image1 : $image1");
        isUploadSize = true;
        webImage = wallpaperWebImage1;
        pickImage = io.File(wallpaper1File!.path);
        isAlert = false;
        update();
      } else {
        isAlert = true;
        update();
        await Future.delayed(Durations.s2);
        isAlert = false;
        update();
      }
    }
  }

  wallpaper2Upload(
      {source,
      StateSetter? setState,
      dropImage,
      context,
      uploadFile,
      title}) async {
    if (dropImage != null) {
      if (wallpaperImageName2.contains("png") ||
          wallpaperImageName2.contains("jpg") ||
          wallpaperImageName2.contains("jpeg")) {
        var image = dropImage;
        wallpaperUploadWebImage2 = image;

        wallpaperWebImage2 = wallpaperUploadWebImage2;
        wallpaperPickImage2 = io.File("a");
        isDarkUploadFile2 = true;
        isAlert = false;
        update();
      } else {
        isAlert = true;
        update();
        await Future.delayed(Durations.s2);
        isAlert = false;
        update();
      }
    } else {
      final ImagePicker picker = ImagePicker();
      wallpaper2File = (await picker.pickImage(source: ImageSource.gallery))!;
      log("wallpaper1File : $wallpaper2File");

      if (wallpaper2File!.name.contains("png") ||
          wallpaper2File!.name.contains("jpg") ||
          wallpaper2File!.name.contains("jpeg")) {
        var image = await wallpaper2File!.readAsBytes();
        wallpaperUploadWebImage2 = image;

        Image image1 = Image.memory(wallpaperUploadWebImage2);
        log("image1 : $image1");

        wallpaperWebImage2 = wallpaperUploadWebImage2;
        wallpaperPickImage2 = io.File(wallpaper2File!.path);
        isDarkUploadFile2 = true;

        isAlert = false;
        update();
      } else {
        isAlert = true;
        update();
        await Future.delayed(Durations.s2);
        isAlert = false;
        update();
      }
    }
  }

// UPLOAD SELECTED IMAGE TO FIREBASE
  Future uploadFile(isUpdate) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      log("picker: $pickImage");
      if (pickImage != null) {
        isAlert = false;
        isLoading = true;
        update();
        Get.forceAppUpdate();
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = FirebaseStorage.instance.ref().child(fileName);

        UploadTask? uploadTask;
        uploadTask = reference.putData(webImage);

        uploadTask.then((res) async {
          log("res : $res");
          res.ref.getDownloadURL().then((downloadUrl) async {
            imageUrl = downloadUrl;
            log("imageUrl : $imageUrl");
            update();

            await Future.delayed(Durations.s3);
            if (isUpdate == false) {
              addData();
            } else {
              updateData();
            }
          }, onError: (err) {
            update();
          });
        });
      } else {
        log("PICKED IMAGE : $pickImage");
        isAlert = true;
        isLoading = false;
        log("wallpaperCtrl.isAlert == true && wallpaperCtrl.pickImage == null : ${isAlert == true && pickImage == null}");
        update();
      }
    }
  }

  isActiveChange(id, value) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      await FirebaseFirestore.instance
          .collection(collectionName.wallpaper)
          .doc(id)
          .update({"isActive": value});
    }
  }

  deleteData(id, index) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      List yourItemList = [];
      await FirebaseFirestore.instance
          .collection(collectionName.wallpaper)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.asMap().entries.forEach((element) {
            if (dropdownValue == element.value.data()["type"]) {
              characterId = element.value.id;
              yourItemList = element.value.data()["image"];
            }
          });
        }
        yourItemList.removeAt(index);
      });
      update();
      if (yourItemList.isEmpty) {
        await FirebaseFirestore.instance
            .collection(collectionName.wallpaper)
            .doc(id)
            .delete();
      } else {
        log("yourItemListyourItemList: ${characterId} // $index ");
        log("yourItemListyourItemList: ${{
          'type': dropdownValue,
          "image": yourItemList,
        }}");

        await FirebaseFirestore.instance
            .collection(collectionName.wallpaper)
            .doc(characterId)
            .update({'type': dropdownValue, "image": yourItemList}).then(
                (value) {
          characterId = "";
          update();
        });
      }
    }
  }

  @override
  void onReady() {
    getData();
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
