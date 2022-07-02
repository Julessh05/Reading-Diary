library style;

import 'package:flutter/material.dart';

/// Contains everything, that has something to
/// do with Themes and Styling
class Themes {
  /// Theme Mode which regulates, what Theme to use.
  static ThemeMode themeMode = ThemeMode.system;

  /// Light Theme.
  /// The Standard Theme
  static ThemeData get lightTheme {
    return ThemeData(
      /* General */
      useMaterial3: true,

      /* Colors */

      /* Icon Themes */
      iconTheme: const IconThemeData(
        color: Colors.black,
        opacity: 0.0,
        shadows: <Shadow>[
          BoxShadow(),
          Shadow(),
        ],
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 10.0,
        enableFeedback: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        mouseCursor: MaterialStateProperty.resolveWith(
          ((states) => _lightBottomNavigationBarMouseCursor(states)),
        ),
      ),
    );
  }

  static MouseCursor _lightBottomNavigationBarMouseCursor(
      Set<MaterialState> states) {
    const localStates = <MaterialState>{
      MaterialState.focused,
      MaterialState.hovered,
      MaterialState.pressed,
    };
    if (states.any(localStates.contains)) {
      return SystemMouseCursors.click;
    }
    return SystemMouseCursors.basic;
  }

  /// Dark Theme.
  /// Theme for the Night
  static ThemeData get darkTheme {
    return ThemeData();
  }

  /// Theme for those who activated the High Contrast Mode.
  /// Replaces the [lightTheme]
  static ThemeData get highContrastLightTheme {
    return ThemeData();
  }

  /// Theme for those who activated the High Contrast Mode.
  /// Replaces the [darkTheme]
  static ThemeData get highContrastDarkTheme {
    return ThemeData();
  }
}
