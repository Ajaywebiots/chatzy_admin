import 'dart:developer';
import 'package:chatzy_admin/config.dart';
import 'package:chatzy_admin/models/usage_control_model.dart';

class UsageControlController extends GetxController {
  UsageControlModel? usageCtrl;
  bool isLoading = false;
  String? id;
  TextEditingController broadCastMemberLimit = TextEditingController();
  TextEditingController groupMemberLimit = TextEditingController();
  TextEditingController maxContactSelectForward = TextEditingController();
  TextEditingController maxFileSize = TextEditingController();
  TextEditingController maxFileMultiShare = TextEditingController();
  TextEditingController statusDeleteTime = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //get data from firebase
  getData() async {
    final usageControls = await FirebaseFirestore.instance
        .collection(collectionName.config)
        .doc(collectionName.usageControls)
        .get();
    if (usageControls.exists) {
      id = usageControls.id;
      usageCtrl = UsageControlModel.fromJson(usageControls.data()!);
      log("get data IN: ${usageControls.data()!["allowCreatingGroup"]}");
      broadCastMemberLimit.text = usageCtrl!.broadCastMembersLimit.toString();
      groupMemberLimit.text = usageCtrl!.groupMembersLimit.toString();
      maxContactSelectForward.text =
          usageCtrl!.maxContactSelectForward.toString();
      maxFileSize.text = usageCtrl!.maxFileSize.toString();
      maxFileMultiShare.text = usageCtrl!.maxFilesMultiShare.toString();
      statusDeleteTime.text = usageCtrl!.statusDeleteTime.toString();
    }
    update();
  }

  //update data
  updateData() async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest) ?? false;
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      if (formKey.currentState!.validate()) {
        usageCtrl!.broadCastMembersLimit = int.parse(broadCastMemberLimit.text);
        usageCtrl!.groupMembersLimit = int.parse(groupMemberLimit.text);
        usageCtrl!.maxContactSelectForward =
            int.parse(maxContactSelectForward.text);
        usageCtrl!.maxFileSize = int.parse(maxFileSize.text);
        usageCtrl!.maxFilesMultiShare = int.parse(maxFileMultiShare.text);
        usageCtrl!.statusDeleteTime = statusDeleteTime.text;

        log("usage: $usageCtrl");


        isLoading = true;
        log("usage2: $usageCtrl");
        update();
        await FirebaseFirestore.instance
            .collection(collectionName.config)
            .doc(collectionName.usageControls)
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
  onChangeSwitcher(title, value) async {
    bool isLoginTest = appCtrl.storage.read(session.isLoginTest);
    if (isLoginTest) {
      accessDenied(fonts.modification.tr);
    } else {
      await FirebaseFirestore.instance
          .collection(collectionName.config)
          .doc(collectionName.usageControls)
          .update({title: value}).then((value) => getData());

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
