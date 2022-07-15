library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart' show Image;
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;

/// Bloc for the Add Entry Screens.
class AddEntryBloc extends Bloc {
  /// Title of the Entry
  String? entryTitle;

  /// Content of the Entry Created
  String entryContent = '';

  /// Date and Time of the Entry created
  DateTime? entryDate;

  /// Corresponding Image to the Entry created
  Image? _entryImage;

  int? entryStartPage;

  int? entryEndPage;

  /// The book this Entry corresponds to.
  Book entryBook = const Book.none();

  // Whether the Done Button is enabled or not.
  bool _doneButtonEnabled = false;

  /// Setter for the Entry Image
  set entryImage(Image image) => _entryImage = image;

  /// Setter for the Entry Pages Read

  /// Getter for the Variable that determines whether the done
  /// Button is enabled or not.
  bool get doneButtonEnabled => _doneButtonEnabled;

  /// Created a new Entry and adds it to the
  /// [Diary.entries] list
  void createEntry() {
    Diary.addEntry(
      DiaryEntry(
        title: entryTitle,
        content: entryContent,
        date: entryDate,
        image: _entryImage,
        book: entryBook,
        startPage: entryStartPage!,
        endPage: entryEndPage!,
      ),
    );
  }

  /// Checks if all the nessecary Variables
  /// are set before coninuting.
  void checkForVars() {
    if (entryContent.isNotEmpty &&
        entryBook != const Book.none() &&
        entryStartPage != null &&
        entryEndPage != null) {
      _doneButtonEnabled = true;
    } else {
      _doneButtonEnabled = false;
    }
  }

  @override
  void dispose() {}
}
