import 'package:easy_localization/easy_localization.dart';

abstract class EditProfileConstants {
  EditProfileConstants._();

  static String get title => 'edit_profile.title'.tr();
  static String get firstName => 'edit_profile.first_name'.tr();
  static String get lastName => 'edit_profile.last_name'.tr();
  static String get email => 'edit_profile.email'.tr();
  static String get phone => 'edit_profile.phone'.tr();
  static String get password => 'edit_profile.password'.tr();
  static String get changePassword => 'edit_profile.change_password'.tr();
  static String get update => 'edit_profile.update'.tr();
  static String get noChanges => 'edit_profile.no_changes'.tr();
  static String get updateSuccess => 'edit_profile.update_success'.tr();
}
