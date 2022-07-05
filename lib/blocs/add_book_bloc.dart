library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart';
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/book_list.dart';

/// Bloc for the Add Book Screens
class AddBookBloc extends Bloc {
  /// The Variable that determines whether the
  /// Done Button is enabled or not.
  bool _doneButtonEnabled = false;

  /// Title of the Book
  String _title = '';

  /// Author of the corresponding Book
  String? _author;

  /// An image of the book
  Image? _image;

  /// The number of pages this
  /// book has
  int _pages = 0;

  /// The Page the user is currently on
  int? _currentPage;

  /// Notes you have to that book.
  String _notes = '';

  /// The price of the book
  double? _price;

  /// Setter for the Title of the Book
  set title(String title) => _title = title;

  /// Setter for the Author of the Book
  set author(String author) => _author = author;

  /// Setter for the Image of the Book
  set image(Image image) => _image = image;

  /// Setter for the Pages this Book has
  set pages(int pages) => _pages = pages;

  /// Setter for The Page the user is currently on
  set currentPage(int page) => _currentPage = page;

  /// Setter for the Notes you have to that Book
  set notes(String notes) => _notes = notes;

  /// Setter for the Price of the Book
  set price(double price) => _price = price;

  /// The Variable that determines whether the
  /// Done Button is enabled or not.
  bool get doneButtonEnabled => _doneButtonEnabled;

  /// Creates a Book and adds it to
  /// [BookList.books]
  /// Returnes true, if the book
  /// does not alredy exist, and was added.
  /// Returns false, if the book couln't been added.
  bool createBook() {
    final duplicateBooks =
        BookList.books.where((element) => element.title == _title);
    if (duplicateBooks.isEmpty) {
      BookList.addBook(
        Book(
          title: _title,
          author: _author,
          pages: _pages,
          currentPage: _currentPage,
          image: _image,
          notes: _notes,
          price: _price,
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  /// Checks if all needed vars are filled in.
  void checkForVars() {
    if (_title.isNotEmpty && _pages > 0) {
      _doneButtonEnabled = true;
    } else {
      _doneButtonEnabled = false;
    }
  }

  @override
  void dispose() {}
}
