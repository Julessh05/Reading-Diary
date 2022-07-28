library storage;

import 'package:flutter/material.dart' show Locale, ThemeMode;
import 'package:hive/hive.dart' show Box, Hive;
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart';
import 'package:reading_diary/models/setting.dart';
import 'package:reading_diary/models/wish.dart';
import 'package:reading_diary/models/wishlist.dart';
import 'package:string_translate/string_translate.dart';

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

  /// Box that stores all Settings
  /// used in the App.
  static Box<Setting>? _settingsBox;

  /// The Key for the [_settingsBox]
  static const String _settingsBoxKEY = 'Settings Box';

  /// Initialized the Storage.
  /// Loads all Data.
  /// Make sure to call this Method before doing anything
  /// else
  static Future<void> init() async {
    Hive.registerAdapter(BookAdapter());
    Hive.registerAdapter(DiaryEntryAdapter());
    Hive.registerAdapter(WishAdapter());
    Hive.registerAdapter(SettingAdapter());
    _entryBox = await Hive.openBox<DiaryEntry>(_entryBoxKEY);
    _bookBox = await Hive.openBox<Book>(_bookBoxKEY);
    _wishBox = await Hive.openBox<Wish>(_wishBoxKEY);
    _settingsBox = await Hive.openBox<Setting>(_settingsBoxKEY);
    _loadEntries();
    _loadBooks();
    _loadWishes();
    _loadSettings();
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
      Diary.addEntryStorage(entry);
    }
  }

  /// Loads all the Settings from
  /// the Storage into the [allSettings]
  /// Set of Settings.
  static void _loadSettings() {
    if (_settingsBox!.isEmpty) {
      Setting.createSettings();
    } else {
      for (Setting setting in _settingsBox!.values) {
        dynamic objectValue;
        switch (setting.name) {
          case 'Language':
            final value = setting.stringValue;
            switch (value) {
              case 'en':
                objectValue = TranslationLocales.english;
                break;
              case 'de':
                objectValue = TranslationLocales.german;
                break;
              case 'fr':
                objectValue = TranslationLocales.french;
                break;
              case 'es':
                objectValue = TranslationLocales.spanish;
                break;
              case 'pt':
                objectValue = TranslationLocales.portuguese;
                break;
            }
            break;
          case 'Theme':
            final value = setting.stringValue;
            switch (value) {
              case 'system':
                objectValue = ThemeMode.system;
                break;
              case 'light':
                objectValue = ThemeMode.light;
                break;
              case 'dark':
                objectValue = ThemeMode.dark;
                break;
            }
            break;
        }
        setting.stringValue = null;
        setting.objectValue = objectValue;
        allSettings.add(setting);
      }
      Setting.setIcons();
      Setting.setValues();
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

  /// Stores all the Settings with the current
  /// Value to the File System.
  static void storeSettings() {
    _settingsBox!.deleteAll(_settingsBox!.keys);

    Setting.readValues();

    for (Setting setting in allSettings) {
      if (setting.objectValue != null) {
        if (setting.objectValue is Locale) {
          final value = setting.objectValue as Locale;
          setting.objectValue = null;
          setting.stringValue = value.languageCode;
        } else if (setting.objectValue is ThemeMode) {
          final value = setting.objectValue as ThemeMode;
          setting.objectValue = null;
          setting.stringValue = value.name;
        }
      }

      final String key = setting.name;
      _settingsBox!.put(key, setting);
    }
  }
}
