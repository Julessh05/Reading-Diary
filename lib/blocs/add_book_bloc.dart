library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart';

/// Bloc for the Add Book Screens
class AddBookBloc extends Bloc {
  /// Title of the Book
  String _title = '';

  /// Author of the corresponding Book
  String? _author;

  /// An image of the book
  Image? _image;

  /// The number of pages this
  /// book has
  int _pages = 0;

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

  /// Setter for the Notes you have to that Book
  set notes(String notes) => _notes = notes;

  /// Setter for the Price of the Book
  set price(double price) => _price = price;

  @override
  void dispose() {}
}
