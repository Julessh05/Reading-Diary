library mobile_screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/event_bloc.dart';
import 'package:reading_diary/components/mobile/model_container_mobile.dart';
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
  List<ModelContainerMobile> get _children {
    final List<ModelContainerMobile> list = [];

    for (Object o in widget.results.results) {
      switch (o.runtimeType) {
        case Wish:
          o as Wish;
          list.add(
            ModelContainerMobile(wish: o),
          );
          break;

        case Book:
          o as Book;
          list.add(
            ModelContainerMobile(book: o),
          );
          break;

        case DiaryEntry:
          o as DiaryEntry;
          list.add(
            ModelContainerMobile(entry: o),
          );
          break;

        default:
          continue;
      }
    }

    return list;
  }
}
