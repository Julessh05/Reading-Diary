library storage;

import 'package:hive/hive.dart' show Box, Hive;
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart';
import 'package:reading_diary/models/wish.dart';
import 'package:reading_diary/models/wishlist.dart';

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

  /// A Box in which all the Book whises
  /// of the User is stored.
  static Box<Wish>? _wishBox;

  /// Key for the [_wishBox]
  static const String _wishBoxKEY = 'Wish Box';

  /// Initialized the Storage.
  /// Loads all Data.
  /// Make sure to call this Method before doing anything
  /// else
  static Future<void> init() async {
    Hive.registerAdapter(BookAdapter());
    Hive.registerAdapter(DiaryEntryAdapter());
    Hive.registerAdapter(WishAdapter());
    _entryBox = await Hive.openBox<DiaryEntry>(_entryBoxKEY);
    _bookBox = await Hive.openBox<Book>(_bookBoxKEY);
    _wishBox = await Hive.openBox<Wish>(_wishBoxKEY);
    _loadEntries();
    _loadBooks();
    _loadWishes();
  }

  /// Loads all the Books
  /// from the Storage and adds it to
  /// the List of Books.
  static void _loadBooks() {
    for (Book book in _bookBox!.values) {
      BookList.addBook(book);
    }
  }

  /// Loads all Diary Entries
  /// from the Storage
  /// into the Diary
  static void _loadEntries() {
    for (DiaryEntry entry in _entryBox!.values) {
      Diary.addEntry(entry);
    }
  }

  /// loads all Wishes from the Storage
  /// into the Wishlist
  static void _loadWishes() {
    for (Wish wish in _wishBox!.values) {
      Wishlist.addWish(wish);
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

  /// Stores all the Wishes
  /// to the local Storage
  static void storeWishes() {
    _wishBox!.deleteAll(_wishBox!.keys);
    for (int i = 0; i < Wishlist.wishes.length; i++) {
      final String key = 'Wish $i';
      _wishBox!.put(key, Wishlist.wishes[i]);
    }
  }
}
