library models;

import 'package:flutter/material.dart' show Icon, Icons, ThemeMode;
import 'package:hive/hive.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;
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
    _icon = icon ?? const Icon(Icons.settings_applications_rounded);
    if (boolValue != null) {
      _valueType = bool;
    } else if (numberValue != null) {
      _valueType = num;
    } else if (stringValue != null) {
      _valueType = String;
    } else {
      _valueType = Object;
    }
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
    _icon = const Icon(Icons.block_rounded);
    if (boolValue != null) {
      _valueType = bool;
    } else if (numberValue != null) {
      _valueType = num;
    } else if (stringValue != null) {
      _valueType = String;
    } else {
      _valueType = Object;
    }
  }

  /// The Type of the
  /// Value this Setting has.
  @HiveField(0)
  late final Type _valueType;

  /// Whether this is an internal Setting,
  /// that isn't shown to the User,
  /// or it's an non internal Setting,
  /// the User can influence.
  @HiveField(1)
  late final bool _isInternal;

  /// The Name of the Setting.
  @HiveField(2)
  final String name;

  /// A Preciser Decription of this Setting,
  /// which is shown to the User.
  @HiveField(3)
  late final String _description;

  /// If this Setting
  /// has a Value of Type
  /// bool, use this.
  @HiveField(4)
  bool? boolValue;

  /// If this Setting
  /// has a Value of Type
  /// number, use this.
  @HiveField(5)
  num? numberValue;

  /// If this Setting
  /// has a Value of Type
  /// String / Text, use this.
  @HiveField(6)
  String? stringValue;

  /// If this Setting
  /// has a Value of Type
  /// Object, use this.
  @HiveField(7)
  Object? objectValue;

  /// The Icon that is displayed
  /// to the User if this Setting
  /// is shown. Can only be set
  /// in an non internal Setting.
  @HiveField(8)
  late final Icon _icon;

  /// Getter for the preciser Decription
  /// of this Setting.
  String get description => _description;

  /// The Icon that is displayed
  /// to the User if this Setting
  /// is shown. Can only be set
  /// in an non internal Setting.
  Icon get icon => _icon;

  /// Updates the Value of the Setting.
  /// The parameter [newValue] is of
  /// the Type dynamic,
  /// what makes it possible to
  /// call this Method without having to worry
  /// about what Value Type your Setting has.
  /// Also it allows to only have a single Method.
  /// But if you pass a bool and your Value type
  /// is String, you will raise an runtime Error.
  /// So be causious about what you pass.
  void updateValue(dynamic newValue) {
    switch (_valueType) {
      case bool:
        boolValue = newValue;
        break;
      case num:
        numberValue = newValue;
        break;
      case String:
        stringValue = newValue;
        break;
      case Object:
      default:
        objectValue = newValue;
        break;
    }
  }

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
        fn: () {},
      ),
    };
    allSettings.addAll(settings);
  }
}

/// All the Settings that are used in this App
Set<Setting> allSettings = {};
