import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;

/// The Bloc for the Entry Details Screen
class EntryDetailsBloc extends Bloc {
  /// Deletes the specified [entry], which
  /// is the Entry that the corresponding Screen
  /// represents.
  /// This [entry] is being removed from the
  /// Diary.
  void deleteEntry(DiaryEntry entry) {
    Diary.deleteEntry(entry);
  }

  @override
  void dispose() {}
}