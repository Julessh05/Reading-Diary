library models;

import 'package:flutter/material.dart' show Image;
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
    required this.content,
    this.image,
    DateTime? date,
    required this.book,
    required this.startPage,
    required this.endPage,
  }) {
    this.date = date ?? DateTime.now();
    this.title = title ?? 'Entry ${this.date.weekdayAsString}';
  }

  /// The Title of the Entry.
  @HiveField(0)
  late final String title;

  /// The Content of this Object.
  /// This is the important part
  /// and must be included.
  @HiveField(1)
  final String content;

  /// You can add an Image to
  /// the Entry. This could be
  /// a Photo of the Pages you read,
  /// an Image in the Book
  /// (if the Book has Images) or anything
  /// else you want.
  @HiveField(3)
  final Image? image;

  /// The Date for this Entry.
  /// I mean it is a Diary,
  /// so you should have an Entry for
  /// every day - or at least on a
  /// regulary basis.
  @HiveField(4)
  late final DateTime date;

  /// The Page th eUser started
  /// reaeding on
  @HiveField(5)
  final int startPage;

  /// The Page the User stopped
  /// to read on that day.
  /// Is the current Page
  /// of the Book after storing the
  /// Entry.
  @HiveField(6)
  final int endPage;

  /// The Book this Entry corresponds to.
  @HiveField(7)
  final Book book;
}
