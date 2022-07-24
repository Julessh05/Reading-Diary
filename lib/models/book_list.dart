library models;

import 'dart:collection' show UnmodifiableListView;

import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:reading_diary/models/wishlist.dart';
import 'package:reading_diary/storage/storage.dart';

/// Represents the List of all Books.
class BookList {
  /// The Actual List of Books
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

  /// Replaces the specified Book [toReplace] with
  /// the corresponding specified [replace]
  static void replaceBook(Book toReplace, Book replace) {
    final int i = _books.indexOf(toReplace);
    _books[i] = replace;
    for (DiaryEntry entry in Diary.entries) {
      // Replace Entry
      if (entry.book == toReplace) {
        Diary.replaceEntry(
          entry,
          DiaryEntry(
            title: entry.title,
            date: entry.date,
            image: entry.image,
            content: entry.content,
            book: replace,
            startPage: entry.startPage,
            endPage: entry.endPage,
          ),
        );
      } else {
        continue;
      }
    }

    for (Wish wish in Wishlist.wishes) {
      // Replace Wish
      if (wish.book == toReplace) {
        Wishlist.replaceWish(
          wish,
          Wish(book: replace, description: wish.description),
        );
      } else {
        continue;
      }
    }
  }
}
