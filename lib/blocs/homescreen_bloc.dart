library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart' show BuildContext, Navigator;
import 'package:reading_diary/logic/navigating/routes.dart';

/// Bloc for the Homescreen.
/// Contains every piece of logic needed,
/// while the user is on the Homescreen.
class HomescreenBloc extends Bloc {
  /// The private index of
  /// the Bottom Navigation Bar
  /// on the Homescreen.
  int _currentBottomNavigationBarIndex = 0;

  /// Whether the Floating Action Button
  /// on the Diary Screen
  /// should be extended or not.
  bool diaryFabExtended = true;

  /// Whether the Floating Action Button
  /// on the Wishlist Screen
  /// should be extended or not.
  bool wishlistFabExtended = true;

  /// getter for the current Index of the Navigation Bar.
  /// This is immutable.
  int get currentBNBIndex => _currentBottomNavigationBarIndex;

  /// Called when you tap the
  /// Bottom navigation Bar.
  void onBNBTap(int newIndex) {
    _currentBottomNavigationBarIndex = newIndex;
  }

  Future<void> onFabTap(BuildContext context) async {
    Navigator.pushNamed(context, Routes.addEntryScreen);
  }

  @override
  void dispose() {}
}
