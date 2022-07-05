library mobile_screens;

import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:reading_diary/blocs/add_entry_bloc.dart';
import 'package:reading_diary/components/mobile/add_entry_container.dart';
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
      child: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          AddEntryContainer(
            name: 'Title'.tr(),
            autofocus: true,
            maxLines: 1,
            done: (title) => _bloc!.entryTitle = title,
          ),
          AddEntryContainer(
            name: 'Content'.tr(),
            done: (ct) {
              setState(() {
                _bloc!.entryContent = ct;
                _bloc!.checkForVars();
              });
            },
          ),
          AddEntryContainer(
            name: 'Date'.tr(),
            child: ElevatedButton(
              onPressed: _dateDialog,
              autofocus: false,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Pick a Date'.tr()),
            ),
          ),

          // TODO: add possibility to add an Image

          AddEntryContainer(
            name: 'Book'.tr(),
            child: DropdownButton<String>(
              items: _bookDropDownItems,
              alignment: Alignment.center,
              autofocus: false,
              enableFeedback: true,
              value: _bloc!.book == null ? 'None' : _bloc!.book!.name,
              onChanged: (bookName) {
                if (bookName == null) {
                  _bloc!.entryBook = null;
                } else if (bookName == 'None') {
                  _bloc!.entryBook = null;
                } else {
                  _bloc!.entryBook = BookList.books
                      .where((element) => element.name == bookName)
                      .first;
                }
              },
            ),
          ),
          AddEntryContainer(
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
          const SizedBox(height: 20)
        ],
      ),
    );
  }

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
      },
      child: Text(
        'Done'.tr(),
      ),
    );
  }

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
  List<DropdownMenuItem<String>> get _bookDropDownItems {
    final List<DropdownMenuItem<String>> list = [];

    list.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: 'None'.tr(),
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
          value: book.name,
          onTap: () {
            setState(() {
              _bloc!.entryBook = book;
              _pagesRead = RangeValues(0, book.pages.toDouble());
            });
          },
          child: Text(book.name),
        ),
      );
    }
    list.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: null,
        onTap: () {
          // TODO: implement onTap
        },
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
    if (_bloc!.book == null) {
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
            max: _bloc!.book!.pages.toDouble(),
            divisions: _bloc!.book!.pages,
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
        builder: (_, child) {
          return Theme(
            data: ThemeData(
              primaryColor: Colors.blue.shade800,
            ),
            child: child!,
          );
        });
  }
}
