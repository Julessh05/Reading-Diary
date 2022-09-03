library mobile_components;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/event_bloc.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/events/reload_event.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:string_translate/string_translate.dart' show Translate;

/// A Container to display a single Diary Entry
/// on mobile Devices.
class ModelContainerMobile extends StatefulWidget {
  const ModelContainerMobile({
    this.entry,
    this.book,
    this.wish,
    Key? key,
  })  : assert(
          (entry != null && book == null && wish == null) ||
              (entry == null && book != null && wish == null) ||
              (entry == null && book == null && wish != null),
          'You can only pass either an entry or a book or a wish',
        ),
        super(key: key);

  /// The Entry this Container correpsonds to
  final DiaryEntry? entry;

  /// The Book this Container represents
  final Book? book;

  /// The Wish this Container represents
  final Wish? wish;

  @override
  State<StatefulWidget> createState() => _EntryContainerMobile();
}

class _EntryContainerMobile extends State<ModelContainerMobile> {
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
          child: DecoratedBox(
            decoration: const BoxDecoration(),
            position: DecorationPosition.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisSize: MainAxisSize.max,
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      bottom: 15,
                    ),
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 25,
                      bottom: 15,
                    ),
                    child: _icon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Returns the Icon that should
  /// be shown on the right side of this Container
  Icon get _icon {
    if (widget.book != null) {
      return const Icon(Icons.book_rounded);
    } else if (widget.entry != null) {
      return const Icon(Icons.menu_book_rounded);
    } else {
      return const Icon(Icons.bookmark_rounded);
    }
  }

  /// Children of the Body of
  /// this Screen.
  List<Widget> get _children {
    if (widget.entry != null) {
      return <Widget>[
        Text(
          '${widget.entry!.date.day}.${widget.entry!.date.month}.${widget.entry!.date.year}',
          style: _dStyle,
        ),
        Text(widget.entry!.title, style: _tStyle),
      ];
    } else if (widget.book != null) {
      return <Widget>[
        Text(
          '${'Current Page:'.tr()} ${widget.book!.currentPage}',
          style: _dStyle,
        ),
        Text(widget.book!.title, style: _tStyle),
      ];
    } else {
      return <Widget>[
        Text(
          widget.wish!.title,
          style: _tStyle,
        ),
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
  /// a Book, a Wish or an Entry is specified.
  void _openScreen(BuildContext context) {
    final String routeName;
    final dynamic args;
    if (widget.entry != null) {
      routeName = Routes.entryDetailsScreen;
      args = widget.entry!;
    } else if (widget.book != null) {
      routeName = Routes.bookDetailsScreen;
      args = widget.book!;
    } else {
      routeName = Routes.wishDetailsScreen;
      args = widget.wish!;
    }
    Navigator.pushNamed(context, routeName, arguments: args).then(
      (value) => EventBloc.stream.sink.add(const ReloadEvent()),
    );
  }
}
