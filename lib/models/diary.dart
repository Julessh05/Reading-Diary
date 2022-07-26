library models;

import 'dart:collection' show UnmodifiableListView;

import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/storage/storage.dart';

/// Represents the Diary
class Diary {
  /// A List of all Entries
  /// stored in this Diary
  static final List<DiaryEntry> _entries = [];

  /// Returns an umodifiable View
  /// of the List containing all Entries.
  static UnmodifiableListView<DiaryEntry> get entries =>
      UnmodifiableListView(_entries);

  /// Adds the specified [entry] to the
  /// list of all Entries
  static void addEntry(DiaryEntry entry) {
    _entries.add(entry);
    final Book book = BookList.books.firstWhere(
      (element) =>
          (element.title == entry.book.title) &&
          (element.author == entry.book.author),
    );
    final newBook = Book(
      title: book.title,
      pages: book.pages,
      author: book.author,
      image: book.image,
      notes: book.notes,
      price: book.price,
      currentPage: entry.endPage,
      url: book.url,
    );
    BookList.replaceBook(book, newBook);
    Storage.storeEntries();
  }

  /// Method called in the [Storage] class to
  /// "load" the entries.
  static void addEntryStorage(DiaryEntry entry) {
    _entries.add(entry);
  }

  /// Removes the specified [entry] from the
  /// list of all Entries
  static void deleteEntry(DiaryEntry entry) {
    _entries.remove(entry);
    Storage.storeEntries();
  }

  /// Replaces the [toReplace] with the corresponding [replace]
  static void replaceEntry(DiaryEntry toReplace, DiaryEntry replace) {
    final int i = _entries.indexOf(toReplace);
    _entries[i] = replace;
  }
}
