library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart' show BuildContext, Navigator;
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:reading_diary/models/wishlist.dart';

/// Bloc for the Screens with which
/// you can add a new Wish to your Wishlist
class AddWishBloc extends Bloc {
  /// Whether or not the done Button is enabled.
  bool _doneButtonEnabled = false;

  /// Book for that wish
  Book? wishBook;

  /// The Title of the Wish
  String? _title;

  /// The description for this Wish
  String? _description;

  /// Getter for the Variable that determines whether or not
  /// the Done Button is enabled.
  bool get doneButtonEnabled => _doneButtonEnabled;

  /// Setter for the Title of the Wish
  set title(String title) => _title = title;

  /// Setter for the Desription of this Wish
  set desription(String desc) => _description = desc;

  /// Checks if all
  /// required vars are set.
  void checkForVars() {
    if (wishBook != null || _description != null) {
      _doneButtonEnabled = true;
    } else {
      _doneButtonEnabled = false;
    }
  }

  /// Creates the Wish
  /// and adds it to the
  /// Wishlist
  void createWish() {
    if (wishBook == null) {
      Wishlist.addWish(
        Wish.withoutBook(
          title: _title,
          description: _description,
        ),
      );
    } else {
      Wishlist.addWish(
        Wish(
          book: wishBook,
          description: _description,
        ),
      );
    }
  }

  /// Opens the Screen
  /// on which you can add a new Book.
  Future<void> openAddBookScreen(BuildContext context) async {
    Navigator.pushNamed(context, Routes.addBookScreen);
  }

  @override
  void dispose() {}
}