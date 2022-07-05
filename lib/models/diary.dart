library models;

import 'dart:collection' show UnmodifiableListView;

import 'package:reading_diary/models/diary_entry.dart';

/// Represents the Diary
class Diary {
  /// A List of all Entries
  /// stored in this Diary
  static List<DiaryEntry> _entries = [
    DiaryEntry(
      entry: '',
    ),
    DiaryEntry(entry: ''),
    DiaryEntry(entry: ''),
    DiaryEntry(entry: ''),
    DiaryEntry(entry: ''),
    DiaryEntry(entry: ''),
  ];

  /// Returns an umodifiable View
  /// of the List containing all Entries.
  static List<DiaryEntry> get entries => UnmodifiableListView(_entries);

  /// Adds the specified [entry] to the
  /// list of all Entries
  static void addEntry(DiaryEntry entry) {
    _entries.add(entry);
  }

  /// Removes the specified [entry] from the
  /// list of all Entries
  static void deleteEntry(DiaryEntry entry) {
    _entries.remove(entry);
  }
}
