import 'dart:developer';
import '../../config.dart';

class AppController extends GetxController {
  AppTheme _appTheme = AppTheme.fromType(ThemeType.light);
  final storage = GetStorage();

  AppTheme get appTheme => _appTheme;
  int selectedIndex = 0;
  bool isTheme = false;
  bool isAlert = false;
  bool isRTL = false;
  bool isLogged = false;
  String isLogin = "false";
  String languageVal = "en";
  List drawerList = [];
  int currVal = 1;
  String deviceName = "";
  String device = "";
  dynamic userAppSettingsVal;
  dynamic usageControlsVal;
  var deviceData = <String, dynamic>{};

//list of bottommost page
  List<Widget> widgetOptions = <Widget>[];

  //update theme
  updateTheme(theme) {
    _appTheme = theme;
    Get.forceAppUpdate();
  }

  //get storage data
  getStorageData() {
    bool isAdmin = appCtrl.storage.read("isSignIn") ?? false;
    appCtrl.isLogged = isAdmin;
    log("isLogin;  $isAdmin");

    bool isTheme = appCtrl.storage.read(session.isDarkMode) ?? false;
    log("isTheme : $isTheme");
    update();
    appCtrl.isTheme = isTheme;
    ThemeService().switchTheme(appCtrl.isTheme);
    appCtrl.update();

    appCtrl.languageVal = appCtrl.storage.read(session.languageCode) ?? "en";
    log("language : ${appCtrl.languageVal}");
    if (appCtrl.languageVal == "en") {
      var locale = const Locale("en", 'US');
      Get.updateLocale(locale);
    } else if (appCtrl.languageVal == "ar") {
      var locale = const Locale("ar", 'AE');
      Get.updateLocale(locale);
    } else if (appCtrl.languageVal == "hi") {
      var locale = const Locale("hi", 'IN');
      Get.updateLocale(locale);
      Get.forceAppUpdate();
    } else {
      var locale = const Locale("ko", 'KR');
      Get.updateLocale(locale);
      Get.forceAppUpdate();
    }
    update();
  }

  deleteAccount(id, bool isSingleChat) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      try {
        if (isSingleChat == true) {
          await FirebaseFirestore.instance
              .collection(collectionName.users)
              .doc(id)
              .get()
              .then((value) async {
            if (value.exists) {
              await FirebaseFirestore.instance
                  .collection(collectionName.groups)
                  .get()
                  .then((groupValue) {
                if (groupValue.docs.isNotEmpty) {
                  groupValue.docs
                      .asMap()
                      .entries
                      .forEach((element) {
                    List users = element.value.data()["users"];
                    users.removeWhere((elements) => elements["id"] == id);
                    FirebaseFirestore.instance
                        .collection(collectionName.groups)
                        .doc(element.value.id)
                        .update({"users": users});
                  });
                }
              });
            }
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection(collectionName.users)
                .doc(id)
                .delete()
                .then((value) async {
              FirebaseFirestore.instance
                  .collection(collectionName.report)
                  .where("reportTo", isEqualTo: id)
                  .limit(1)
                  .get()
                  .then((reportValue) {
                if (reportValue.docs.isNotEmpty) {
                  FirebaseFirestore.instance
                      .collection(collectionName.report)
                      .doc(reportValue.docs[0].id)
                      .delete();
                }
              });
              await FirebaseAuth.instance.currentUser!.delete().then((value) =>
                  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
                    content: Text(fonts.deleteUser.tr),
                    backgroundColor: appCtrl.appTheme.greenColor,
                  )));
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection(collectionName.users)
              .get()
              .then((value) async {
            if (value.docs.isNotEmpty) {
              value.docs
                  .asMap()
                  .entries
                  .forEach((element) async {
                await FirebaseFirestore.instance
                    .collection(collectionName.users)
                    .doc(element.value.id)
                    .collection(collectionName.chats)
                    .where("groupId", isEqualTo: id)
                    .get()
                    .then((userGroup) {
                  if (userGroup.docs.isNotEmpty) {
                    userGroup.docs
                        .asMap()
                        .entries
                        .forEach((groupElement) async {
                      FirebaseFirestore.instance
                          .collection(collectionName.users)
                          .doc(element.value.id)
                          .collection(collectionName.chats)
                          .doc(groupElement.value.id)
                          .delete();
                    });
                  }
                });
              });
            }
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection(collectionName.groups)
                .doc(id)
                .delete().then((value) {
              FirebaseFirestore.instance
                  .collection(collectionName.report)
                  .where("reportTo", isEqualTo: id)
                  .limit(1)
                  .get()
                  .then((reportValue) {
                if (reportValue.docs.isNotEmpty) {
                  FirebaseFirestore.instance
                      .collection(collectionName.report)
                      .doc(reportValue.docs[0].id)
                      .delete();
                }
              });
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          log(
              'The user must reauthenticate before this operation can be executed.');
        }
      }
    }
  }
}
