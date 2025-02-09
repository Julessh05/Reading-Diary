import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/wish.dart' show Wish;

/// This Object is used to determine whether
/// a Add Screen is used to Add an Object
/// [AddOrEdit.add] or to edit an Object.
/// This is differenciated in the different
/// Object (for and [DiaryEntry] use the [AddOrEdit.entry] etc...)
class AddOrEdit {
  /// Used to add an Object
  AddOrEdit.add() {
    _edit = false;
    object = null;
  }

  /// Used to edit an Entry.
  /// the [entry] is the Object to
  /// be modified / edited.
  AddOrEdit.entry({
    required DiaryEntry entry,
  }) {
    _edit = true;
    object = entry;
  }

  /// Used to edit an Book.
  /// the [book] is the Object to
  /// be modified / edited.
  AddOrEdit.book({
    required Book book,
  }) {
    _edit = true;
    object = book;
  }

  /// Used to edit an Wish.
  /// the [wish] is the Object to
  /// be modified / edited.
  AddOrEdit.wish({
    required Wish wish,
  }) {
    _edit = true;
    object = wish;
  }

  /// The Variable that
  /// determines if you should edit (true)
  /// or add (false) an Object.
  late final bool _edit;

  /// getter for the Varaible that
  /// determines if you should add or
  /// edit an Object
  /// true => edit
  /// false => add
  bool get edit => _edit;

  /// Whether the initial Values where
  /// set yet
  /// false => not set
  /// true => set
  bool initialValueSet = false;

  /// The Object passed if
  /// an Object should be edited.
  late final dynamic object;
}
