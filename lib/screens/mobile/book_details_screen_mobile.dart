library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/blocs.dart' show BookDetailsBloc;
import 'package:reading_diary/models/book.dart' show Book;

/// Screen that represents a single Book in the App
/// and shows you all Information about this Book.
class BookDetailsScreenMobile extends StatefulWidget {
  const BookDetailsScreenMobile({
    required this.book,
    Key? key,
  }) : super(key: key);

  /// The Book this Screen
  /// represents
  final Book book;

  @override
  State<BookDetailsScreenMobile> createState() =>
      _BookDetailsScreenMobileState();
}

class _BookDetailsScreenMobileState extends State<BookDetailsScreenMobile> {
  /// The corresponding Bloc for this Screen.
  BookDetailsBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);

    return Scaffold(
      appBar: _appBar,
    );
  }

  /// The AppBar for that screen.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(widget.book.title),
      actions: <IconButton>[
        IconButton(
          onPressed: _editBTNPressed,
          icon: const Icon(Icons.edit_rounded),
          autofocus: false,
        ),
        IconButton(
          onPressed: _deleteBTNPressed,
          icon: const Icon(Icons.delete_rounded),
          autofocus: false,
        ),
      ],
    );
  }

  /// Called when the delete Button is pressed.
  void _deleteBTNPressed() {
    _bloc!.deleteBook(widget.book);
    Navigator.pop(context);
  }

  /// Called whe the Edit Button
  /// is Pressed
  void _editBTNPressed() {
    // TODO: implement Edit
  }
}
