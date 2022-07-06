library models;

import 'package:flutter/material.dart' show Image;
import 'package:hive/hive.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;

part 'book.g.dart';

/// Represents a single Book
@HiveType(typeId: 0)
class Book {
  const Book({
    required this.title,
    this.author,
    this.image,
    required this.pages,
    this.currentPage,
    this.notes = '',
    this.price,
  });

  /// Called if you don't want to have a book
  const Book.none({
    this.title = '<none>',
    this.pages = 1,
    this.author,
    this.currentPage,
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
    this.currentPage,
    this.image,
    this.notes = '',
    this.price,
  });

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? author;

  @HiveField(2)
  final Image? image;

  @HiveField(3)
  final int pages;

  @HiveField(4)
  final int? currentPage;

  @HiveField(5)
  final String notes;

  @HiveField(6)
  final double? price;
}
