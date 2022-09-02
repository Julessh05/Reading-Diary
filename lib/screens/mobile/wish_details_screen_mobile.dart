library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/wish_details_bloc.dart';
import 'package:reading_diary/components/mobile/model_details_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/reading_diary_objects.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:string_translate/string_translate.dart' show Translate;

import '../../components/mobile/confirm_delete_dialog_mobile.dart';

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
  /// The Bloc used for this Screen.
  WishDetailsBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);

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
      actions: <IconButton>[
        IconButton(
          onPressed: _editBTNPressed,
          icon: const Icon(Icons.edit_rounded),
          autofocus: false,
          alignment: Alignment.center,
          enableFeedback: true,
          tooltip: 'Edit Wish'.tr(),
        ),
        IconButton(
          onPressed: _deleteBTNPressed,
          icon: const Icon(Icons.delete_rounded),
          autofocus: false,
          alignment: Alignment.center,
          enableFeedback: true,
          tooltip: 'Delete Wish'.tr(),
        ),
      ],
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
          widget.wish.book.title != '<none>'
              ? GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () => _openBookScreen(),
                  child: ModelDetailsContainerMobile(
                    name: 'Book'.tr(),
                    data: widget.wish.book.title,
                    small: true,
                  ),
                )
              : Container(),
          widget.wish.book == const Book.none()
              ? ModelDetailsContainerMobile(
                  name: 'Description'.tr(),
                  data: widget.wish.description!,
                )
              : Container(),
          FittedBox(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Return'.tr()),
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
    showDialog(
      context: context,
      builder: (_) {
        return confirmDeleteDialogMobile(
          title: widget.wish.title,
          what: ReadingDiaryObjects.wish,
          context: context,
          onConfirm: () {
            _bloc!.deleteWish(widget.wish);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  /// Called whe the Edit Button
  /// is Pressed
  void _editBTNPressed() {
    Navigator.pushNamed(
      context,
      Routes.addWishScreen,
      arguments: AddOrEdit.wish(wish: widget.wish),
    );
  }

  /// If a Book is specified and
  /// the User pressed the Tile that represents
  /// the Book, this will open the
  /// Book Details Screen.
  void _openBookScreen() {
    Navigator.pushNamed(
      context,
      Routes.bookDetailsScreen,
      arguments: widget.wish.book,
    );
  }
}
