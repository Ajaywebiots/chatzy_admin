import '../../config.dart';

class AddUserScreen extends StatelessWidget {
  final StateSetter? setState;
  final addUserCtrl = Get.put(AddUserController());

  AddUserScreen({Key? key, this.setState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUserController>(builder: (_) {
      return SizedBox(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r50)),
                  child: SizedBox(
                      height: Sizes.s100,
                      width: Sizes.s100,
                      child:  addUserCtrl.imageUrl.isNotEmpty &&
                          addUserCtrl.pickImage != null
                          ?  Image.memory(
                          addUserCtrl.webImage,
                          fit: BoxFit.fill)
                          .inkWell(
                          onTap: () =>
                              addUserCtrl.getImage(
                                  source: ImageSource.gallery,
                                  context: context))
                          : addUserCtrl.pickImage == null
                          ? Image.asset(imageAssets.addUser,fit: BoxFit.contain).inkWell(
                          onTap: () =>
                              addUserCtrl.onImagePickUp(
                                  setState, context))
                          : Image.memory(
                          addUserCtrl.webImage,
                          fit: BoxFit.fill)
                          .inkWell(
                          onTap: () =>
                              addUserCtrl.getImage(
                                  source: ImageSource.gallery,
                                  context: context)),).decorated(shape: BoxShape.circle)
                ),
                const VSpace(Sizes.s50),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Form(
                          key: addUserCtrl.formKey,
                          child: Responsive.isMobile(context) ||
                                  Responsive.isTablet(context)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text(fonts.name.tr,
                                          style: AppCss.muktaVaaniBold16.textColor(
                                              appCtrl.appTheme.blackColor)),
                                      const VSpace(Sizes.s10),
                                      CommonTextBox(
                                          controller: addUserCtrl.nameCtrl,
                                          validator: (val) => LoginValidator()
                                              .checkNameValidation(val),
                                          hinText: fonts.enterName.tr),
                                      const VSpace(Sizes.s30),
                                      Text(fonts.phoneNumber.tr,
                                          style: AppCss.muktaVaaniBold16.textColor(
                                              appCtrl.appTheme.blackColor)),
                                      const VSpace(Sizes.s10),
                                      CommonTextBox(
                                          controller: addUserCtrl.numberCtrl,
                                          validator: (val) => LoginValidator()
                                              .checkNumberValidation(val),
                                          hinText: fonts.enterNumber.tr),
                                      const VSpace(Sizes.s30),
                                      Text(fonts.email.tr,
                                          style: AppCss.muktaVaaniBold16.textColor(
                                              appCtrl.appTheme.blackColor)),
                                      const VSpace(Sizes.s10),
                                      CommonTextBox(
                                          controller: addUserCtrl.emailCtrl,
                                          hinText: fonts.enterEmail.tr)
                                    ])
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextFieldDesktop(
                                        title: fonts.name,
                                        controller: addUserCtrl.nameCtrl,
                                        hintText: fonts.enterName,
                                        validator: (val) => LoginValidator()
                                            .checkNameValidation(val)),
                                    TextFieldDesktop(
                                        title: fonts.phoneNumber,
                                        controller: addUserCtrl.numberCtrl,
                                        hintText: fonts.enterNumber,
                                        validator: (val) => LoginValidator()
                                            .checkNumberValidation(val)),
                                    TextFieldDesktop(
                                        title: fonts.email,
                                        controller: addUserCtrl.emailCtrl,
                                        hintText: fonts.enterEmail),
                                  ],
                                )),
                      UpdateButton(
                          title: fonts.addUser,
                          onPressed: () {
                            if (addUserCtrl.formKey.currentState!.validate()) {}
                          }).paddingOnly(top: Insets.i20)
                    ])
              ])).paddingAll(Insets.i15).boxExtension();
    });
  }
}
