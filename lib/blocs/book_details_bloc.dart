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

  @override
  void dispose() {}
}
