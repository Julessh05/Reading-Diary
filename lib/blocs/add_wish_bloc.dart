import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:reading_diary/models/wishlist.dart';

/// Bloc for the Screens with which
/// you can add a new Wish to your Wishlist
class AddWishBloc extends Bloc {
  /// Whether or not the done Button is enabled.
  bool _doneButtonEnabled = false;

  /// Book for that wish
  Book wishBook = const Book.none();

  /// The Title of the Wish
  String? title;

  /// The description for this Wish
  String? description;

  /// Getter for the Variable that determines whether or not
  /// the Done Button is enabled.
  bool get doneButtonEnabled => _doneButtonEnabled;

  /// Checks if all
  /// required vars are set.
  void checkForVars() {
    if (wishBook == const Book.none()) {
      if (title != null && description != null) {
        _doneButtonEnabled = true;
      } else {
        _doneButtonEnabled = false;
      }
    } else {
      _doneButtonEnabled = true;
    }
  }

  /// Creates the Wish
  /// and adds it to the
  /// Wishlist
  void createWish() {
    if (wishBook == const Book.none()) {
      Wishlist.addWish(
        Wish.withoutBook(
          title: title!,
          description: description,
        ),
      );
    } else {
      Wishlist.addWish(
        Wish(
          book: wishBook,
          description: description,
        ),
      );
    }
  }

  /// Replaces a Wish
  /// in the Wishlist.
  Wish replaceWish(Wish toReplace) {
    final Wish wish;
    if (wishBook == const Book.none()) {
      wish = Wish.withoutBook(
        title: title!,
        description: description,
      );
    } else {
      wish = Wish(
        book: wishBook,
        description: description,
      );
    }
    Wishlist.replaceWish(toReplace, wish);
    return wish;
  }

  @override
  void dispose() {}
}
