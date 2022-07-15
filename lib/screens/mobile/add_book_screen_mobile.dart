library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/add_book_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container_mobile.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// Mobile Version of the Screen you can add
/// books with
class AddBookScreenMobile extends StatefulWidget {
  const AddBookScreenMobile({
    required this.addOrEdit,
    Key? key,
  }) : super(key: key);

  final AddOrEdit addOrEdit;

  @override
  State<AddBookScreenMobile> createState() => _AddBookScreenMobileState();
}

class _AddBookScreenMobileState extends State<AddBookScreenMobile> {
  /// Corresponding Bloc for this Screen
  AddBookBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

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
              autofocus: true,
              maxLines: 1,
            ),
            AddModelContainerMobile(
              name: 'Author'.tr(),
              done: (str) => _bloc!.author = str,
              maxLines: 1,
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
              keyboardType: TextInputType.number,
            ),
            AddModelContainerMobile(
              name: 'Notes'.tr(),
              done: (str) => _bloc!.notes = str,
              maxLines: 1000,
            ),
            AddModelContainerMobile(
              name: 'Price'.tr(),
              done: (str) {
                _bloc!.price = double.parse(str);
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              suffixIcon: const Icon(Icons.euro_rounded),
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
        final success = _bloc!.createBook();
        if (!success) {
          _showErrorDialog();
        }
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
