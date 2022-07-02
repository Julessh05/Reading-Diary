library logic;

import 'package:flutter/material.dart';
import 'package:reading_diary/logic/navigating/routes.dart';

// TODO: create Pull Request, merge and add Screens

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

  /// Route Name the Widget Router works with
  late final String _routeName;

  @override
  Widget build(BuildContext context) {
    switch (_routeName) {
      case Routes.homescreen:
        break;
      case Routes.unknownscreen:
        return UnknownScreen();
    }
  }
}
