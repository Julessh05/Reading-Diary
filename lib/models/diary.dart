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
  static List<DiaryEntry> get entries => UnmodifiableListView(_entries);

  /// Adds the specified [entry] to the
  /// list of all Entries
  static void addEntry(DiaryEntry entry) {
    _entries.add(entry);
    final Book book =
        BookList.books.where((element) => element == entry.book).first;
    final newBook = Book(
      title: book.title,
      pages: book.pages,
      author: book.author,
      image: book.image,
      notes: book.notes,
      price: book.price,
      currentPage: entry.endPage,
    );
    BookList.replaceBook(book, newBook);
    Storage.storeEntries();
  }

  /// Removes the specified [entry] from the
  /// list of all Entries
  static void deleteEntry(DiaryEntry entry) {
    _entries.remove(entry);
    Storage.storeEntries();
  }
}
