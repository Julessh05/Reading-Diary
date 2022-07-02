library storage;

import 'package:hive/hive.dart' show Box, Hive;
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/book_list.dart';

/// Contains all Operations done
/// in I/O.
class Storage {
  /// Box that stores all Books
  static Box<Book>? _bookBox;

  /// The Key for the [_bookBox]
  static const String _bookBoxKEY = 'Book Box';

  /// Initialized the Storage.
  /// Loads all Data.
  /// Make sure to call this Method before doing anything
  /// else
  static Future<void> init() async {
    Hive.registerAdapter(BookAdapter());
    _bookBox = await Hive.openBox<Book>(_bookBoxKEY);
    _loadBooks();
  }

  /// Loads all the Books
  /// from the Storage and adds it to
  /// the List of Books.
  static void _loadBooks() {
    for (Book book in _bookBox!.values) {
      BookList.addBook(book);
    }
  }

  /// Stores all the Books
  /// into the Storage.
  static void storeBooks() {
    _bookBox!.deleteAll(_bookBox!.keys);
    for (int i = 0; i < BookList.books.length; i++) {
      final String key = 'Book $i';
      _bookBox!.put(key, BookList.books[i]);
    }
  }
}
