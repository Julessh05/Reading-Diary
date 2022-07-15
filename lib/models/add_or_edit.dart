library models;

import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/wish.dart' show Wish;

class AddOrEdit {
  AddOrEdit.add() {
    _edit = false;
    object = null;
  }

  AddOrEdit.entry({
    required DiaryEntry entry,
  }) {
    _edit = true;
    object = entry;
  }

  AddOrEdit.book({
    required Book book,
  }) {
    _edit = true;
    object = book;
  }

  AddOrEdit.wish({
    required Wish wish,
  }) {
    _edit = true;
    object = wish;
  }

  late final bool _edit;

  late final dynamic object;
}
