library mobile_screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reading_diary/components/mobile/entry_container_mobile.dart';
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
  @override
  Widget build(BuildContext context) {
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
      actions: <IconButton>[],
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
}
