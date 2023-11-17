import 'dart:developer';
import 'package:chatzy_admin/models/user_setting_model.dart';

import '../../config.dart';

class UserAppSettingsController extends GetxController {
  String isGoogleAd = "google", id = "";
  UserAppSettingModel? usageCtrl;
  bool isLoading = false;
  TextEditingController approvalMessage = TextEditingController();
  TextEditingController maintenanceMessage = TextEditingController();
  TextEditingController txtRateApp = TextEditingController();
  TextEditingController txtRateAppIos = TextEditingController();
  TextEditingController txtAndroidBannerId = TextEditingController();
  TextEditingController txtIOSBannerId = TextEditingController();
  TextEditingController txtFBAndroidBannerId = TextEditingController();
  TextEditingController txtFBIOSBannerId = TextEditingController();
  TextEditingController txtGif = TextEditingController();
  TextEditingController txtFirebaseToken = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //get data from firebase
  getData() async {
    await FirebaseFirestore.instance
        .collection(collectionName.config)
        .doc(collectionName.userAppSettings)
        .get()
        .then((value) {
      log("get data Inc11: ${value.exists}");
      if (value.exists) {
        id = value.id;
        usageCtrl = UserAppSettingModel.fromJson(value.data()!);

        approvalMessage.text = usageCtrl!.approvalMessage.toString();
        maintenanceMessage.text = usageCtrl!.maintenanceMessage.toString();
        txtRateApp.text = usageCtrl!.rateApp.toString();
        txtRateAppIos.text = usageCtrl!.rateAppIos.toString();
        txtAndroidBannerId.text = usageCtrl!.bannerAndroidId.toString();
        txtIOSBannerId.text = usageCtrl!.bannerIOSId.toString();
        txtIOSBannerId.text = usageCtrl!.bannerIOSId.toString();
        txtFBAndroidBannerId.text = usageCtrl!.facebookAddAndroidId.toString();
        txtFBIOSBannerId.text = usageCtrl!.facebookAddIOSId.toString();
        txtGif.text = usageCtrl!.gifAPI.toString();
        txtFirebaseToken.text = usageCtrl!.firebaseServerToken.toString();
      }
    });

    update();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSnapShotData() {
    log("GET DATA P: ${FirebaseFirestore.instance.collection(collectionName.config).doc(collectionName.userAppSettings).get()}");
    return FirebaseFirestore.instance
        .collection(collectionName.config)
        .doc(collectionName.userAppSettings)
        .get();
  }

  //update data
  updateData() async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest) ?? false;
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      if (formKey.currentState!.validate()) {
        usageCtrl!.approvalMessage = approvalMessage.text;
        usageCtrl!.maintenanceMessage = maintenanceMessage.text;
        usageCtrl!.rateApp = txtRateApp.text;
        usageCtrl!.rateAppIos = txtRateAppIos.text;
        usageCtrl!.bannerAndroidId = txtAndroidBannerId.text;
        usageCtrl!.bannerIOSId = txtIOSBannerId.text;
        usageCtrl!.facebookAddAndroidId = txtFBAndroidBannerId.text;
        usageCtrl!.facebookAddIOSId = txtFBIOSBannerId.text;
        usageCtrl!.gifAPI = txtGif.text;
        usageCtrl!.firebaseServerToken = txtFirebaseToken.text;

        log("usage: $usageCtrl");


        isLoading = true;
        log("usage2: $usageCtrl");
        update();
        await FirebaseFirestore.instance
            .collection(collectionName.config)
            .doc(collectionName.userAppSettings)
            .update(usageCtrl!.toJson())
            .then((value) {
          isLoading = false;
          update();
        });
        update();
        getData();
      }
    }
  }

  //on change switcher
  commonSwitcherValueChange(title, value) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      await FirebaseFirestore.instance
          .collection(collectionName.config)
          .doc(collectionName.userAppSettings)
          .update({title: value});
      update();
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
