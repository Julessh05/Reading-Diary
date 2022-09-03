library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/book_list.dart';

/// The Bloc for the Screen
/// that represents a single Book
class BookDetailsBloc extends Bloc {
  /// Deletes a Book
  /// from the Book List
  void deleteBook(Book book) {
    BookList.deleteBook(book);
  }

  /// Returns the Progress of the Book as a Percentual
  /// Value.
  String calculateProcentualProgress(Book book) {
    final double onePercent = book.pages / 100;
    final double percent = book.currentPage / onePercent;
    final String percentString = percent.toStringAsFixed(2);
    return percentString.replaceAll(RegExp('\\.?0+\$'), '');
  }

  @override
  void dispose() {}
}
