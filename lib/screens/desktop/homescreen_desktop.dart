library desktop_screens;

import 'package:desktop_navigation_menu/desktop_navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/blocs.dart' show HomescreenBloc;

/// The Desktop Version of the Homescreen
/// for this App.
class HomescreenDesktop extends StatefulWidget {
  const HomescreenDesktop({Key? key}) : super(key: key);

  @override
  State<HomescreenDesktop> createState() => _HomescreenDesktopState();
}

class _HomescreenDesktopState extends State<HomescreenDesktop> {
  /// The Bloc for the Homescreen.
  HomescreenBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const DesktopNavigationMenu(
        views: [
          NavigationItem(
            menuItem: DesktopMenuItem(
              label: 'Test',
            ),
            screen: Text('test'),
          ),
          NavigationItem(
            menuItem: DesktopMenuItem(label: 'Lol', description: 'Looooool'),
            screen: Text('lol'),
          ),
        ],
      ),
    );
  }
}
