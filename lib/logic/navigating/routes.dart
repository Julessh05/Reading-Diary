library logic;

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
}
