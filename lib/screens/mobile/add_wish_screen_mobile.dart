library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/add_wish_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:string_translate/string_translate.dart' show Translate;

/// Screen on which the User can add a new Wish to his
/// Wishlsit.
class AddWishScreenMobile extends StatefulWidget {
  const AddWishScreenMobile({
    required this.addOrEdit,
    Key? key,
  }) : super(key: key);

  /// The Object that determines
  /// how this screen should be used.
  final AddOrEdit addOrEdit;

  @override
  State<AddWishScreenMobile> createState() => _AddWishScreenMobileState();
}

class _AddWishScreenMobileState extends State<AddWishScreenMobile> {
  /// Bloc that holds all Action for this Screen.
  AddWishBloc? _bloc;

  /// The Wish that should be edited.
  Wish? _wish;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    if (widget.addOrEdit.edit && !widget.addOrEdit.initialValueSet) {
      _wish = widget.addOrEdit.object as Wish;
      _bloc!.title = _wish!.title;
      if (_wish!.description != null) {
        _bloc!.description = _wish!.description!;
      }
      _bloc!.wishBook = _wish!.book;
      widget.addOrEdit.initialValueSet = true;
    }

    return Scaffold(
      appBar: _appBar,
      body: _body,
      extendBody: true,
      extendBodyBehindAppBar: false,
    );
  }

  /// AppBar for this Screen.
  AppBar get _appBar {
    final String title;
    if (widget.addOrEdit.edit) {
      title = 'Edit Wish'.tr();
    } else {
      title = 'Add a Wish'.tr();
    }
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(title),
    );
  }

  /// Body for this Screen.
  Scrollbar get _body {
    return Scrollbar(
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            AddModelContainerMobile(
              name: 'Book'.tr(),
              child: DropdownButton<Book>(
                items: _bookDropDownItems,
                alignment: Alignment.center,
                autofocus: false,
                enableFeedback: true,
                value: _bloc!.wishBook ?? const Book.none(),
                onChanged: (book) {
                  if (book == null) {
                    _bloc!.wishBook = null;
                  } else if (book == const Book.addBook()) {
                    _openAddBookScreen(context);
                  } else if (book == const Book.none()) {
                    _bloc!.wishBook = null;
                  } else {
                    _bloc!.wishBook = BookList.books
                        .where((element) => element == book)
                        .first;
                  }
                  _bloc!.checkForVars();
                },
              ),
            ),
            _bloc!.wishBook == null
                ? AddModelContainerMobile(
                    name: 'Title'.tr(),
                    maxLines: 1,
                    done: (str) {
                      setState(() {
                        _bloc!.title = str;
                        _bloc!.checkForVars();
                      });
                    },
                    initialValue: _bloc!.title,
                  )
                : const SizedBox(height: 0, width: 0),
            AddModelContainerMobile(
              name: 'Description',
              maxLines: 1000,
              done: (str) {
                _bloc!.description = str;
                setState(() {
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.description,
            ),
            FittedBox(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                    _bloc!.doneButtonEnabled ? _enabledButton : _disabledButton,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// The enabled done Button
  ElevatedButton get _enabledButton {
    return ElevatedButton(
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      onPressed: () {
        if (widget.addOrEdit.edit) {
          final newWish = _bloc!.replaceWish(_wish!);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            Routes.wishDetailsScreen,
            arguments: newWish,
          );
        } else {
          _bloc!.createWish();
          Navigator.pop(context);
        }
      },
      child: Text(
        'Done'.tr(),
      ),
    );
  }

  /// The Disabled done Button
  ElevatedButton get _disabledButton {
    return ElevatedButton(
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: null,
      child: Text(
        'Done'.tr(),
      ),
    );
  }

  /// All the Options for the Dropdown Menu
  List<DropdownMenuItem<Book>> get _bookDropDownItems {
    final List<DropdownMenuItem<Book>> list = [];

    list.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: const Book.none(),
        onTap: () {
          setState(() {
            _bloc!.wishBook = null;
          });
        },
        child: Text('None'.tr()),
      ),
    );

    for (Book book in BookList.books) {
      list.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          enabled: true,
          value: book,
          onTap: () {
            setState(() {
              _bloc!.wishBook = book;
            });
          },
          child: Text(book.title),
        ),
      );
    }
    list.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: const Book.addBook(),
        child: Text(
          'Add Book'.tr(),
        ),
      ),
    );

    return list;
  }

  /// Opens the Screen
  /// on which you can add a new Book.
  void _openAddBookScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.addBookScreen,
      arguments: AddOrEdit.add(),
    ).then(
      (value) => setState(() {}),
    );
  }
}
