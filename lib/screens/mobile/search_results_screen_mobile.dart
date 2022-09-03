library mobile_screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/event_bloc.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/events/reload_event.dart';
import 'package:reading_diary/models/search_results.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:string_translate/string_translate.dart' show Translate;

/// Represents the Result of a Search.
class SerachResultsScreenMobile extends StatefulWidget {
  const SerachResultsScreenMobile({
    required this.results,
    Key? key,
  }) : super(key: key);

  /// The Search Results this Screen represents.
  final SearchResults results;

  @override
  State<SerachResultsScreenMobile> createState() =>
      _SerachResultsScreenMobileState();
}

class _SerachResultsScreenMobileState extends State<SerachResultsScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  /// The AppBar for this Screen.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(widget.results.search),
    );
  }

  /// The Body of this
  /// Search Screen.
  Scrollbar get _body {
    return Scrollbar(
      child: widget.results.results.isNotEmpty
          ? ListView(
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              addSemanticIndexes: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              dragStartBehavior: DragStartBehavior.down,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: _children,
            )
          : Center(child: Text('Nothing with this Keyword found'.tr())),
    );
  }

  /// The Children of the List View.
  List<ListTile> get _children {
    final List<ListTile> list = [];

    for (Object o in widget.results.results) {
      // ignore: prefer_function_declarations_over_variables
      final void Function() onTap = () => _openScreen(o.runtimeType, o);

      switch (o.runtimeType) {
        case Wish:
          o as Wish;
          list.add(
            ListTile(
              autofocus: false,
              enableFeedback: true,
              enabled: true,
              isThreeLine: false,
              selected: false,
              title: Text(o.title),
              subtitle: Text('Wish'.tr()),
              onTap: onTap,
              leading: const Icon(Icons.bookmark_rounded),
            ),
          );
          break;

        case Book:
          o as Book;
          list.add(
            ListTile(
              autofocus: false,
              enableFeedback: true,
              enabled: true,
              isThreeLine: false,
              selected: false,
              leading: const Icon(Icons.book_rounded),
              title: Text(o.title),
              subtitle: Text('Book'.tr()),
              onTap: onTap,
            ),
          );
          break;

        case DiaryEntry:
          o as DiaryEntry;
          list.add(
            ListTile(
              autofocus: false,
              enableFeedback: true,
              enabled: true,
              isThreeLine: false,
              selected: false,
              title: Text(o.title),
              subtitle: Text('Entry'.tr()),
              onTap: onTap,
              leading: const Icon(Icons.menu_book_rounded),
            ),
          );
          break;

        default:
          continue;
      }
    }

    return list;
  }

  /// Opens the corresponding
  /// Screen depending on whether
  /// a Book, a Wish or an Entry is specified.
  void _openScreen(Type type, dynamic args) {
    final String routeName;
    if (type == DiaryEntry) {
      routeName = Routes.entryDetailsScreen;
    } else if (type == Book) {
      routeName = Routes.bookDetailsScreen;
    } else {
      routeName = Routes.wishDetailsScreen;
    }
    Navigator.pushNamed(context, routeName, arguments: args).then(
      (value) => EventBloc.stream.add(const ReloadEvent()),
    );
  }
}
