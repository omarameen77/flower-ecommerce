import 'package:flower/core/localization_constants/profile_constants.dart';

String profileLanguageLabel(String languageCode) {
  return languageCode == 'en'
      ? ProfileConstants.english
      : ProfileConstants.arabic;
}
