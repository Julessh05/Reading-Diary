library mobile_components;

import 'package:flutter/material.dart';

/// Settings Tile for the Mobile Version of
/// this App.
class SettingsTileMobile extends StatelessWidget {
  const SettingsTileMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      autofocus: false,
      enabled: true,
      isThreeLine: false,
    );
  }
}
