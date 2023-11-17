import 'package:get/get.dart';
import 'controllers/common_controller/app_controller.dart';
export 'package:chatzy_admin/routes/screen_list.dart';
export 'package:get/get.dart';
export 'controllers/common_controller/app_controller.dart';
export 'package:flutter/material.dart';
export 'package:get_storage/get_storage.dart';
export 'package:image_picker/image_picker.dart';
export 'package:chatzy_admin/responsive.dart';
export 'package:chatzy_admin/controllers/index.dart';
export 'package:chatzy_admin/package_list.dart';

// All extension
export 'package:chatzy_admin/extensions/text_style_extensions.dart';
export 'package:chatzy_admin/extensions/widget_extension.dart';
export 'package:chatzy_admin/extensions/spacing.dart';
export 'package:chatzy_admin/utils/extensions.dart';

// All common files
export 'package:chatzy_admin/common/theme/app_theme.dart';
export 'package:chatzy_admin/common/theme/theme_service.dart';
export 'package:chatzy_admin/common/theme/app_css.dart';
export 'package:chatzy_admin/common/config.dart';

// All Screens
export 'package:chatzy_admin/screens/auth_login_screen/layouts/glass_morphic_border.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/login_gradient.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/glass_morphic_layout.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/validator.dart';
export 'package:chatzy_admin/screens/usage_control_screen/layouts/switch_common.dart';
export 'package:chatzy_admin/screens/usage_control_screen/layouts/text_field_common.dart';
export 'package:chatzy_admin/screens/usage_control_screen/layouts/desktop_switch_common.dart';
export 'package:chatzy_admin/screens/usage_control_screen/layouts/desktop_text_field_common.dart';
export 'package:chatzy_admin/screens/usage_control_screen/layouts/usage_control_desktop.dart';
export 'package:chatzy_admin/screens/usage_control_screen/layouts/usage_control_mobile.dart';
export 'package:chatzy_admin/screens/usage_control_screen/layouts/button_layout.dart';
export 'package:chatzy_admin/screens/user_app_settings_screen/layouts/user_app_settings_desktop.dart';
export 'package:chatzy_admin/screens/user_app_settings_screen/layouts/user_app_settings_mobile.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/dark_language_layout.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/login_layout.dart';
export 'package:chatzy_admin/screens/add_user_screen/layouts/text_field_desktop.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/dark_mode_layout.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/language_layout.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/login_body_layout.dart';
export 'package:chatzy_admin/screens/auth_login_screen/layouts/login_class.dart';
export 'package:chatzy_admin/screens/index/layouts/drawer.dart';
export 'package:chatzy_admin/screens/index/layouts/drawer_list.dart';
export 'package:chatzy_admin/screens/index/layouts/leading_row.dart';
export 'package:chatzy_admin/screens/index/layouts/selected_body_layout.dart';


// All widgets library
export 'package:chatzy_admin/widgets/button_common.dart';
export 'package:chatzy_admin/widgets/common_dotted_border.dart';
export 'package:chatzy_admin/widgets/drag_drop_layout.dart';
export 'package:chatzy_admin/widgets/image_pick_up.dart';
export 'package:chatzy_admin/widgets/custom_snack_bar.dart';
export 'package:chatzy_admin/widgets/common_text_box.dart';
export 'package:chatzy_admin/widgets/common_button.dart';
export 'package:chatzy_admin/widgets/text_field_validation.dart';
export 'package:chatzy_admin/widgets/helper_function.dart';
export 'package:chatzy_admin/screens/admin_status_screen/layouts/status_model.dart';

// All screens library
export 'package:chatzy_admin/screens/dashboard/dashboard.dart';
export 'package:chatzy_admin/screens/user_app_settings_screen/user_app_settings_screen.dart';
export 'package:chatzy_admin/screens/admin_status_screen/admin_status_screen.dart';
export 'package:chatzy_admin/screens/usage_control_screen/usage_control_screen.dart';
export 'package:chatzy_admin/screens/index/index.dart';

var appCtrl = Get.isRegistered<AppController>()
    ? Get.find<AppController>()
    : Get.put(AppController());