library mobile_screens;

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
