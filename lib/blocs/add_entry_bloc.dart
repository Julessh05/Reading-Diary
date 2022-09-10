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

  /// The Page the User started
  /// reading on
  int? entryStartPage;

  /// The Page the User stopped
  /// reading on
  int? entryEndPage;

  /// The book this Entry corresponds to.
  Book entryBook = const Book.none();

  // Whether the Done Button is enabled or not.
  bool _doneButtonEnabled = false;

  /// The Variable that holds the value
  /// determing whether the sliver or
  /// a textField is used to enter
  /// which pages the User read.
  bool _pagesReadSliderActive = true;

  /// The Variable that holds the value
  /// determing whether the sliver or
  /// a textField is used to enter
  /// which pages the User read.
  bool get pagesReadSliderActive => _pagesReadSliderActive;

  /// Setter for the Variable that holds the value
  /// determing whether the sliver or
  /// a textField is used to enter
  /// which pages the User read.
  set pagesReadSliderActive(bool pRSA) {
    if (entryBook != const Book.none()) {
      _pagesReadSliderActive = pRSA;
    } else {
      return;
    }
  }

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

  DiaryEntry replaceEntry(DiaryEntry toReplace) {
    final DiaryEntry newEntry = DiaryEntry(
      title: entryTitle,
      content: entryContent,
      date: entryDate,
      image: _entryImage,
      book: entryBook,
      startPage: entryStartPage!,
      endPage: entryEndPage!,
    );
    Diary.replaceEntry(toReplace, newEntry);
    return newEntry;
  }

  /// Checks if all the nessecary Variables
  /// are set before coninuting.
  void checkForVars() {
    if (entryContent.isNotEmpty &&
        entryBook != const Book.none() &&
        entryStartPage != null &&
        entryEndPage != null &&
        entryStartPage! > 0 &&
        entryEndPage! > 0 &&
        entryStartPage! < entryEndPage!) {
      _doneButtonEnabled = true;
    } else {
      _doneButtonEnabled = false;
    }
  }

  @override
  void dispose() {}
}
