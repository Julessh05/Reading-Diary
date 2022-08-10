library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart' show Locale, ThemeMode;
import 'package:modern_themes/modern_themes.dart';
import 'package:reading_diary/blocs/event_bloc.dart';
import 'package:reading_diary/models/events/reload_event.dart';
import 'package:reading_diary/storage/storage.dart';
import 'package:string_translate/string_translate.dart' show Translation;

/// The Bloc for the Settings Screen.
class SettingsBloc extends Bloc {
  /// Changes the ThemeMode
  /// and stores the Settings.
  void changeThememode(ThemeMode nT) {
    Themes.changeTheme(nT);
    EventBloc.stream.sink.add(ReloadEvent());
    Storage.storeSettings();
  }

  /// Changes the Language
  /// and stores the Settings.
  void changeLanguage(Locale nL) {
    Translation.changeLanguage(nL);
    Storage.storeSettings();
  }

  @override
  void dispose() {}
}
