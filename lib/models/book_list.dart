library models;

import 'dart:collection' show UnmodifiableListView;

import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/storage/storage.dart';

class BookList {
  static final List<Book> _books = [];

  /// List of all Books the User stored.
  static List<Book> get books => UnmodifiableListView(_books);

  /// Adds a specified [book]
  static void addBook(Book book) {
    _books.add(book);
    Storage.storeBooks();
  }

  /// Deletes the specified [book]
  /// from the List of Books
  static void deleteBook(Book book) {
    _books.remove(book);
    Storage.storeBooks();
  }
}
