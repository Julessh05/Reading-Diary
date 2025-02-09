import 'package:flutter/material.dart'
    show
        Brightness,
        BuildContext,
        Color,
        Colors,
        Icon,
        Icons,
        Locale,
        Theme,
        ThemeMode;
import 'package:hive_ce/hive.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;
import 'package:modern_themes/modern_themes.dart';
import 'package:string_translate/string_translate.dart'
    show Translation, TranslationLocales;

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
  Icon? icon;

  /// Getter for the preciser Decription
  /// of this Setting.
  String get description => _description;

  /// the name for the Language Setting.
  static const String languageName = 'Language';

  /// the name for the Theme Setting.
  static const String themeName = 'Theme';

  /// the name for the Color Setting.
  static const String colorName = 'Color';

  /// The Setting that manages the Language
  /// of this App-
  static final Setting _languageSetting = Setting(
    name: languageName,
    description: 'Set the Language of your App.',
    objectValue: TranslationLocales.english,
  );

  /// The Setting that manages the Theme
  /// of this App-
  static final Setting _themeSetting = Setting(
    name: themeName,
    description: 'Set your Personal Style.',
    objectValue: ThemeMode.system,
  );

  /// The Setting that manages the main Color
  /// of this App-
  static final Setting _colorSetting = Setting(
    name: colorName,
    description: 'Set the Color of your App.',
    objectValue: Colors.amberAccent.shade400,
  );

  /// If the Settings aren't
  /// stored yet, this Method should be called.
  /// It creates all the Settings and
  /// declares it's default Values.
  static void createSettings() {
    Iterable<Setting> settings = {
      _languageSetting,
      _themeSetting,
      _colorSetting,
    };
    allSettings.addAll(settings);
  }

  /// Created only one specific Setting.
  static void createSingleSettings(Set<String> names) {
    for (String name in names) {
      switch (name) {
        case languageName:
          allSettings.add(_languageSetting);
          break;
        case themeName:
          allSettings.add(_themeSetting);
          break;
        case colorName:
          allSettings.add(_colorSetting);
          break;
      }
    }
  }

  /// Sets the Icons for the Settings.
  /// Has to be called once when opening the App.
  static void setIcons() {
    settingForName(languageName).icon = const Icon(Icons.language_rounded);

    settingForName(themeName).icon = const Icon(Icons.light_mode_rounded);

    settingForName(colorName).icon = const Icon(Icons.colorize_rounded);
  }

  /// Changes the Icon of a Setting at the runtime.
  static void changeIconOnRuntime(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      settingForName(themeName).icon = const Icon(Icons.dark_mode_rounded);
    } else {
      settingForName(themeName).icon = const Icon(Icons.light_mode_rounded);
    }
  }

  /// Sets the Values to the Settings.
  static void setValues() {
    for (Setting setting in allSettings) {
      switch (setting.name) {
        case languageName:
          Translation.changeLanguage(setting.objectValue as Locale);
          break;
        case themeName:
          Themes.changeTheme(setting.objectValue as ThemeMode);
          break;
        case colorName:
          Coloring.changeColor(setting.objectValue as Color);
          break;
      }
    }
  }

  /// Reads the Values and sets the Settings.
  static void readValues() {
    settingForName(languageName).objectValue = Translation.activeLocale;

    settingForName(themeName).objectValue = Themes.themeMode;

    settingForName(colorName).objectValue = Coloring.mainColor;
  }

  /// Returns the Setting of the specified [name]
  static Setting settingForName(String name) {
    bool ex = false;
    do {
      try {
        return allSettings.where((element) => element.name == name).first;
      } on Exception {
        ex = true;
        createSettings();
      }
    } while (ex);
  }
}

/// All the Settings that are used in this App
Set<Setting> allSettings = {};
