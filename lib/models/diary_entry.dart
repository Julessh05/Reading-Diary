library models;

import 'package:flutter/material.dart' show Image, RangeValues;
import 'package:helpful_extensions/helpful_extensions.dart' show Weekday;
import 'package:hive/hive.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;
import 'package:reading_diary/models/book.dart' show Book;

part 'diary_entry.g.dart';

/// Represents a single Entry in
/// the Diary
@HiveType(typeId: 1)
class DiaryEntry {
  DiaryEntry({
    String? title,
    required this.entry,
    this.image,
    DateTime? date,
    this.book,
    this.pagesRead,
  }) {
    this.date = date ?? DateTime.now();
    this.title = title ?? 'Entry ${this.date.weekdayAsString}';
  }

  @HiveField(0)
  late final String? title;

  @HiveField(1)
  final String entry;

  @HiveField(3)
  final Image? image;

  @HiveField(4)
  late final DateTime date;

  @HiveField(5)
  final RangeValues? pagesRead;

  @HiveField(6)
  final Book? book;
}
