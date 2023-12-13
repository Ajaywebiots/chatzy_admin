import 'dart:developer';

import 'package:chatzy_admin/models/user_setting_model.dart';
import 'package:chatzy_admin/screens/user_app_settings_screen/layouts/ad_show_hide.dart';

import '../../config.dart';
import 'layouts/all_text_box_desktop.dart';

class UserAppSettingsScreen extends StatelessWidget {
  final userSettingCtrl = Get.put(UserAppSettingsController());

  UserAppSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAppSettingsController>(builder: (_) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(collectionName.config)
              .doc(collectionName.userAppSettings)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              log("CHECK DATA : ${snapshot.data!.data()}");
              userSettingCtrl.usageCtrl =
                  UserAppSettingModel.fromJson(snapshot.data!.data()!);
              return SingleChildScrollView(
                  child: Stack(alignment: Alignment.center, children: [
                Form(
                    key: userSettingCtrl.formKey,
                    child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                        Responsive.isMobile(context) ||
                                                Responsive.isTablet(context)
                                            // Mobile view
                                            ? UserAppSettingsMobile(
                                                userAppSettingModel:
                                                    userSettingCtrl.usageCtrl)
                                            // Desktop view
                                            : UserAppSettingsDesktop(
                                                userAppSettingModel:
                                                    userSettingCtrl.usageCtrl),
                                      ])),
                                ),
                                const HSpace(Sizes.s20),
                                if (Responsive.isDesktop(context))
                                  Expanded(
                                    child: AdShowHide(
                                        userAppSettingModel:
                                            userSettingCtrl.usageCtrl),
                                  ),
                              ],
                            ),
                          ),

                          const VSpace(Sizes.s20),
                          if (Responsive.isDesktop(context))
                            const AllTextBoxDesktop(),
                          // Update button & Note
                          ButtonLayout(
                              onTap: () => userSettingCtrl.updateData()).paddingOnly(bottom: 20)
                        ])
                      
                        ),
                if (userSettingCtrl.isLoading)
                  Center(
                      child: CircularProgressIndicator(
                          color: appCtrl.appTheme.primary))
              ]));
            } else {
              return Container();
            }
          });
    });
  }
}
