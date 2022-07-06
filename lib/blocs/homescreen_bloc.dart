library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart' show BuildContext, Navigator;
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart';
import 'package:reading_diary/models/wish.dart';
import 'package:reading_diary/models/wishlist.dart';

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
  /// on the Entry Screen.
  String _diarySearchKeyword = '';

  /// The Keyword the User wants to
  /// search with on the Wishlist
  /// Screen.
  String _wishlistSearchKeyword = '';

  /// The List of Results
  /// from the Search on the Diary Screen.
  final List<DiaryEntry> _diarySearchResults = [];

  /// The List of Results
  /// from the Search on the Wish Screen.
  final List<Wish> _wishSearchResults = [];

  /// The Book that the user filtered for.
  Book? diarySearchBook;

  /// getter for the current Index of the Navigation Bar.
  /// This is immutable.
  int get currentBNBIndex => _currentBottomNavigationBarIndex;

  /// Setter for the Keyword which was entered to search with
  /// inside the Diary Entries
  set diarySearchKeyword(String word) => _diarySearchKeyword = word;

  /// Setter for the Keyword with which the User wants to
  /// search inside the Wishlist.
  set wishlistSearchKeyword(String word) => _wishlistSearchKeyword = word;

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
  void onDiarySearchTap() {
    for (DiaryEntry entry in Diary.entries) {
      if (entry.title != null) {
        if (entry.title!.contains(_diarySearchKeyword)) {
          _diarySearchResults.add(entry);
        } else {
          continue;
        }
      } else if (entry.entry.contains(_diarySearchKeyword)) {
        _diarySearchResults.add(entry);
      } else if (entry.book != null) {
        if (entry.book == diarySearchBook) {
          _diarySearchResults.add(entry);
        } else {
          continue;
        }
      } else {
        continue;
      }
    }
  }

  /// Called when the User pressed
  /// the OK Button inside the Search
  /// Dialog for the Wishlist Screen
  void onWishSearchTap() {
    for (Wish wish in Wishlist.wishes) {
      if (wish.title != null) {
        if (wish.title!.contains(_wishlistSearchKeyword)) {
          _wishSearchResults.add(wish);
        } else {
          continue;
        }
      } else if (wish.description != null) {
        if (wish.description!.contains(_wishlistSearchKeyword)) {
          _wishSearchResults.add(wish);
        }
      } else {
        continue;
      }
    }
  }

  @override
  void dispose() {}
}
