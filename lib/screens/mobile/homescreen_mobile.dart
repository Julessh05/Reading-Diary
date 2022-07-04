library mobile_screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reading_diary/components/mobile/mobile_book_container.dart';
import 'package:string_translate/string_translate.dart';

/// Homescreen for mobile devices
class HomescreenMobile extends StatefulWidget {
  const HomescreenMobile({Key? key}) : super(key: key);

  @override
  State<HomescreenMobile> createState() => _HomescreenMobileState();
}

class _HomescreenMobileState extends State<HomescreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
      bottomNavigationBar: _bottomBar,
      extendBody: true,
      extendBodyBehindAppBar: false,
    );
  }

  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text('Home'),
    );
  }

  /// The Body of the mobile
  /// Homescreen
  Widget get _body {
    return Scrollbar(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        textBaseline: TextBaseline.alphabetic,
        textDirection: TextDirection.ltr,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.6,
            child: ListView.builder(
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              addSemanticIndexes: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              dragStartBehavior: DragStartBehavior.down,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              reverse: false,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: ((_, conter) {
                return const MobileBookContainer(
                  title: 'Title',
                  content: 'Content',
                );
              }),
            ),
          ),
          ListView.builder(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            dragStartBehavior: DragStartBehavior.down,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            reverse: false,
            scrollDirection: Axis.vertical,
            itemCount: 100,
            itemBuilder: (_, counter) {
              return Container();
            },
          ),
        ],
      ),
    );
  }

  /// Bottom Navigation Bar for
  /// the Mobile Homescreen.
  ClipRRect get _bottomBar {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: 'Home'.tr(),
            backgroundColor: Colors.blue.shade800,
            activeIcon: const Icon(Icons.home_rounded),
            tooltip: 'Homescreen of the App'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_outlined),
            label: 'Diary'.tr(),
            backgroundColor: Colors.blue.shade800,
            activeIcon: const Icon(Icons.menu_book_rounded),
            tooltip: 'The Actual Diary'.tr(),
          ),
        ],
      ),
    );
  }
}
