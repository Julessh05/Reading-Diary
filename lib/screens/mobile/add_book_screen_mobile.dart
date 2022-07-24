library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/add_book_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// Mobile Version of the Screen you can add
/// books with
class AddBookScreenMobile extends StatefulWidget {
  const AddBookScreenMobile({
    required this.addOrEdit,
    Key? key,
  }) : super(key: key);

  /// The Object that determines,
  /// how this Screen is used,
  final AddOrEdit addOrEdit;

  @override
  State<AddBookScreenMobile> createState() => _AddBookScreenMobileState();
}

class _AddBookScreenMobileState extends State<AddBookScreenMobile> {
  /// Corresponding Bloc for this Screen
  AddBookBloc? _bloc;

  /// The Book that is passed,
  /// if this Screen is used to edit
  /// a Book
  Book? _book;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    if (widget.addOrEdit.edit && !widget.addOrEdit.initialValueSet) {
      _book = widget.addOrEdit.object as Book;
      _bloc!.title = _book!.title;
      if (_book!.author != null) {
        _bloc!.author = _book!.author!;
      }
      _bloc!.currentPage = _book!.currentPage;
      if (_book!.image != null) {
        _bloc!.image = _book!.image!;
      }
      _bloc!.notes = _book!.notes;
      _bloc!.pages = _book!.pages;
      if (_book!.price != null) {
        _bloc!.price = _book!.price!;
      }
      widget.addOrEdit.initialValueSet = true;
    }

    return Scaffold(
      appBar: _appBar,
      body: _body,
      extendBody: true,
      extendBodyBehindAppBar: false,
    );
  }

  /// AppBar for this Screen
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text('Add Book'.tr()),
    );
  }

  /// Body for this Screen.
  Widget get _body {
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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            AddModelContainerMobile(
              name: 'Title'.tr(),
              done: (str) {
                setState(() {
                  _bloc!.title = str;
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.title,
              autofocus: true,
              maxLines: 1,
            ),
            AddModelContainerMobile(
              name: 'Author'.tr(),
              done: (str) {
                setState(() {
                  _bloc!.author = str;
                  _bloc!.checkForVars();
                });
              },
              maxLines: 1,
              initialValue: _bloc!.author,
            ),

            // TODO: add option to add am Image

            AddModelContainerMobile(
              name: 'Pages'.tr(),
              done: (str) {
                setState(() {
                  _bloc!.pages = int.parse(str);
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.pages.toString(),
              keyboardType: TextInputType.number,
            ),
            AddModelContainerMobile(
              name: 'Current Page'.tr(),
              done: (str) {
                setState(() {
                  _bloc!.currentPage = int.parse(str);
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.currentPage.toString(),
              keyboardType: TextInputType.number,
            ),
            AddModelContainerMobile(
              name: 'Notes'.tr(),
              done: (str) {
                setState(() {
                  _bloc!.notes = str;
                  _bloc!.checkForVars();
                });
              },
              maxLines: 1000,
              initialValue: _bloc!.notes,
            ),
            AddModelContainerMobile(
              name: 'Price'.tr(),
              done: (str) {
                setState(() {
                  _bloc!.price = double.parse(str);
                  _bloc!.checkForVars();
                });
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              suffixIcon: const Icon(Icons.euro_rounded),
              initialValue:
                  _bloc!.price != null ? _bloc!.price!.toString() : null,
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
          final Book newBook = _bloc!.replaceBook(_book!);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            Routes.bookDetailsScreen,
            arguments: newBook,
          );
        } else {
          final success = _bloc!.createBook();
          if (!success) {
            _showErrorDialog();
          }
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

  /// Displays an Error Dialog
  /// if there was an Error creating
  /// the Book
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.end,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actionsOverflowDirection: VerticalDirection.down,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          scrollable: true,
          title: Text('Error creating Book'.tr()),
          content: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            dragStartBehavior: DragStartBehavior.down,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            reverse: false,
            scrollDirection: Axis.vertical,
            child: ListBody(
              mainAxis: Axis.vertical,
              reverse: false,
              children: [
                Text('Exactly this Book does already exists.'.tr()),
                Text('Please use that Book or add another one'.tr()),
              ],
            ),
          ),
          actions: <TextButton>[
            TextButton(
              autofocus: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Ok'.tr(),
              ),
            ),
          ],
        );
      },
    );
  }
}
