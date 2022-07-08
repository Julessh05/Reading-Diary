library mobile_components;

import 'package:flutter/material.dart';
import 'package:reading_diary/models/setting.dart' show Setting;

/// Settings Tile for the Mobile Version of
/// this App.
///
/// Use this only to display non-internal Settings.
/// Internal Settings are supposed to only be used
/// inside the App, without the User knowing.
/// So they shouldn't be displayed here.
class SettingsTileMobile extends StatelessWidget {
  const SettingsTileMobile({
    required this.setting,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  /// The Setting this
  /// Tile represents.
  final Setting setting;

  /// The Function called when the User
  /// taps on the List Tile
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      autofocus: false,
      enabled: true,
      isThreeLine: false,
      title: Text(setting.name),
      subtitle: Text(setting.description),
      leading: setting.icon,
      onTap: onTap,
    );
  }
}
