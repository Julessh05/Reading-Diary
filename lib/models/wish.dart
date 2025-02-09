import 'package:hive_ce/hive.dart'
    show BinaryReader, BinaryWriter, HiveField, HiveType, TypeAdapter;
import 'package:reading_diary/models/book.dart' show Book;

part 'wish.g.dart';

/// Represents a single Wish
@HiveType(typeId: 2)
class Wish {
  Wish({
    required this.book,
    this.description,
  }) {
    title = book.title;
  }

  /// Call this if the User enters
  /// a Wish and does not include a book in it.
  Wish.withoutBook({
    this.book = const Book.none(),
    required this.title,
    required this.description,
  });

  /// The Book the User wants
  @HiveField(0)
  final Book book;

  /// The Title of the Wish
  @HiveField(1)
  late String title;

  /// The Description of the Wish.
  @HiveField(2)
  final String? description;
}
