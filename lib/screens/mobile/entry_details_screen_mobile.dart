library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/blocs.dart';
import 'package:reading_diary/blocs/entry_details_bloc.dart';
import 'package:reading_diary/components/mobile/model_details_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:string_translate/string_translate.dart' show Translate;

/// The Mobile Version of the screen that showns
/// all the Information about a single [entry]
class EntryDetailsScreenMobile extends StatefulWidget {
  const EntryDetailsScreenMobile({
    required this.entry,
    Key? key,
  }) : super(key: key);

  /// The Entry this
  /// Screen represents / shows
  final DiaryEntry entry;

  @override
  State<EntryDetailsScreenMobile> createState() =>
      _EntryDetailsScreenMobileState();
}

class _EntryDetailsScreenMobileState extends State<EntryDetailsScreenMobile> {
  /// The corresponding Bloc to this
  /// Screen with the Entry
  EntryDetailsBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    return Scaffold(
      appBar: _appBar,
      body: _body,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  /// The AppBar for that screen.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(widget.entry.title),
      actions: <IconButton>[
        IconButton(
          onPressed: _editBTNPressed,
          icon: const Icon(Icons.edit_rounded),
          autofocus: false,
          alignment: Alignment.center,
          enableFeedback: true,
          tooltip: 'Edit Entry'.tr(),
        ),
        IconButton(
          onPressed: _deleteBTNPressed,
          icon: const Icon(Icons.delete_rounded),
          autofocus: false,
        ),
      ],
    );
  }

  /// The Body of this Screen.
  Scrollbar get _body {
    final percentualPrgress = _bloc!.calculateProcentualProgress(
      widget.entry,
      widget.entry.book,
    );
    return Scrollbar(
      child: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: false,
        physics: const BouncingScrollPhysics(),
        children: [
          ModelDetailsContainerMobile(
            name: 'Content'.tr(),
            data: widget.entry.content,
            multiline: true,
          ),
          ModelDetailsContainerMobile(
            name: 'Date'.tr(),
            data:
                '${widget.entry.date.day}.${widget.entry.date.month}.${widget.entry.date.year}',
            small: true,
          ),
          GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            dragStartBehavior: DragStartBehavior.down,
            onTap: _openBookDetailsScreen,
            child: ModelDetailsContainerMobile(
              name: 'Book'.tr(),
              data: widget.entry.book.title,
              small: true,
            ),
          ),
          ModelDetailsContainerMobile(
            name: 'Pages read'.tr(),
            data: '${widget.entry.startPage} - ${widget.entry.endPage}',
            small: true,
          ),
          ModelDetailsContainerMobile(
            name: 'Progress'.tr(),
            small: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.red,
                  semanticsLabel: 'Progress'.tr(),
                  semanticsValue: 'Percentual Value: $percentualPrgress%',
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                  value: percentualPrgress * 0.01,
                ),
                const SizedBox(height: 10),
                Text('$percentualPrgress%')
              ],
            ),
          ),
          FittedBox(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'.tr()),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Called when the delete Button is pressed.
  void _deleteBTNPressed() {
    _bloc!.deleteEntry(widget.entry);
    Navigator.pop(context);
  }

  /// Called whe the Edit Button
  /// is Pressed
  void _editBTNPressed() {
    Navigator.pushNamed(
      context,
      Routes.addEntryScreen,
      arguments: AddOrEdit.entry(entry: widget.entry),
    );
  }

  /// Opens the Book Details Screen for
  /// the current Book.
  void _openBookDetailsScreen() {
    Navigator.pushNamed(
      context,
      Routes.bookDetailsScreen,
      arguments: widget.entry.book,
    );
  }
}
