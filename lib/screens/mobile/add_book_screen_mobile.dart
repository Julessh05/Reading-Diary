library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
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
      child: ListView(
        children: <AddModelContainer>[
          AddModelContainer(
            name: 'Title'.tr(),
            done: (str) => _bloc!.title = str,
            autofocus: true,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
