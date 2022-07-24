library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart';
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
    );
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

  @override
  void dispose() {}
}
