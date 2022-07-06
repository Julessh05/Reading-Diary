library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/add_wish_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container.dart';
import 'package:reading_diary/models/book.dart';
import 'package:reading_diary/models/book_list.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// Screen on which the User can add a new Wish to his
/// Wishlsit.
class AddWishScreenMobile extends StatefulWidget {
  const AddWishScreenMobile({Key? key}) : super(key: key);

  @override
  State<AddWishScreenMobile> createState() => _AddWishScreenMobileState();
}

class _AddWishScreenMobileState extends State<AddWishScreenMobile> {
  /// Bloc that holds all Action for this Screen.
  AddWishBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  /// AppBar for this Screen.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text('Add a Wish'.tr()),
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
            AddModelContainer(
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
                    _bloc!
                        .openAddBookScreen(context)
                        .then((value) => setState(() {}));
                  } else if (book == const Book.none()) {
                    _bloc!.wishBook = null;
                  } else {
                    _bloc!.wishBook = BookList.books
                        .where((element) => element == book)
                        .first;
                  }
                },
              ),
            ),
            _bloc!.wishBook == null
                ? AddModelContainer(
                    name: 'Title'.tr(),
                    maxLines: 1,
                    done: (str) => _bloc!.title = str,
                  )
                : const SizedBox(height: 0, width: 0),
            AddModelContainer(
              name: 'Description',
              maxLines: 1000,
              done: (str) {
                _bloc!.desription = str;
                _bloc!.checkForVars();
              },
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
        _bloc!.createWish();
        Navigator.pop(context);
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
}
