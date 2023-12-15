import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:io' as io;

import '../../config.dart';

class LanguageController extends GetxController {
  List languagesLists = [];
  List isActiveList = [];
  int selectedPrimary = 0;
  dynamic defaultLan;
  String? id;

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await FirebaseFirestore.instance
        .collection(collectionName.languages)
        .doc(collectionName.language)
        .get()
        .then((value) {
      if (value.exists) {
        id = value.id;
        List lan = value.data()!["language"];
        languagesLists = lan;
        isActiveList =
            lan.where((element) => element['isActive'] == true).toList();
      }
      update();
    });

    await FirebaseFirestore.instance
        .collection(collectionName.languages)
        .doc(collectionName.defaultLanguage)
        .get()
        .then((value) {
      if (value.exists) {
        defaultLan = value.data()!["language"];
        int ind = languagesLists
            .indexWhere((element) => element["title"] == defaultLan["title"]);
        if (ind > 0) {
          selectedPrimary = ind;
        }
        update();
      }
      update();
    });
    update();
  }

  save() async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest) ?? false;
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      await FirebaseFirestore.instance
          .collection(collectionName.languages)
          .doc(collectionName.language)
          .get()
          .then((value) async {
        log("message : ${value.data()}");
        await FirebaseFirestore.instance
            .collection(collectionName.languages)
            .doc(collectionName.language).update({"language": languagesLists});
      });
      await FirebaseFirestore.instance
          .collection(collectionName.languages)
          .doc(collectionName.defaultLanguage)
          .get()
          .then((value) async {
        log("message : ${value.data()}");
        await FirebaseFirestore.instance
            .collection(collectionName.languages)
            .doc(collectionName.language).update({"language": defaultLan});
      }).then((s) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(fonts.update.tr),
          backgroundColor: appCtrl.appTheme.greenColor,
        ));
      });
    }
  }
}
