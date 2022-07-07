library mobile_components;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:string_translate/string_translate.dart' show Translate;

/// A Container to display a single Diary Entry
/// on mobile Devices.
class EntryContainerMobile extends StatelessWidget {
  const EntryContainerMobile({
    this.entry,
    this.book,
    Key? key,
  })  : assert(
          (entry != null && book == null) || (entry == null && book != null),
          'You can only pass either an entry or a book',
        ),
        super(key: key);

  /// The Entry this Container correpsonds to
  final DiaryEntry? entry;

  /// The Book this Container represents
  final Book? book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      dragStartBehavior: DragStartBehavior.down,
      onTap: () => _openScreen(context),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 4.5,
        child: Card(
          elevation: 8,
          borderOnForeground: false,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.transparent,
              style: BorderStyle.solid,
              width: 0.3,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                bottom: 15,
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(),
                position: DecorationPosition.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  textBaseline: TextBaseline.alphabetic,
                  textDirection: TextDirection.ltr,
                  verticalDirection: VerticalDirection.up,
                  children: _children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get _children {
    if (entry != null) {
      return <Widget>[
        Text(
          '${entry!.date.day}.${entry!.date.month}.${entry!.date.year}',
          style: _dStyle,
        ),
        Text(entry!.title, style: _tStyle),
      ];
    } else {
      return <Widget>[
        Text(
          '${'Current Page'.tr()} ${book!.currentPage}',
          style: _dStyle,
        ),
        Text(book!.title, style: _tStyle),
      ];
    }
  }

  /// Text Style for the Text
  TextStyle get _tStyle {
    return const TextStyle(
      fontSize: 25,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    );
  }

  /// Text Style for the Date
  TextStyle get _dStyle {
    return const TextStyle(
      fontSize: 15,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
    );
  }

  /// Opens the corresponding
  /// Screen depending on whether
  /// a Book or an Entry is specified.
  void _openScreen(BuildContext context) {
    if (entry != null) {
      Navigator.pushNamed(
        context,
        Routes.entryDetailsScreen,
        arguments: entry,
      );
    }
  }
}
