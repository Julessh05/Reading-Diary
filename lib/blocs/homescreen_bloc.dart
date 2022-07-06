library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart' show BuildContext, Navigator;
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart';

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

  /// The Keyword which was entered to search with
  String _searchKeyword = '';

  /// The Book that the user filtered for.
  Book? searchBook;

  /// getter for the current Index of the Navigation Bar.
  /// This is immutable.
  int get currentBNBIndex => _currentBottomNavigationBarIndex;

  /// Setter for the Keyword which was entered to search with
  set searchKeyword(String word) => _searchKeyword = word;

  /// Called when you tap the
  /// Bottom navigation Bar.
  void onBNBTap(int newIndex) => _currentBottomNavigationBarIndex = newIndex;

  /// Called when the Button the
  /// the Diary Screen
  /// is tapped
  Future<void> onDiaryFabTap(BuildContext context) async {
    Navigator.pushNamed(context, Routes.addEntryScreen);
  }

  /// Called when the Button the
  /// the Wishlist Screen
  /// is tapped
  Future<void> onWishlistFabTap(BuildContext context) async {
    Navigator.pushNamed(context, Routes.addWishScreen);
  }

  /// Method called when the User
  /// clicked the 'Add Book' Item on the Dropdown.
  Future<void> openAddBookScreen(BuildContext context) async {
    Navigator.pushNamed(context, Routes.addBookScreen);
  }

  /// Called when the User pressed
  /// the OK Button inside the Search
  /// Dialog for the Diary Screen
  void onDiarySearchTap() {}

  /// Called when the User pressed
  /// the OK Button inside the Search
  /// Dialog for the Wishlist Screen
  void onWishSearchTap() {}

  @override
  void dispose() {}
}
