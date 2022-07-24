library models;

import 'package:flutter/material.dart' show hashValues, Image;
import 'package:hive/hive.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;

part 'book.g.dart';

/// Represents a single Book
@HiveType(typeId: 0)
class Book {
  Book({
    required this.title,
    this.author,
    this.image,
    required this.pages,
    required this.currentPage,
    this.notes = '',
    this.price,
  }) : assert(!pages.isNegative && pages != 0);

  /// Called if you don't want to have a book
  const Book.none({
    this.title = '<none>',
    this.pages = 1,
    this.author,
    this.currentPage = 1,
    this.image,
    this.notes = '',
    this.price,
  });

  /// Called if you want the
  /// Add Book Button to work
  const Book.addBook({
    this.title = '<new_book>',
    this.pages = 1,
    this.author,
    this.currentPage = 1,
    this.image,
    this.notes = '',
    this.price,
  });

  /// The Title of the Book.
  /// This is not a unique field,
  /// because there are multiple books
  /// with the same Title.
  /// So you can have all these Books
  /// in your App.
  @HiveField(0)
  final String title;

  /// The Author of the Book.
  /// Can be null and does not have to be set.
  @HiveField(1)
  final String? author;

  /// Some kind of Image.
  /// This sould be the Book Cover,
  /// at least it makes the most sense.
  /// But it can be anything else.
  @HiveField(2)
  final Image? image;

  /// The Number of Pages
  /// the Book has.
  /// Must be set.
  /// Can't be negative and has to be more than 0.
  @HiveField(3)
  final int pages;

  /// A Field to store the page the user
  /// is currently on.
  /// Is always "updated".
  /// THis is done trough creating
  /// a new Book and making a "deep clone"
  /// with only this value changed.
  @HiveField(4)
  final int currentPage;

  /// The Notes and additional Information
  /// the User wants to store next
  /// to the Book.
  @HiveField(5)
  final String notes;

  /// The Price of the Book.
  @HiveField(6)
  final double? price;

  @override
  bool operator ==(Object other) {
    if (other is Book) {
      return other.title == title &&
          other.author == author &&
          other.image == image &&
          other.pages == pages &&
          other.currentPage == currentPage &&
          other.notes == notes &&
          other.price == price;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => hashValues(
        title,
        author,
        image,
        pages,
        currentPage,
        notes,
        price,
      );

  @override
  String toString() {
    return "title: $title, pages: $pages, current Ppge; $currentPage";
  }
}
