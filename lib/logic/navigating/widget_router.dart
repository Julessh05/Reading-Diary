library logic;

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/homescreen_bloc.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/screens/desktop/homescreen_desktop.dart';
import 'package:reading_diary/screens/mobile/homescreen_mobile.dart';
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

  /// Shows the Unknown Screen
  WidgetRouter.unknownScreen({Key? key}) : super(key: key) {
    _routeName = Routes.unknownscreen;
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
