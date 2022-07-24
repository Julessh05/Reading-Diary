library logic;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/material.dart'
    show BuildContext, Key, RouteSettings, StatelessWidget, Widget;
import 'package:reading_diary/blocs/blocs.dart' hide EventBloc;
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/search_results.dart';
import 'package:reading_diary/models/wish.dart' show Wish;
import 'package:reading_diary/screens/desktop/search_results_screen_desktop.dart';
import 'package:reading_diary/screens/mobile/search_results_screen_mobile.dart';
import 'package:reading_diary/screens/screens.dart';

/// Widget that returns the corresponding Screen
/// to the Platform you're running the App on.
class WidgetRouter extends StatelessWidget {
  /// Standard Widget Router.
  /// You have to pass a Route Name manually here.
  WidgetRouter({required String routeName, Key? key}) : super(key: key) {
    _routeName = routeName;
  }

  /// Widget Router for the Homescreen
  WidgetRouter.homescreen({Key? key}) : super(key: key) {
    _routeName = Routes.homescreen;
  }

  /// Widget Router to push the Screen with which you can
  /// add a new Diary Entry
  WidgetRouter.addEntryScreen({
    required RouteSettings settings,
    Key? key,
  }) : super(key: key) {
    _routeName = Routes.addEntryScreen;
    _settings = settings;
  }

  /// Widget Router for the screen
  /// with which you can add a new Book
  WidgetRouter.addBookScreen({
    required RouteSettings settings,
    Key? key,
  }) : super(key: key) {
    _routeName = Routes.addBookScreen;
    _settings = settings;
  }

  /// Widget Router for the Screen with which you can
  /// add a Wish to your Book Wishlist
  WidgetRouter.addWishScreen({
    required RouteSettings settings,
    Key? key,
  }) : super(key: key) {
    _routeName = Routes.addWishScreen;
    _settings = settings;
  }

  /// Shows the Unknown Screen
  WidgetRouter.unknownScreen({Key? key}) : super(key: key) {
    _routeName = Routes.unknownscreen;
  }

  /// Widget Router for the Settings Screen
  WidgetRouter.settingsScreen({Key? key}) : super(key: key) {
    _routeName = Routes.settingsScreen;
  }

  /// The Widget Router for the Screen
  /// that shows a single Entry.
  /// Through the [settings] the
  /// Entry is passed
  WidgetRouter.entryDetailsScreen({
    required RouteSettings settings,
    Key? key,
  }) : super(key: key) {
    _routeName = Routes.entryDetailsScreen;
    _settings = settings;
  }

  /// The Widget Router for the Screen
  /// that shows a single Book.
  /// Through the [settings] the
  /// Book is passed
  WidgetRouter.bookDetailsScreen({
    required RouteSettings settings,
    Key? key,
  }) : super(key: key) {
    _routeName = Routes.bookDetailsScreen;
    _settings = settings;
  }

  /// The Widget Router for the Screen
  /// that shows a single Wish.
  /// Through the [settings] the
  /// Wish is passed
  WidgetRouter.wishDetailsScreen({
    required RouteSettings settings,
    Key? key,
  }) : super(key: key) {
    _routeName = Routes.wishDetailsScreen;
    _settings = settings;
  }

  /// The Widget Router for the Screen that
  /// represents the Search Results
  WidgetRouter.searchResultsScreen({required RouteSettings settings, Key? key})
      : super(key: key) {
    _routeName = Routes.searchResultsScreen;
    _settings = settings;
  }

  /// The Route Settings
  /// with which arguments are passed
  /// to different Screens.
  late final RouteSettings? _settings;

  /// Whether the App is running on a
  /// Desktop OS (true) or not (false) (mostly mobile)
  static late final bool isDesktop;

  /// Route Name the Widget Router works with
  late final String _routeName;

  @override
  Widget build(BuildContext context) {
    switch (_routeName) {

      // Case for the Homescreen
      case Routes.homescreen:
        return BlocParent(
          bloc: HomescreenBloc(),
          child:
              isDesktop ? const HomescreenDesktop() : const HomescreenMobile(),
        );

      // Case for Add Entry Screen
      case Routes.addEntryScreen:
        return BlocParent(
          bloc: AddEntryBloc(),
          child: isDesktop
              ? const AddEntryScreenDesktop()
              : AddEntryScreenMobile(
                  addOrEdit: _settings!.arguments as AddOrEdit,
                ),
        );

      // Case for the Add Book Screen
      case Routes.addBookScreen:
        return BlocParent(
          bloc: AddBookBloc(),
          child: isDesktop
              ? const AddBookScreenDesktop()
              : AddBookScreenMobile(
                  addOrEdit: _settings!.arguments as AddOrEdit,
                ),
        );

      // Case for the Add Wish Screen
      case Routes.addWishScreen:
        return BlocParent(
          bloc: AddWishBloc(),
          child: isDesktop
              ? const AddWishScreenDesktop()
              : AddWishScreenMobile(
                  addOrEdit: _settings!.arguments as AddOrEdit,
                ),
        );

      // Case for the Settings Screen
      case Routes.settingsScreen:
        return BlocParent(
          bloc: SettingsBloc(),
          child: isDesktop
              ? const SettingsScreenDesktop()
              : const SettingsScreenMobile(),
        );

      // Entry Details Screen
      case Routes.entryDetailsScreen:
        return BlocParent(
          bloc: EntryDetailsBloc(),
          child: isDesktop
              ? const EntryDetailsScreenDesktop()
              : EntryDetailsScreenMobile(
                  entry: _settings!.arguments as DiaryEntry,
                ),
        );

      // Book Details Screen
      case Routes.bookDetailsScreen:
        return BlocParent(
          bloc: BookDetailsBloc(),
          child: isDesktop
              ? const BookDetailsScreenDesktop()
              : BookDetailsScreenMobile(
                  book: _settings!.arguments as Book,
                ),
        );

      // Wish Details Screen
      case Routes.wishDetailsScreen:
        return BlocParent(
          bloc: WishDetailsBloc(),
          child: isDesktop
              ? const WishDetailsScreenDesktop()
              : WishDetailsScreenMobile(
                  wish: _settings!.arguments as Wish,
                ),
        );

      case Routes.searchResultsScreen:
        return isDesktop
            ? const SearchResultsScreenDesktop()
            : SerachResultsScreenMobile(
                results: _settings!.arguments as SearchResults,
              );

      // Case for the Unknown Screen.
      // Never used directly
      case Routes.unknownscreen:
        return const UnknwonScreen();

      // Something wrong is specified,
      // return the Unknown Screen
      default:
        return const UnknwonScreen();
    }
  }
}
