library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:flutter/material.dart'
    show BuildContext, Image, Navigator, RangeValues;
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;

/// Bloc for the Add Entry Screens.
class AddEntryBloc extends Bloc {
  /// Title of the Entry
  String? _entryTitle;

  /// Content of the Entry Created
  String _entryContent = '';

  /// Date and Time of the Entry created
  DateTime? entryDate;

  /// Corresponding Image to the Entry created
  Image? _entryImage;

  /// The Pages you read.
  /// Corresponding to the created Entry
  RangeValues? _entryPages;

  /// The book this Entry corresponds to.
  Book? entryBook;

  // Whether the Done Button is enabled or not.
  bool _doneButtonEnabled = false;

  /// Setter for the Entry Title
  set entryTitle(String title) => _entryTitle = title;

  /// Setter for the Entry Content
  set entryContent(String content) => _entryContent = content;

  /// Setter for the Entry Image
  set entryImage(Image image) => _entryImage = image;

  /// Setter for the Entry Pages Read
  set entryPages(RangeValues pages) => _entryPages = pages;

  /// Getter for the Variable that determines whether the done
  /// Button is enabled or not.
  bool get doneButtonEnabled => _doneButtonEnabled;

  /// Created a new Entry and adds it to the
  /// [Diary.entries] list
  void createEntry() {
    Diary.addEntry(
      DiaryEntry(
        title: _entryTitle,
        content: _entryContent,
        date: entryDate,
        image: _entryImage,
        pagesRead: _entryPages,
      ),
    );
  }

  /// Checks if all the nessecary Variables
  /// are set before coninuting.
  void checkForVars() {
    if (_entryContent.isNotEmpty) {
      _doneButtonEnabled = true;
    } else {
      _doneButtonEnabled = false;
    }
  }

  /// Pushes a screen with which you can add
  /// a new Book to the App.
  Future<void> openAddBookScreen(BuildContext context) async {
    Navigator.pushNamed(context, Routes.addBookScreen);
  }

  @override
  void dispose() {}
}
