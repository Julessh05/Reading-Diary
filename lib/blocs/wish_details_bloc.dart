library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:reading_diary/models/wishlist.dart';

/// Bloc for the Screen that represents
/// a single Wish.
class WishDetailsBloc extends Bloc {
  /// Deletes the specified [wish]
  /// from the Wishlist
  void deleteWish(Wish wish) {
    Wishlist.deleteWish(wish);
  }

  @override
  void dispose() {}
}
