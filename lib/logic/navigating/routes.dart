/// Contains all Route Names
/// used in this App.
class Routes {
  /// Route name of the Homescreen
  static const String homescreen = '/';

  /// Route Name of the Unknown Screen.
  /// This is never called directly, because the unknown screen
  /// is never shown on purpose.
  /// Only used in Production.
  static const String unknownscreen = '/unknown';

  /// Route Name of the
  /// Screen with which you can add
  /// a new Entry to your Diary.
  static const String addEntryScreen = '/add_entry';

  /// The Route Name of the Screen used
  /// to add a new Book
  static const String addBookScreen = '/add_book';

  /// Route Name for the screen with which you can
  /// add a Wish to your Wishlist.
  static const String addWishScreen = '/add_wish';

  /// Route Name for the
  /// Settings Screen.
  static const String settingsScreen = '/settings';

  /// The Screen that sowns a single Entry.
  static const String entryDetailsScreen = '/entry';

  /// The Screen that sowns a single Book.
  static const String bookDetailsScreen = '/book';

  /// The Screen that sowns a single Wish.
  static const String wishDetailsScreen = '/wish';

  /// The Route Name of the Screen
  /// that represents the Search Results
  static const String searchResultsScreen = '/search_results';

  /// The Route Name for the Screen
  /// that displays an Image in full-screen
  /// format.
  static const String imageScreen = '/image';

  /// All the Urls that are supported in
  /// the Post Section for Books.
  /// The Scheme of the App is:
  /// Service Name : URL
  static const Map<String, String> supportedURLs = {
    'Instagram': 'https://www.instagram.com',
    'Twitter': 'https://twitter.com',
    'Facebook': 'https://www.facebook.com',
    'Pinterest': 'https://www.pinterest.com',
    'Reddit': 'https://www.reddit.com',
    'GommeHD': 'https://www.gommehd.net',
    'Discord': 'https://discord.com',
    'Discord Server': 'https://discord.gg'
  };
}
