library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/book_list.dart';

/// Bloc for the Add Book Screens
class AddBookBloc extends Bloc {
  /// The Variable that determines whether the
  /// Done Button is enabled or not.
  bool _doneButtonEnabled = false;

  /// Title of the Book
  String title = '';

  /// Author of the corresponding Book
  String? author;

  /// An image of the book
  Image? _image;

  /// The number of pages this
  /// book has
  int pages = 0;

  /// The Page the user is currently on
  int? currentPage;

  /// Notes you have to that book.
  String notes = '';

  /// The price of the book
  double? price;

  /// The URL to the
  /// Post connected to this Book.
  String? url;

  /// Setter for the Image to this Book.
  set image(Image img) => _image = img;

  /// The Variable that determines whether the
  /// Done Button is enabled or not.
  bool get doneButtonEnabled => _doneButtonEnabled;

  /// Creates a Book and adds it to
  /// [BookList.books]
  /// Returnes true, if the book
  /// does not alredy exist, and was added.
  /// Returns false, if the book couln't been added.
  bool createBook() {
    final book = Book(
      title: title,
      author: author,
      pages: pages,
      image: _image,
      notes: notes,
      price: price,
      currentPage: currentPage!,
      url: url,
    );
    final duplicateBooks = BookList.books.where((element) => element == book);
    if (duplicateBooks.isEmpty) {
      BookList.addBook(book);
      return true;
    } else {
      return false;
    }
  }

  /// Replaces a Book and returns
  /// the Replacement of the Book
  /// that was replaced.
  /// Book to repalce is the [toReplace]
  Book replaceBook(Book toReplace) {
    final Book book = Book(
        title: title,
        pages: pages,
        currentPage: currentPage!,
        author: author,
        image: _image,
        notes: notes,
        price: price,
        url: url);
    BookList.replaceBook(toReplace, book);
    return book;
  }

  /// Checks if all needed vars are filled in.
  void checkForVars() {
    if (title.isNotEmpty && pages > 0 && currentPage != null) {
      _doneButtonEnabled = true;
    } else {
      _doneButtonEnabled = false;
    }
  }

  /// Checks if the URL
  /// is allowed.
  /// For Safety Reasons
  /// only the urls in [Routes.supportedURLs]
  /// are allowed.
  bool checkURL() {
    if (url == null) {
      return true;
    } else if (url!.isEmpty) {
      return true;
    } else {
      if (Routes.supportedURLs.values.any(
        (String supportedURL) => url!.toLowerCase().startsWith(supportedURL),
      )) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void dispose() {}
}
