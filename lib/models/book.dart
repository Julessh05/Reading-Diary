library models;

import 'package:flutter/material.dart' show Image;
import 'package:hive/hive.dart';

part 'book.g.dart';

/// Represents a single Book
@HiveType(typeId: 0)
class Book {
  const Book({
    required this.name,
    this.author,
    this.image,
    required this.pages,
    required this.currentPage,
    this.notes = '',
    this.price,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? author;

  @HiveField(2)
  final Image? image;

  @HiveField(3)
  final int pages;

  @HiveField(4)
  final int currentPage;

  @HiveField(5)
  final String notes;

  @HiveField(6)
  final double? price;
}
