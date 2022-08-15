library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;

/// The Bloc for the Entry Details Screen
class EntryDetailsBloc extends Bloc {
  /// Deletes the specified [entry], which
  /// is the Entry that the corresponding Screen
  /// represents.
  /// This [entry] is beeing removed from the
  /// Diary.
  void deleteEntry(DiaryEntry entry) {
    Diary.deleteEntry(entry);
  }

  /// Returns the Progress of the Book as a Percentual
  /// Value.
  double calculateProcentualProgress(Book book) {
    final double onePercent = book.pages / 100;
    final double percent = book.currentPage / onePercent;
    final double output = percent * 0.01;
    return output;
  }

  @override
  void dispose() {}
}
