library models;

import 'package:flutter/material.dart' show Icon, Icons, Locale, ThemeMode;
import 'package:hive/hive.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;
import 'package:reading_diary/style/themes.dart';
import 'package:string_translate/string_translate.dart';

part 'setting.g.dart';

/// Represents a single Setting in this
/// App.
///
/// Can only have a Value of one Type.
/// If you specify a boolean Value, you can't specify a
/// Number or String Value in the same Setting.
/// Even though it's possible to change the Value Type,
/// you will run in an Error, because it's not a good Style
/// to change the Value Type of a Setting
/// to the runtime.
@HiveType(typeId: 3)
class Setting {
  Setting({
    required this.name,
    String? description,
    this.boolValue,
    this.numberValue,
    this.stringValue,
    this.objectValue,
    Icon? icon,
  }) : assert(
          boolValue != null &&
                  numberValue == null &&
                  stringValue == null &&
                  objectValue == null ||
              boolValue == null &&
                  numberValue != null &&
                  stringValue == null &&
                  objectValue == null ||
              boolValue == null &&
                  numberValue == null &&
                  stringValue != null &&
                  objectValue == null ||
              boolValue == null &&
                  numberValue == null &&
                  stringValue == null &&
                  objectValue != null,
          'You can only specify one Type of Value.',
        ) {
    _isInternal = false;
    _description = description ?? '';
    this.icon = icon ?? const Icon(Icons.settings_applications_rounded);
  }

  /// called when an Internal Setting
  /// is needed / wanted
  Setting.internal({
    required this.name,
    this.boolValue,
    this.numberValue,
    this.stringValue,
    this.objectValue,
  })  : assert(boolValue != null && numberValue == null),
        assert(boolValue == null && numberValue != null) {
    _isInternal = true;
    _description = 'Internal Setting';
    icon = const Icon(Icons.block_rounded);
  }

  /// Whether this is an internal Setting,
  /// that isn't shown to the User,
  /// or it's an non internal Setting,
  /// the User can influence.
  @HiveField(0)
  late bool _isInternal;

  /// The Name of the Setting.
  @HiveField(1)
  final String name;

  /// A Preciser Decription of this Setting,
  /// which is shown to the User.
  @HiveField(2)
  late String _description;

  /// If this Setting
  /// has a Value of Type
  /// bool, use this.
  @HiveField(3)
  bool? boolValue;

  /// If this Setting
  /// has a Value of Type
  /// number, use this.
  @HiveField(4)
  num? numberValue;

  /// If this Setting
  /// has a Value of Type
  /// String / Text, use this.
  @HiveField(5)
  String? stringValue;

  /// If this Setting
  /// has a Value of Type
  /// Object, use this.
  @HiveField(6)
  Object? objectValue;

  /// The Icon that is displayed
  /// to the User if this Setting
  /// is shown. Can only be set
  /// in an non internal Setting.
  late Icon icon;

  /// Getter for the preciser Decription
  /// of this Setting.
  String get description => _description;

  /// If the Settings aren't
  /// stored yet, this Method should be called.
  /// It creates all the Settings and
  /// declares it's default Values.
  static void createSettings() {
    Iterable<Setting> settings = {
      Setting(
        name: 'Language',
        description: 'Set the Language of your App.',
        objectValue: TranslationLocales.english,
        icon: const Icon(Icons.language_rounded),
      ),
      Setting(
        name: 'Theme',
        description: 'Set your Personal Style.',
        objectValue: ThemeMode.system,
        icon: const Icon(Icons.color_lens_rounded),
      ),
    };
    allSettings.addAll(settings);
  }

  /// Sets the Icons for the Settings.
  /// Has to be called once when opening the App.
  static void setIcons() {
    allSettings.where((element) => element.name == 'Language').first.icon =
        const Icon(Icons.language_rounded);

    allSettings.where((element) => element.name == 'Theme').first.icon =
        const Icon(Icons.color_lens_rounded);
  }

  /// Sets the Values to the Settings.
  static void setValues() {
    for (Setting setting in allSettings) {
      switch (setting.name) {
        case 'Language':
          Translation.changeLanguage(setting.objectValue as Locale);
          break;
        case 'Theme':
          Themes.themeMode = setting.objectValue as ThemeMode;
      }
    }
  }

  /// Reads the Values and sets the Settings.
  static void readValues() {
    allSettings
        .where((element) => element.name == 'Language')
        .first
        .objectValue = Translation.activeLocale;

    allSettings.where((element) => element.name == 'Theme').first.objectValue =
        Themes.themeMode;
  }
}

/// All the Settings that are used in this App
Set<Setting> allSettings = {};
