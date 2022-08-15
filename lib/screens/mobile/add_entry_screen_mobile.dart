library mobile_screens;

import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:reading_diary/blocs/add_entry_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/diary_entry.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// The Mobile Version of the Screen with which you can
/// add a new Entry to your Diary.
class AddEntryScreenMobile extends StatefulWidget {
  const AddEntryScreenMobile({
    required this.addOrEdit,
    Key? key,
  }) : super(key: key);

  /// The Objec to determine whether this
  /// Screen is used to add or edit an Entry
  final AddOrEdit addOrEdit;

  @override
  State<AddEntryScreenMobile> createState() => _AddEntryScreenMobileState();
}

class _AddEntryScreenMobileState extends State<AddEntryScreenMobile> {
  /// Corresponding Bloc for this Widget.
  /// Should only be set once.
  AddEntryBloc? _bloc;

  /// The Entry that should be edited.
  DiaryEntry? _entry;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    if (widget.addOrEdit.edit && !widget.addOrEdit.initialValueSet) {
      _entry = widget.addOrEdit.object as DiaryEntry;
      _bloc!.entryBook = _entry!.book;
      _bloc!.entryDate = _entry!.date;
      _bloc!.entryContent = _entry!.content;
      if (_entry!.image != null) {
        _bloc!.entryImage = _entry!.image!;
      }
      _bloc!.entryTitle = _entry!.title;
      _bloc!.entryStartPage = _entry!.startPage;
      _bloc!.entryEndPage = _entry!.endPage;
      widget.addOrEdit.initialValueSet = true;
    }

