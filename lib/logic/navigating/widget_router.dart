library logic;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/material.dart'
    show BuildContext, Key, StatelessWidget, Widget;
import 'package:reading_diary/blocs/add_book_bloc.dart';
import 'package:reading_diary/blocs/add_entry_bloc.dart';
import 'package:reading_diary/blocs/add_wish_bloc.dart';
import 'package:reading_diary/blocs/homescreen_bloc.dart';
import 'package:reading_diary/blocs/settings_bloc.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/screens/desktop/add_book_screen_desktop.dart';
import 'package:reading_diary/screens/desktop/add_entry_screen_desktop.dart';
import 'package:reading_diary/screens/desktop/add_wish_screen_desktop.dart';
import 'package:reading_diary/screens/desktop/homescreen_desktop.dart';
import 'package:reading_diary/screens/desktop/settings_screen_desktop.dart';
import 'package:reading_diary/screens/mobile/add_book_screen_mobile.dart';
import 'package:reading_diary/screens/mobile/add_entry_screen_mobile.dart';
import 'package:reading_diary/screens/mobile/add_wish_screen_mobile.dart';
import 'package:reading_diary/screens/mobile/homescreen_mobile.dart';
import 'package:reading_diary/screens/mobile/settings_screen_mobile.dart';
import 'package:reading_diary/screens/shared/unknown_screen.dart';

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
  WidgetRouter.addEntryScreen({Key? key}) : super(key: key) {
    _routeName = Routes.addEntryScreen;
  }

  /// Widget Router for the screen
  /// with which you can add a new Book
  WidgetRouter.addBookScreen({Key? key}) : super(key: key) {
    _routeName = Routes.addBookScreen;
  }

  /// Widget Router for the Screen with which you can
  /// add a Wish to your Book Wishlist
  WidgetRouter.addWishScreen({Key? key}) : super(key: key) {
    _routeName = Routes.addWishScreen;
  }

  /// Shows the Unknown Screen
  WidgetRouter.unknownScreen({Key? key}) : super(key: key) {
    _routeName = Routes.unknownscreen;
  }

  /// Widget Router for the Settings Screen
  WidgetRouter.settingsScreen({Key? key}) : super(key: key) {
    _routeName = Routes.settingsScreen;
  }

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
              : const AddEntryScreenMobile(),
        );

      // Case for the Add Book Screen
      case Routes.addBookScreen:
        return BlocParent(
          bloc: AddBookBloc(),
          child: isDesktop
              ? const AddBookScreenDesktop()
              : const AddBookScreenMobile(),
        );

      // Case for the Add Wish Screen
      case Routes.addWishScreen:
        return BlocParent(
          bloc: AddWishBloc(),
          child: isDesktop
              ? const AddWishScreenDesktop()
              : const AddWishScreenMobile(),
        );

      // Case for the Settings Screen
      case Routes.settingsScreen:
        return BlocParent(
          bloc: SettingsBloc(),
          child: isDesktop
              ? const SettingsScreenDesktop()
              : const SettingsScreenMobile(),
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
