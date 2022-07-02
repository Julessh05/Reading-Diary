library mobile_screens;

import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart';

class HomescreenMobile extends StatefulWidget {
  const HomescreenMobile({Key? key}) : super(key: key);

  @override
  State<HomescreenMobile> createState() => _HomescreenMobileState();
}

class _HomescreenMobileState extends State<HomescreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: _bottomBar,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  Widget get _body {
    return Container(
      height: 200,
      width: 200,
      color: Colors.red,
    );
  }

  /// Bottom Navigation Bar for
  /// the Mobile Homescreen.
  ClipRRect get _bottomBar {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: 'Home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_rounded),
            label: 'Diary'.tr(),
          )
        ],
      ),
    );
  }
}