    return Scaffold(
      appBar: _appBar,
      body: _body,
      extendBody: true,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
    );
  }

  /// Appbar for the Mobile Add Entry Screen
  AppBar get _appBar {
    final String title;
    if (widget.addOrEdit.edit) {
      title = 'Edit Entry'.tr();
    } else {
      title = 'Add new Entry'.tr();
    }
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(title),
    );
  }

  /// Body for the Mobile Add Entry Screen.
  Scrollbar get _body {
    return Scrollbar(
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            AddModelContainerMobile(
              name: 'Title'.tr(),
              autofocus: true,
              maxLines: 1,
              done: (title) {
                setState(() {
                  _bloc!.entryTitle = title;
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.entryTitle,
            ),
            AddModelContainerMobile(
              name: 'Content'.tr(),
              keyboardType: TextInputType.multiline,
              multiline: true,
              done: (ct) {
                setState(() {
                  _bloc!.entryContent = ct;
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.entryContent,
            ),
            AddModelContainerMobile(
              name: 'Date'.tr(),
              child: _dateContainer,
            ),

            // TODO: add possibility to add an Image

            AddModelContainerMobile(
              name: 'Book'.tr(),
              child: DropdownButton<Book>(
                items: _bookItems,
                alignment: Alignment.center,
                autofocus: false,
                enableFeedback: true,
                value: _bloc!.entryBook,
                onChanged: (book) {
                  if (book == const Book.addBook()) {
                    _openAddBookScreen();
                  } else {
                    setState(() {
                      _bloc!.checkForVars();
                    });
                  }
                },
              ),
            ),
            AddModelContainerMobile(
              name: 'Pages read'.tr(),
              big: true,
              child: _pagesReadChild,
            ),
            FittedBox(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                    _bloc!.doneButtonEnabled ? _enabledButton : _disabledButton,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// The Items for the Book Dropdown Menu.
  List<DropdownMenuItem<Book>> get _bookItems {
    final List<DropdownMenuItem<Book>> children = [];

    children.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: const Book.none(),
        onTap: () {
          _bloc!.entryBook = const Book.none();
        },
        child: Text('None'.tr()),
      ),
    );

    for (Book book in BookList.books) {
      children.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          enabled: true,
          value: book,
          onTap: () {
            _bloc!.entryBook = book;
            _bloc!.entryStartPage = book.currentPage;
            _bloc!.entryEndPage = book.pages;
          },
          child: Text(book.title),
        ),
      );
    }

    children.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: const Book.addBook(),
        onTap: () {
          _bloc!.entryBook = const Book.none();
        },
        child: Text('Add one'.tr()),
      ),
    );

    return children;
  }

  /// The enabled done Button
  ElevatedButton get _enabledButton {
    return ElevatedButton(
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      onPressed: () {
        if (widget.addOrEdit.edit) {
          final newEntry = _bloc!.replaceEntry(_entry!);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            Routes.entryDetailsScreen,
            arguments: newEntry,
          );
        } else {
          _bloc!.createEntry();
          Navigator.pop(context);
        }
      },
      child: Text(
        'Done'.tr(),
      ),
    );
  }

  /// The Disabled done Button
  ElevatedButton get _disabledButton {
    return ElevatedButton(
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: null,
      child: Text(
        'Done'.tr(),
      ),
    );
  }

  /// Returns the Widget with which you
  /// can make an input, of how many pages you read.
  Widget get _pagesReadChild {
    if (_bloc!.entryBook == const Book.none()) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        textBaseline: TextBaseline.alphabetic,
        textDirection: TextDirection.ltr,
        verticalDirection: VerticalDirection.down,
        children: [
          TextField(
            autocorrect: true,
            autofocus: false,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            dragStartBehavior: DragStartBehavior.down,
            enableIMEPersonalizedLearning: true,
            enableInteractiveSelection: true,
            enableSuggestions: true,
            enabled: true,
            expands: false,
            obscureText: false,
            keyboardAppearance: Theme.of(context).brightness,
            scrollPhysics: const BouncingScrollPhysics(),
            keyboardType: TextInputType.number,
            readOnly: false,
            smartDashesType: SmartDashesType.enabled,
            smartQuotesType: SmartQuotesType.enabled,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.words,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
            scribbleEnabled: true,
            selectionControls: MaterialTextSelectionControls(),
            textDirection: TextDirection.ltr,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            minLines: 1,
            selectionHeightStyle: BoxHeightStyle.tight,
            selectionWidthStyle: BoxWidthStyle.tight,
            showCursor: true,
            onSubmitted: (str) {
              _bloc!.entryStartPage = int.parse(str);
            },
            onChanged: (str) {
              _bloc!.entryStartPage = int.parse(str);
            },
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            decoration: InputDecoration(
              labelText: 'Start Page'.tr(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            autocorrect: true,
            autofocus: false,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            dragStartBehavior: DragStartBehavior.down,
            enableIMEPersonalizedLearning: true,
            enableInteractiveSelection: true,
            enableSuggestions: true,
            enabled: true,
            expands: false,
            obscureText: false,
            keyboardAppearance: Theme.of(context).brightness,
            scrollPhysics: const BouncingScrollPhysics(),
            keyboardType: TextInputType.number,
            readOnly: false,
            smartDashesType: SmartDashesType.enabled,
            smartQuotesType: SmartQuotesType.enabled,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.words,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
            scribbleEnabled: true,
            selectionControls: MaterialTextSelectionControls(),
            textDirection: TextDirection.ltr,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            minLines: 1,
            selectionHeightStyle: BoxHeightStyle.tight,
            selectionWidthStyle: BoxWidthStyle.tight,
            showCursor: true,
            onSubmitted: (str) {
              _bloc!.entryEndPage = int.parse(str);
            },
            onChanged: (str) {
              _bloc!.entryEndPage = int.parse(str);
            },
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            decoration: InputDecoration(
              labelText: 'End Page'.tr(),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        textBaseline: TextBaseline.alphabetic,
        textDirection: TextDirection.ltr,
        children: [
          const SizedBox(height: 25),
          RangeSlider(
            min: 0.0,
            max: _bloc!.entryBook.pages.toDouble(),
            divisions: _bloc!.entryBook.pages,
            onChanged: (RangeValues value) {
              setState(() {
                _bloc!.entryStartPage = value.start.toInt();
                _bloc!.entryEndPage = value.end.toInt();
              });
            },
            inactiveColor: Colors.blue.shade100,
            activeColor: Colors.blue.shade800,
            semanticFormatterCallback: (double newValue) {
              return '$newValue books read';
            },
            labels: RangeLabels(
              _bloc!.entryStartPage.toString(),
              _bloc!.entryEndPage.toString(),
            ),
            values: RangeValues(
              _bloc!.entryStartPage!.toDouble(),
              _bloc!.entryEndPage!.toDouble(),
            ),
          ),
        ],
      );
    }
  }

  /// The Container that either shows
  /// a Button to choose the Date or
  /// the chosen Date.
  Widget get _dateContainer {
    if (_bloc!.entryDate == null) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: _dateDialog,
            autofocus: false,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Text('Pick a Date'.tr()),
          ),
          const SizedBox(height: 5),
          Text(
            '${'Current Date:'.tr()} ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
          )
        ],
      );
    } else {
      return GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        behavior: HitTestBehavior.translucent,
        onTap: _dateDialog,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          children: [
            const SizedBox(height: 10),
            Text(
              '${_bloc!.entryDate!.day}.${_bloc!.entryDate!.month}.${_bloc!.entryDate!.year}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(height: 5),
            Text('Tap to change'.tr()),
          ],
        ),
      );
    }
  }

  /// Returns the Dialog to choose a Date
  /// for this Entry
  void _dateDialog() async {
    _bloc!.entryDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2005, 02, 22),
      lastDate: DateTime(2222, 02, 22),
      cancelText: 'Cancel'.tr(),
      confirmText: 'Confirm'.tr(),
      currentDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.datetime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme(
              brightness: Theme.of(context).colorScheme.brightness,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.secondary,
              secondary: Theme.of(context).colorScheme.secondary,
              onSecondary: Theme.of(context).colorScheme.onSecondary,
              error: Theme.of(context).colorScheme.error,
              onError: Theme.of(context).colorScheme.onError,
              background: Theme.of(context).colorScheme.background,
              onBackground: Theme.of(context).colorScheme.onBackground,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {});
  }

  /// Pushes a screen with which you can add
  /// a new Book to the App.
  void _openAddBookScreen() {
    Navigator.pushNamed(
      context,
      Routes.addBookScreen,
      arguments: AddOrEdit.add(),
    ).then(
      (value) => setState(() {}),
    );
  }
}
