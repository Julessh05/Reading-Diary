library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart'
    hide BlocNotFoundException, BlocState;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:reading_diary/blocs/homescreen_bloc.dart';
import 'package:reading_diary/components/mobile/entry_container_mobile.dart';
import 'package:reading_diary/components/mobile/statistic_container_mobile.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:string_translate/string_translate.dart' show Translate;

/// Homescreen for mobile devices
class HomescreenMobile extends StatefulWidget {
  const HomescreenMobile({Key? key}) : super(key: key);

  @override
  State<HomescreenMobile> createState() => _HomescreenMobileState();
}

class _HomescreenMobileState extends State<HomescreenMobile> {
  /// Bloc for the Homescreen.
  /// Is initialized once,
  /// shouldn't be changed
  HomescreenBloc? _bloc;

  /// Scroll Controller for the
  /// Diary Screen.
  /// Controlls whether the Floating Action Button
  /// on the diary screen is extended or not.
  final ScrollController _diarySController = ScrollController();

  /// Scroll Controller that determines
  /// whether the Floating Action Button on the Wishlist Screen
  /// is extended or not.
  final ScrollController _wishlistSController = ScrollController();

  @override
  void initState() {
    // Add Listener to Diary Scroll Controller
    _diarySController.addListener(() {
      if (_diarySController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _bloc!.diaryFabExtended = false;
        });
      } else if (_diarySController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _bloc!.diaryFabExtended = true;
        });
      }
    });

    // Add Listener to Wishlist Scroll Controller
    _wishlistSController.addListener(() {
      if (_wishlistSController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _bloc!.wishlistFabExtended = false;
        });
      } else if (_wishlistSController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _bloc!.wishlistFabExtended = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    return Scaffold(
      appBar: _appBar,
      body: _body,
      bottomNavigationBar: _bottomBar,
      floatingActionButton: _fab,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  /// Returns the floating Action Button
  /// depending on the current Index [_bloc.currentBNBIndex] of the
  /// Bottom Navigation Bar.
  Widget? get _fab {
    final Set<Widget?> afab = {null, _diaryFab, _wishlistFab};
    return afab.elementAt(_bloc!.currentBNBIndex);
  }

  /// Extended Floating Action Button
  /// for the Diary Screen.
  /// This has a Label and an Icon.
  /// Only shown if you scroll upwards.
  FloatingActionButton get _diaryEFab {
    return FloatingActionButton.extended(
      onPressed: () => _bloc!.onDiaryFabTap(context).then(
            (value) => setState(() {}),
          ),
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      label: Text('Add Entry'.tr()),
      icon: const Icon(Icons.note_add_rounded),
      isExtended: true,
      heroTag: 'Extended Diary Floating Action Button',
    );
  }

  /// Shrinked Version of the Floating Action Button
  /// on the Diary Screen.
  /// Shown when you scroll down, so it doesn't
  /// bother the user.
  FloatingActionButton get _shrinkedDiaryFab {
    return FloatingActionButton(
      onPressed: () => _bloc!.onDiaryFabTap(context).then(
            (value) => setState(() {}),
          ),
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isExtended: false,
      heroTag: 'Shrinked Diary Floating Action Button',
      child: const Icon(Icons.note_add_rounded),
    );
  }

  /// The Floating Action Button
  /// for the Diary Screen.
  /// Is A Clip to create a kind of circular Widget.
  /// Has a Animation when changing the Size of it.
  ClipRRect get _diaryFab {
    const Duration aDur = Duration(milliseconds: 300);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: AnimatedCrossFade(
        duration: aDur,
        reverseDuration: aDur,
        crossFadeState: _bloc!.diaryFabExtended
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: _diaryEFab,
        secondChild: _shrinkedDiaryFab,
        alignment: Alignment.center,
        excludeBottomFocus: false,
      ),
    );
  }

  /// Returns the AppBar depending
  /// on the index of the
  /// bottom navigation bar.
  AppBar get _appBar {
    final Set<AppBar> aB = {_homeAppBar, _diaryAppBar, _wishlistAppBar};
    return aB.elementAt(_bloc!.currentBNBIndex);
  }

  /// The AppBar for the mobile
  /// Homescreen.
  AppBar get _homeAppBar {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Home'.tr()),
    );
  }

  /// AppBar for the
  /// Diary Screen.
  AppBar get _diaryAppBar {
    return AppBar(
      actions: <IconButton>[
        IconButton(
          alignment: Alignment.center,
          autofocus: false,
          enableFeedback: true,
          tooltip: 'Search your Entries'.tr(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
        ),
      ],
      automaticallyImplyLeading: false,
      title: Text('Diary'.tr()),
    );
  }

  /// Returns the body
  /// at the current Index.
  Scrollbar get _body {
    final Set<Scrollbar> pB = {_homeBody, _diaryBody, _wishlistBody};
    return pB.elementAt(_bloc!.currentBNBIndex);
  }

  /// The Body of the mobile
  /// Homescreen
  Scrollbar get _homeBody {
    return Scrollbar(
      child: ListView(
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
                return const StatisticContainerMobile(
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
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (_, counter) {
              return EntryContainerMobile(
                entry: DiaryEntry(
                  entry: 'Entry',
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Body for the Diary
  Scrollbar get _diaryBody {
    return Scrollbar(
      controller: _diarySController,
      child: ListView.builder(
        controller: _diarySController,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        itemCount: Diary.entries.length,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, c) {
          return EntryContainerMobile(
            entry: Diary.entries[c],
          );
        },
      ),
    );
  }

  /// AppBar for the Wishlist screen
  AppBar get _wishlistAppBar {
    return AppBar(
      actions: <IconButton>[
        IconButton(
          alignment: Alignment.center,
          autofocus: false,
          enableFeedback: true,
          tooltip: 'Search your Wishlist'.tr(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
        ),
      ],
      automaticallyImplyLeading: false,
      title: Text('Wishlist'.tr()),
    );
  }

  /// Body of the Wishlist Screen.
  /// This displayes the users wishes of Books.
  Scrollbar get _wishlistBody {
    return Scrollbar(
      controller: _wishlistSController,
      child: ListView.builder(
        controller: _wishlistSController,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        itemCount: 2,
        itemBuilder: (_, counter) {
          return Container();
        },
      ),
    );
  }

  /// Animation that returnes the
  /// Floating Action Button currently used on
  /// the wishlist Screen.
  ClipRRect get _wishlistFab {
    const Duration aDur = Duration(milliseconds: 300);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: AnimatedCrossFade(
        duration: aDur,
        reverseDuration: aDur,
        crossFadeState: _bloc!.wishlistFabExtended
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: _wishlistEFab,
        secondChild: _shrinkedWishlistFab,
        alignment: Alignment.center,
        excludeBottomFocus: false,
      ),
    );
  }

  /// The disabled Version of the Floating Action Button
  /// used to add a new Wish on the Wishlist.
  FloatingActionButton get _shrinkedWishlistFab {
    return FloatingActionButton(
      onPressed: () => _bloc!.onWishlistFabTap(context).then(
            (value) => setState(() {}),
          ),
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isExtended: false,
      heroTag: 'Shrinked Wishlist Floating Action Button',
      child: const Icon(Icons.bookmark_add_rounded),
    );
  }

  /// The enabled Version of the Floating Action Button
  /// used to add a new Wish on the Wishlist.
  FloatingActionButton get _wishlistEFab {
    return FloatingActionButton.extended(
      onPressed: () => _bloc!.onWishlistFabTap(context).then(
            (value) => setState(() {}),
          ),
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      label: Text('Add Wish'.tr()),
      icon: const Icon(Icons.note_add_rounded),
      isExtended: true,
      heroTag: 'Extended Wishlist Floating Action Button',
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
        currentIndex: _bloc!.currentBNBIndex,
        onTap: (newI) => setState(() => _bloc!.onBNBTap(newI)),
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
          BottomNavigationBarItem(
            icon: const Icon(Icons.format_list_bulleted_outlined),
            label: 'Wishlist'.tr(),
            backgroundColor: Colors.blue.shade800,
            activeIcon: const Icon(Icons.format_list_bulleted_rounded),
            tooltip: 'Your Wishlist of Books'.tr(),
          ),
        ],
      ),
    );
  }
}
