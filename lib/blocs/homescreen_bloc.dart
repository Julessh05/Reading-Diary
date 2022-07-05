library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart';
import 'package:reading_diary/logic/navigating/routes.dart';

/// Bloc for the Homescreen.
/// Contains every piece of logic needed,
/// while the user is on the Homescreen.
class HomescreenBloc extends Bloc {
  /// The private index of
  /// the Bottom Navigation Bar
  /// on the Homescreen.
  int _currentBottomNavigationBarIndex = 0;

  /// Whether the Floating Action Button should be extended or no .
  bool fabExtended = true;

  /// getter for the current Index of the Navigation Bar.
  /// This is immutable.
  int get currentBNBIndex => _currentBottomNavigationBarIndex;

  /// Called when you tap the
  /// Bottom navigation Bar.
  void onBNBTap(int newIndex) {
    _currentBottomNavigationBarIndex = newIndex;
  }

  void onFabTap(BuildContext context) {
    Navigator.pushNamed(context, Routes.addEntryScreen);
  }

  @override
  void dispose() {}
}
