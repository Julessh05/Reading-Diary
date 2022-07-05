library storage;

import 'package:hive/hive.dart' show Box, Hive;
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart';

/// Contains all Operations done
/// in I/O.
class Storage {
  /// Box that stores all Books
  static Box<Book>? _bookBox;

  /// The Key for the [_bookBox]
  static const String _bookBoxKEY = 'Book Box';

  /// Box for all the Entries stores in the
  /// Diary
  static Box<DiaryEntry>? _entryBox;

  /// Key for the [_entryBox]
  static const String _entryBoxKEY = 'Entry Box';

  /// Initialized the Storage.
  /// Loads all Data.
  /// Make sure to call this Method before doing anything
  /// else
  static Future<void> init() async {
    Hive.registerAdapter(BookAdapter());
    Hive.registerAdapter(DiaryEntryAdapter());
    _entryBox = await Hive.openBox<DiaryEntry>(_entryBoxKEY);
    _bookBox = await Hive.openBox<Book>(_bookBoxKEY);
    _loadEntries();
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

  static void _loadEntries() {
    for (DiaryEntry entry in _entryBox!.values) {
      Diary.addEntry(entry);
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

  /// Stores all the Entries into
  /// the local Storage.
  static void storeEntries() {
    _entryBox!.deleteAll(_entryBox!.keys);
    for (int i = 0; i < Diary.entries.length; i++) {
      final String key = 'Diary Entry $i';
      _entryBox!.put(key, Diary.entries[i]);
    }
  }
}
