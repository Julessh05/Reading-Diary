import 'package:reading_diary/models/book.dart' show Book;

/// Represents a single
/// Statistic in the Reading App
class Statistic {
  Statistic({
    required this.title,
    required this.data,
  }) {
    _book = null;
  }

  /// A Statistic that refers
  /// to a Book.
  Statistic.book({
    required this.title,
    required Book book,
    this.data = '',
  }) {
    _book = book;
  }

  /// The Title of the Statistic
  final String title;

  /// The Data of the Statistic.
  /// This is the Content / the
  /// actual Statistic.
  final String data;

  /// The Book this entry refers to
  late final Book? _book;

  /// Getter for the Book
  Book? get book => _book;
}
