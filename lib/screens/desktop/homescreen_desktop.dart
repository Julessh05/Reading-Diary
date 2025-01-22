library desktop_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:desktop_navigation_menu/desktop_navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/blocs.dart' show HomescreenBloc;
import 'package:string_translate/string_translate.dart' show Translate;

/// The Desktop Version of the Homescreen
/// for this App.
class HomescreenDesktop extends StatefulWidget {
  const HomescreenDesktop({super.key});

  @override
  State<HomescreenDesktop> createState() => _HomescreenDesktopState();
}

class _HomescreenDesktopState extends State<HomescreenDesktop> {
  /// The Bloc for the Homescreen.
  HomescreenBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    return Scaffold(
      // appBar: AppBar(),
      body: DesktopNavigationMenu(
        views: [
          DesktopNavigationItem(
            menuItem: DesktopMenuItem(
              label: 'Home'.tr(),
              description: 'Home and Explore'.tr(),
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home_rounded),
            ),
            screen: const Text('Home'),
          ),
          DesktopNavigationItem(
            menuItem: DesktopMenuItem(
              label: 'Diary'.tr(),
              description: 'The Actual Diary'.tr(),
              icon: const Icon(Icons.menu_book_outlined),
              activeIcon: const Icon(Icons.menu_book_rounded),
            ),
            screen: const Text('Diary'),
          ),
          DesktopNavigationItem(
            menuItem: DesktopMenuItem(
              label: 'Wishlist'.tr(),
              description: 'Your Wishlist of Books'.tr(),
              icon: const Icon(Icons.bookmark_outline),
              activeIcon: const Icon(Icons.bookmark_rounded),
            ),
            screen: const Text('Wishlist'),
          ),
          DesktopNavigationItem(
            menuItem: DesktopMenuItem(
              label: 'Books'.tr(),
              description: 'All your Books'.tr(),
              icon: const Icon(Icons.book_outlined),
              activeIcon: const Icon(Icons.book_rounded),
            ),
            screen: const Text('Books'),
          )
        ],
      ),
    );
  }
}
