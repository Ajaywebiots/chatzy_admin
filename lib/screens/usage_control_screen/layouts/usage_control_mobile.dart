import 'package:chatzy_admin/models/usage_control_model.dart';


import '../../../config.dart';

class UsageControlMobile extends StatelessWidget {
  final UsageControlModel? usageControlModel;
  const UsageControlMobile({Key? key,this.usageControlModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsageControlController>(builder: (usageCtrl) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        MobileSwitchCommon(
            title: fonts.allowCreatingBroadcast,
            value: usageControlModel!.allowCreatingBroadcast!,
            onChanged: (val)=> usageCtrl.onChangeSwitcher("allowCreatingBroadcast", val)),
        MobileSwitchCommon(
          title: fonts.allowCreatingGroup,
          value: usageControlModel!.allowCreatingGroup,
          onChanged: (val)=> usageCtrl.onChangeSwitcher("allowCreatingGroup", val)
        ),
        MobileSwitchCommon(
            title: fonts.allowCreatingStatus,
            value: usageControlModel!.allowCreatingStatus,
            onChanged: (val) => usageCtrl.onChangeSwitcher("allowCreatingStatus", val)),
        MobileSwitchCommon(
            title: fonts.callsAllowed,
            value: usageControlModel!.callsAllowed,
            onChanged: (val) => usageCtrl.onChangeSwitcher("callsAllowed", val)),
        MobileSwitchCommon(
            title: fonts.existenceUser,
            value: usageControlModel!.existenceUsers,
            onChanged: (val)  => usageCtrl.onChangeSwitcher("existenceUsers", val)),
        MobileSwitchCommon(
            title: fonts.mediaSendAllowed,
            value: usageControlModel!.mediaSendAllowed,
            onChanged: (val)  => usageCtrl.onChangeSwitcher("mediaSendAllowed", val)),
        MobileSwitchCommon(
            title: fonts.showLogoutButton,
            value: usageControlModel!.showLogoutButton,
            onChanged: (val) => usageCtrl.onChangeSwitcher("showLogoutButton", val)),
        MobileSwitchCommon(
            title: fonts.textMessageAllowed,
            value: usageControlModel!.textMessageAllowed,
            onChanged: (val) => usageCtrl.onChangeSwitcher("textMessageAllowed", val)),
        MobileSwitchCommon(
            title: fonts.allowUserSignup,
            value: usageControlModel!.allowUserSignup,
            onChanged: (val) => usageCtrl.onChangeSwitcher("allowUserSignup", val)),
        MobileTextFieldCommon(
            validator: (number) => Validation().broadCastValidation(number),
            title: fonts.broadcastMemberLimit,
            controller: usageCtrl.broadCastMemberLimit),
        MobileTextFieldCommon(
            validator: (number) => Validation().groupValidation(number),
            title: fonts.groupMemberLimit,
            controller: usageCtrl.groupMemberLimit),
        MobileTextFieldCommon(
            validator: (number) => Validation().maxContactValidation(number),
            title: fonts.maxContactSelectForward,
            controller: usageCtrl.maxContactSelectForward),
        MobileTextFieldCommon(
            validator: (number) => Validation().maxFileValidation(number),
            title: fonts.maxFileSize,
            controller: usageCtrl.maxFileSize),
        MobileTextFieldCommon(
            validator: (number) => Validation().maxFileMultiValidation(number),
            title: fonts.maxFileMultiShare,
            controller: usageCtrl.maxFileMultiShare),
        MobileTextFieldCommon(
            // isNote: true,
            validator: (number) => Validation().statusValidation(number),
            title: fonts.statusDeleteTime,
            controller: usageCtrl.statusDeleteTime)
      ]).paddingAll(Insets.i15);
    });
  }
}
