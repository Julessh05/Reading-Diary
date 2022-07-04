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
      brightness: Brightness.light,

      /* Colors */
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,

      /* Icon Themes */
      iconTheme: const IconThemeData(
        color: Colors.black,
        opacity: 1.0,
      ),

      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 10.0,
        enableFeedback: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          opacity: 1.0,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.white,
          opacity: 1.0,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        mouseCursor: MaterialStateProperty.resolveWith(
          ((states) => _lightBottomNavigationBarMouseCursor(states)),
        ),
      ),
    );
  }

  /// Returns the Mouse Curser for the Bottom Navigation Bar
  /// in the light Mode, depending on the Material State
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
