library values;

import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show StandardTranslations;

final Map<String, Map<Locale, String>> _translations = {};

Map<String, Map<Locale, String>> get translations {
  _translations.addAll(StandardTranslations.actions);
  _translations.addAll(StandardTranslations.error);

  return _translations;
}
