library mobile_screens;

import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:reading_diary/blocs/add_entry_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container.dart';
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/book_list.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// The Mobile Version of the Screen with which you can
/// add a new Entry to your Diary.
class AddEntryScreenMobile extends StatefulWidget {
  const AddEntryScreenMobile({Key? key}) : super(key: key);

  @override
  State<AddEntryScreenMobile> createState() => _AddEntryScreenMobileState();
}

class _AddEntryScreenMobileState extends State<AddEntryScreenMobile> {
  /// Corresponding Bloc for this Widget.
  /// Should only be set once.
  AddEntryBloc? _bloc;

  /// The Range of Pages read on that day.
  RangeValues? _pagesRead;

  /// The page you started reading
  double? _startPage = 0;

  /// The Page you stopped reading
  double? _endPage;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  /// Appbar for the Mobile Add Entry Screen
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text('Add new Entry'.tr()),
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
            AddModelContainer(
              name: 'Title'.tr(),
              autofocus: true,
              maxLines: 1,
              done: (title) => _bloc!.entryTitle = title,
            ),
            AddModelContainer(
              name: 'Content'.tr(),
              done: (ct) {
                setState(() {
                  _bloc!.entryContent = ct;
                  _bloc!.checkForVars();
                });
              },
            ),
            AddModelContainer(
              name: 'Date'.tr(),
              child: _dateContainer,
            ),

            // TODO: add possibility to add an Image
            AddModelContainer(
              name: 'Book'.tr(),
              child: DropdownButton<Book>(
                items: _bookDropDownItems,
                alignment: Alignment.center,
                autofocus: false,
                enableFeedback: true,
                value: _bloc!.entryBook ?? const Book.none(),
                onChanged: (book) {
                  if (book == null) {
                    _bloc!.entryBook = null;
                  } else if (book == const Book.addBook()) {
                    _bloc!
                        .openAddBookScreen(context)
                        .then((value) => setState(() {}));
                  } else if (book == const Book.none()) {
                    _bloc!.entryBook = null;
                  } else {
                    _bloc!.entryBook = BookList.books
                        .where((element) => element == book)
                        .first;
                  }
                },
              ),
            ),
            AddModelContainer(
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

  /// The enabled done Button
  ElevatedButton get _enabledButton {
    return ElevatedButton(
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      onPressed: () {
        if (_pagesRead == null && _startPage != null && _endPage != null) {
          _pagesRead = RangeValues(_startPage!, _endPage!);
          _bloc!.entryPages = _pagesRead!;
        }
        _bloc!.createEntry();
        Navigator.pop(context);
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

  /// All the Options for the Dropdown Menu
  List<DropdownMenuItem<Book>> get _bookDropDownItems {
    final List<DropdownMenuItem<Book>> list = [];

    list.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: const Book.none(),
        onTap: () {
          setState(() {
            _bloc!.entryBook = null;
          });
        },
        child: Text('None'.tr()),
      ),
    );

    for (Book book in BookList.books) {
      list.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          enabled: true,
          value: book,
          onTap: () {
            setState(() {
              _bloc!.entryBook = book;
              _pagesRead = RangeValues(0, book.pages.toDouble());
            });
          },
          child: Text(book.title),
        ),
      );
    }
    list.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: const Book.addBook(),
        child: Text(
          'Add Book'.tr(),
        ),
      ),
    );

    return list;
  }

  /// Returns the Widget with which you
  /// can make an input, of how many pages you read.
  Widget get _pagesReadChild {
    if (_bloc!.entryBook == null) {
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
              _startPage = double.parse(str);
            },
            onChanged: (str) {
              _startPage = double.parse(str);
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
              _endPage = double.parse(str);
            },
            onChanged: (str) {
              _endPage = double.parse(str);
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
            max: _bloc!.entryBook!.pages.toDouble(),
            divisions: _bloc!.entryBook!.pages,
            onChanged: (RangeValues value) {
              setState(() {
                _pagesRead = value;
                _bloc!.entryPages = _pagesRead!;
              });
            },
            inactiveColor: Colors.blue.shade100,
            activeColor: Colors.blue.shade800,
            semanticFormatterCallback: (double newValue) {
              return '$newValue books read';
            },
            labels: RangeLabels(_pagesRead!.start.toInt().toString(),
                _pagesRead!.end.toInt().toString()),
            values: RangeValues(_pagesRead!.start, _pagesRead!.end),
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
      firstDate: DateTime(2005),
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
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.blue.shade800,
              onPrimary: Colors.white,
              secondary: Colors.white,
              onSecondary: Colors.black,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.blue.shade900,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {});
  }
}
