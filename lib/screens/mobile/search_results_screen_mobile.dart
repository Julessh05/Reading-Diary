library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/blocs.dart' show HomescreenBloc;
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/search_results.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:reading_diary/states/homescreen_state.dart';

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
  /// The Homescreen Bloc used
  /// to reload the Homescreen.
  HomescreenBloc? _homeBloc;

  @override
  Widget build(BuildContext context) {
    _homeBloc ??= BlocParent.of(context);

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
      child: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: _children,
      ),
    );
  }

  /// The Children of the List View.
  List<ListTile> get _children {
    final List<ListTile> list = [];

    for (Object o in widget.results.results) {
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
              onTap: onTap,
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
              title: Text(o.title),
              subtitle: Text(o.currentPage.toString()),
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
              subtitle: Text(o.book.title),
              onTap: onTap,
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
      (value) => _homeBloc!.stateStream.add(HomescreenState()),
    );
  }
}
