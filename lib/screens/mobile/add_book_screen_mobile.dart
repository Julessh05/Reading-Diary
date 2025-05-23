import 'dart:io';

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reading_diary/blocs/add_book_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container_mobile.dart';
import 'package:reading_diary/components/mobile/model_details_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/image_screen_arguments.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:url_launcher/url_launcher.dart' show launchUrl;

/// Mobile Version of the Screen you can add
/// books with
class AddBookScreenMobile extends StatefulWidget {
  const AddBookScreenMobile({
    required this.addOrEdit,
    super.key,
  });

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
      if (_book!.coverPath != null) {
        _bloc!.coverPath = _book!.coverPath!;
      }
      _bloc!.notes = _book!.notes;
      _bloc!.pages = _book!.pages;
      if (_book!.price != null) {
        _bloc!.price = _book!.price!;
      }
      _bloc!.url = _book!.url;
      widget.addOrEdit.initialValueSet = true;
    }

    return Scaffold(
      appBar: _appBar,
      body: _Body(
        addOrEdit: widget.addOrEdit,
      ),
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
}

class _Body extends StatefulWidget {
  /// The Object that determines,
  /// how this Screen is used,
  final AddOrEdit addOrEdit;

  const _Body({required this.addOrEdit});

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  /// Corresponding Bloc for this Screen
  AddBookBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    return _body;
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
            AddModelContainerMobile(
              name: 'Cover'.tr(),
              big: _bloc!.coverPath != null,
              child: _coverContainer,
            ),
            AddModelContainerMobile(
              name: 'Pages'.tr(),
              done: (str) {
                if (str.isEmpty) {
                  _bloc!.pages = 0;
                } else {
                  _bloc!.pages = int.parse(str);
                }
                setState(() {
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.pages != 0 ? _bloc!.pages.toString() : null,
              keyboardType: TextInputType.number,
            ),
            AddModelContainerMobile(
              name: 'Current Page'.tr(),
              done: (str) {
                if (str.isEmpty) {
                  _bloc!.currentPage = 0;
                } else {
                  _bloc!.currentPage = int.parse(str);
                }
                setState(() {
                  _bloc!.checkForVars();
                });
              },
              initialValue: _bloc!.currentPage.toString(),
              selectOnTap: widget.addOrEdit.edit ? false : true,
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
              suffixIcon: const Icon(Icons.euro_rounded),
              initialValue: _bloc!.price?.toString(),
            ),
            AddModelContainerMobile(
              name: 'Post',
              initialValue: _bloc!.url,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.url,
              textCapitalization: TextCapitalization.none,
              done: (str) {
                setState(() {
                  _bloc!.checkForVars();
                });
                _bloc!.url = str;
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
        if (_bloc!.checkURL()) {
          if (widget.addOrEdit.edit) {
            final Book newBook = _bloc!.replaceBook(
              widget.addOrEdit.object as Book,
            );
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
        } else {
          _showUnsupportedURLDialog();
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
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade400),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
      onPressed: null,
      child: Text(
        'Done'.tr(),
      ),
    );
  }

  /// The Container that is
  /// used to display the Cover Picker
  /// or the picked Cover
  Column get _coverContainer {
    final bool isSet = _bloc!.coverPath != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      textBaseline: TextBaseline.alphabetic,
      textDirection: TextDirection.ltr,
      verticalDirection: VerticalDirection.down,
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          autofocus: false,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Text(
            isSet ? 'Change Cover'.tr() : 'Pick a Cover'.tr(),
          ),
        ),
        isSet ? const SizedBox(height: 15) : Container(),
        isSet
            ? ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.imageScreen,
                    arguments: ImageScreenArguments(
                      file: File(_bloc!.coverPath!),
                      title: 'Cover'.tr(),
                    ),
                  );
                },
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Text('Show current Cover'.tr()),
              )
            : Container(),
      ],
    );
  }

  /// Picks an Image from the Gallery
  /// or provides the oppotunity
  /// to take a new one.
  void _pickImage() {
    showBottomSheet(
      context: context,
      builder: (_) {
        ImagePicker picker = ImagePicker();
        return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.rectangle),
          height: MediaQuery.of(context).size.height / 5,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final XFile? file;
                  try {
                    file = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (file != null) {
                      // Save File to Documents Directory
                      final Directory dir =
                          await getApplicationDocumentsDirectory();
                      final String path = dir.path;
                      file.saveTo('$path/${file.name}');

                      setState(() {
                        _bloc!.coverPath = file!.path;
                        Navigator.pop(context);
                      });
                    } else {
                      return;
                    }
                  } on Exception catch (_) {
                    if (mounted) {
                      Navigator.pop(context);
                      _showPermissionDeniedDialog();
                    } else {
                      // TODO: implement error handling, when state in not mounted in a view
                    }
                  }
                },
                child: Text('Pick Cover from Gallery'.tr()),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final XFile? file = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (file != null) {
                      // Save File to Documents Directory
                      final Directory dir =
                          await getApplicationDocumentsDirectory();
                      final String path = dir.path;
                      file.saveTo(path);

                      setState(() {
                        _bloc!.coverPath = file.path;
                        Navigator.pop(context);
                      });
                    } else {
                      return;
                    }
                  } on Exception catch (_) {
                    if (mounted) {
                      Navigator.pop(context);
                      _showPermissionDeniedDialog();
                    } else {
                      // TODO: implement error handling when screen is not mounted in a hierarchy
                    }
                  }
                },
                child: Text('Take a new Picutre'.tr()),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          alignment: Alignment.center,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          icon: const Icon(Icons.block_outlined),
          title: Text('Permission not granted'.tr()),
          content: Text(
            'You denied the Permission to take pictures and use the gallery. \nPlease change that.'
                .tr(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              autofocus: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Cancel'.tr()),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              autofocus: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Ok'.tr()),
            ),
          ],
        );
      },
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

  /// Shows a Dialog, if the url
  void _showUnsupportedURLDialog() {
    showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text('URL Error'.tr()),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          scrollable: true,
          actions: <TextButton>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Ok'.tr()),
            ),
            TextButton(
              onPressed: () async {
                Uri u = Uri.parse(
                  'mailto:Jules.media@outlook.de?subject=URL%20Mistake',
                );
                await launchUrl(u);
              },
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Contact us'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return const _SupportedURLs();
                  }),
                );
              },
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Show supported URLs'.tr()),
            )
          ],
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
              children: <Text>[
                Text(
                    'For Safety Reasons, only a few specific URL\'s are allowed.'
                        .tr()),
                Text('Please check your URL.'.tr()),
                Text('If we made a mistake, contact us.'.tr()),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A Screen that shows all supported
/// urls for the Book Post Param
class _SupportedURLs extends StatelessWidget {
  const _SupportedURLs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  /// AppBar for the Screen
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text('Supported URLs'.tr()),
    );
  }

  /// The Body for this Screen .
  Scrollbar get _body {
    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.right,
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        scrollDirection: Axis.vertical,
        itemCount: Routes.supportedURLs.length,
        itemBuilder: (_, counter) {
          return ModelDetailsContainerMobile(
            name: Routes.supportedURLs.keys.elementAt(counter),
            data: Routes.supportedURLs.values.elementAt(counter),
            small: true,
          );
        },
      ),
    );
  }
}