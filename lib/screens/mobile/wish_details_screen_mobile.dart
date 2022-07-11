library mobile_screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/components/mobile/entry_details_container_mobile.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:string_translate/string_translate.dart' show Translate;

/// Represents a single Wish of the User
/// and shows you all information.
class WishDetailsScreenMobile extends StatefulWidget {
  const WishDetailsScreenMobile({
    required this.wish,
    Key? key,
  }) : super(key: key);

  /// The Wish this Screen
  /// represents.
  final Wish wish;

  @override
  State<WishDetailsScreenMobile> createState() =>
      _WishDetailsScreenMobileState();
}

class _WishDetailsScreenMobileState extends State<WishDetailsScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
      extendBody: true,
    );
  }

  /// The AppBar for this Screen.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(widget.wish.title),
    );
  }

  /// Body of this Screen.
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
          widget.wish.book != null
              ? EntryDetailsContainerMobile(
                  name: 'Book'.tr(),
                  data: widget.wish.book!.title,
                )
              : Container(),
          widget.wish.book != null
              ? Container()
              : EntryDetailsContainerMobile(
                  name: 'Description'.tr(),
                  data: widget.wish.description!,
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
}
