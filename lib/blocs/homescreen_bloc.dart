library blocs;

import 'dart:async' show StreamController;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/search_results.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:reading_diary/models/wishlist.dart';
import 'package:reading_diary/states/homescreen_state.dart';

/// Bloc for the Homescreen.
/// Contains every piece of logic needed,
/// while the user is on the Homescreen.
class HomescreenBloc extends Bloc {
  /// The Stream which controlls the States
  StreamController<HomescreenState> stateStream = StreamController();

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

  /// Whether the Floating Action Button
  /// on the Book Screen
  /// should be extended or not.
  bool bookFabExtended = true;

  /// The Keyword which was entered to search with.
  String searchKeyword = '';

  /// The List of Results from the Search.
  final List<Object> _searchResults = [];

  /// The Book that the user filtered for.
  Book? diarySearchBook;

  /// getter for the current Index of the Navigation Bar.
  /// This is immutable.
  int get currentBNBIndex => _currentBottomNavigationBarIndex;

  /// Called when you tap the
  /// Bottom navigation Bar.
  void onBNBTap(int newIndex) => _currentBottomNavigationBarIndex = newIndex;

  /// Called when the Search Button
  /// on any Homscreen is tapped.
  /// Returns the List of Search Results.
  SearchResults onSearchTap() {
    for (DiaryEntry entry in Diary.entries) {
      if (entry.title.contains(searchKeyword)) {
        _searchResults.add(entry);
      } else if (entry.content.contains(searchKeyword)) {
        _searchResults.add(entry);
      } else if (entry.book == diarySearchBook) {
        _searchResults.add(entry);
      } else {
        continue;
      }
    }

    for (Wish wish in Wishlist.wishes) {
      if (wish.title.contains(searchKeyword)) {
        _searchResults.add(wish);
      } else if (wish.description != null) {
        if (wish.description!.contains(searchKeyword)) {
          _searchResults.add(wish);
        }
      } else {
        continue;
      }
    }

    for (Book book in BookList.books) {
      if (book.title.contains(searchKeyword)) {
        _searchResults.add(book);
      } else if (book.notes.contains(searchKeyword)) {
        _searchResults.add(book);
      } else if (book.author != null) {
        if (book.author!.contains(searchKeyword)) {
          _searchResults.add(book);
        } else {
          continue;
        }
      } else {
        continue;
      }
    }

    return SearchResults(
      results: _searchResults,
      search: searchKeyword,
    );
  }

  @override
  void dispose() {}
}
