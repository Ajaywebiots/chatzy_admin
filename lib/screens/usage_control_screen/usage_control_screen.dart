import 'package:chatzy_admin/models/usage_control_model.dart';
import 'package:chatzy_admin/screens/usage_control_screen/layouts/usage_control_text_box_desktop.dart';
import 'package:chatzy_admin/screens/usage_control_screen/layouts/usage_control_responsive.dart';

import '../../config.dart';

class UsageControlScreen extends StatelessWidget {
  final usageCtrl = Get.put(UsageControlController());

  UsageControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsageControlController>(builder: (_) {
      if (usageCtrl.usageCtrl != null) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collectionName.config)
                .doc(collectionName.usageControls)
                .snapshots(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                usageCtrl.usageCtrl =
                    UsageControlModel.fromJson(snapShot.data!.data()!);
                return SingleChildScrollView(
                    child: Form(
                  key: usageCtrl.formKey,
                  child: Column(children: [
                    Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          UsageControlResponsive(
                              configModel: usageCtrl.usageCtrl),
                          const VSpace(Sizes.s20),
                        ])
                        .paddingSymmetric(vertical: Insets.i25)
                        .boxExtension(),
                    if (Responsive.isDesktop(context))
                      const UsageControlAllTextBoxDesktop(),
                    // Update button & Note
                    ButtonLayout(onTap: () => usageCtrl.updateData()),
                    if (usageCtrl.isLoading)
                      Center(
                          child: CircularProgressIndicator(
                              color: appCtrl.appTheme.primary))
                  ]).marginOnly(bottom: Insets.i40),
                ));
              } else {
                return Container();
              }
            });
      } else {
        return Container();
      }
    });
  }
}
