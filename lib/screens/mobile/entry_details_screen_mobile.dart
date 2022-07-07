library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/entry_details_bloc.dart';
import 'package:reading_diary/components/mobile/entry_details_container_mobile.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;

/// The Mobile Version of the screen that showns
/// all the Information about a single [entry]
class EntryDetailsScreenMobile extends StatefulWidget {
  const EntryDetailsScreenMobile({
    required this.entry,
    Key? key,
  }) : super(key: key);

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
          onPressed: () {
            // TODO: implement edit.
          },
          icon: const Icon(Icons.edit_rounded),
          autofocus: false,
        ),
        IconButton(
          onPressed: _deleteBTNPressed,
          icon: const Icon(Icons.delete_rounded),
          autofocus: false,
        ),
      ],
    );
  }

  Scrollbar get _body {
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
          EntryDetailsContainerMobile(widget.entry.content),
        ],
      ),
    );
  }

  /// Called when the delete Button is pressed.
  void _deleteBTNPressed() {
    _bloc!.deleteEntry(widget.entry);
    Navigator.pop(context);
  }
}
