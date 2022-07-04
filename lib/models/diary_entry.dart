library models;

import 'package:flutter/material.dart' show Image, RangeValues;
import 'package:hive/hive.dart';

part 'diary_entry.g.dart';

/// Represents a single Entry in
/// the Diary
@HiveType(typeId: 1)
class DiaryEntry {
  DiaryEntry({
    this.title,
    required this.entry,
    this.image,
    this.date,
    this.values,
  }) {
    date ??= DateTime.now();
    title ??= 'Entry ${date!.day}.${date!.month}.${date!.year}';
  }

  @HiveField(0)
  late final String? title;

  @HiveField(1)
  final String entry;

  @HiveField(3)
  final Image? image;

  @HiveField(4)
  late final DateTime? date;

  @HiveField(5)
  final RangeValues? values;
}
