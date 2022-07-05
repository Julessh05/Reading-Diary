library models;

import 'package:flutter/material.dart' show Image, RangeValues;
import 'package:hive/hive.dart';

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
    this.values,
  }) {
    this.date = date ?? DateTime.now();
    this.title =
        title ?? 'Entry ${this.date.day}.${this.date.month}.${this.date.year}';
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
  final RangeValues? values;
}
