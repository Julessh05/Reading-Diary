library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/add_book_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container.dart';
import 'package:string_translate/string_translate.dart' show Translate;

class AddBookScreenMobile extends StatefulWidget {
  const AddBookScreenMobile({Key? key}) : super(key: key);

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
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            AddModelContainer(
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
            AddModelContainer(
              name: 'Author'.tr(),
              done: (str) => _bloc!.author = str,
              maxLines: 1,
            ),

            // TODO: add option to add am Image

            AddModelContainer(
              name: 'Pages'.tr(),
              done: (str) {
                setState(() {
                  _bloc!.pages = int.parse(str);
                  _bloc!.checkForVars();
                });
              },
              keyboardType: TextInputType.number,
            ),
            AddModelContainer(
              name: 'Current Page'.tr(),
              done: (str) => _bloc!.currentPage = int.parse(str),
              keyboardType: TextInputType.number,
            ),
            AddModelContainer(
              name: 'Notes'.tr(),
              done: (str) => _bloc!.notes = str,
              maxLines: 1000,
            ),
            AddModelContainer(
              name: 'Price'.tr(),
              done: (str) {
                _bloc!.price = double.parse(str);
                _bloc!.createBook();
                Navigator.pop(context);
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
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
        _bloc!.createBook();
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
}
