library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart'
    hide BlocNotFoundException, BlocState;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:modern_themes/modern_themes_comps.dart';
import 'package:reading_diary/blocs/homescreen_bloc.dart';
import 'package:reading_diary/components/mobile/add_model_container_mobile.dart';
import 'package:reading_diary/components/mobile/model_container_mobile.dart';
import 'package:reading_diary/components/mobile/statistic_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:reading_diary/models/book_list.dart';
import 'package:reading_diary/models/diary.dart';
import 'package:reading_diary/models/diary_entry.dart' show DiaryEntry;
import 'package:reading_diary/models/search_results.dart';
import 'package:reading_diary/models/statistic.dart';
import 'package:reading_diary/models/wishlist.dart';
import 'package:reading_diary/states/homescreen_state.dart';
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

  /// Scroll Controller that determines
  /// whether the Floating Action Button on the Book Screen
  /// is extended or not.
  final ScrollController _bookSController = ScrollController();

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

    // Add Listener to Book Scroll Controller
    _bookSController.addListener(() {
      if (_bookSController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _bloc!.bookFabExtended = false;
        });
      } else if (_bookSController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _bloc!.bookFabExtended = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc ??= BlocParent.of(context);

    if (!_bloc!.stateStream.hasListener) {
      _bloc!.stateStream.stream.listen(
        (state) => _handleState(state),
      );
    }

    return Scaffold(
      appBar: _appBar,
      body: _body,
      bottomNavigationBar: _bottomBar,
      floatingActionButton: _fab,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  /// Handles the
  /// States that are passed through the
  /// [_bloc.stateStream].
  void _handleState(HomescreenState state) {
    setState(() {});
  }

  /// Returns the floating Action Button
  /// depending on the current Index [_bloc.currentBNBIndex] of the
  /// Bottom Navigation Bar.
  ClipRRect? get _fab {
    final Set<ClipRRect?> afab = {null, _diaryFab, _wishlistFab, _bookFab};
    return afab.elementAt(_bloc!.currentBNBIndex);
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

  /// Extended Floating Action Button
  /// for the Diary Screen.
  /// This has a Label and an Icon.
  /// Only shown if you scroll upwards.
  FloatingActionButton get _diaryEFab {
    return FloatingActionButton.extended(
      onPressed: _onDiaryFabTap,
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
      onPressed: _onDiaryFabTap,
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isExtended: false,
      heroTag: 'Shrinked Diary Floating Action Button',
      child: const Icon(Icons.note_add_rounded),
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
      onPressed: _onWishlistFabTap,
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
      onPressed: _onWishlistFabTap,
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      label: Text('Add Wish'.tr()),
      icon: const Icon(Icons.bookmark_add_rounded),
      isExtended: true,
      heroTag: 'Extended Wishlist Floating Action Button',
    );
  }

  /// The Widget that returns the Floating Action Button
  /// needed. Also contains an Animation
  ClipRRect get _bookFab {
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
        firstChild: _bookEFab,
        secondChild: _shrinkedBookFab,
        alignment: Alignment.center,
        excludeBottomFocus: false,
      ),
    );
  }

  /// The shrinked Foating Action Button on the Book Screen.
  FloatingActionButton get _shrinkedBookFab {
    return FloatingActionButton(
      onPressed: _openAddBookScreen,
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isExtended: false,
      heroTag: 'Shrinked Book Floating Action Button',
      child: const Icon(Icons.post_add_rounded),
    );
  }

  /// The Extended Version
  /// of the Floating Action Button
  /// on the Book Screen
  FloatingActionButton get _bookEFab {
    return FloatingActionButton.extended(
      onPressed: _openAddBookScreen,
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      label: Text('Add Book'.tr()),
      icon: const Icon(Icons.post_add_rounded),
      isExtended: true,
      heroTag: 'Extended Book Floating Action Button',
    );
  }

  /// Returns the AppBar depending
  /// on the index of the
  /// bottom navigation bar.
  AppBar get _appBar {
    final Set<AppBar> aB = {
      _homeAppBar,
      _diaryAppBar,
      _wishlistAppBar,
      _bookAppBar
    };
    return aB.elementAt(_bloc!.currentBNBIndex);
  }

  /// The AppBar for the mobile
  /// Homescreen.
  AppBar get _homeAppBar {
    return AppBar(
      actions: <IconButton>[
        IconButton(
          onPressed: _openSettingsScreen,
          icon: const Icon(Icons.settings_rounded),
        ),
      ],
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
          onPressed: _openSettingsScreen,
          icon: const Icon(Icons.settings_rounded),
        ),
      ],
      leading: IconButton(
        alignment: Alignment.center,
        autofocus: false,
        enableFeedback: true,
        tooltip: 'Search your Entries'.tr(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        onPressed: _showSearchDialog,
        icon: const Icon(Icons.search_rounded),
      ),
      automaticallyImplyLeading: false,
      title: Text('Diary'.tr()),
    );
  }

  /// AppBar for the Book Screen.
  AppBar get _bookAppBar {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Books'.tr()),
      actions: <IconButton>[
        IconButton(
          onPressed: _openSettingsScreen,
          icon: const Icon(Icons.settings_rounded),
        ),
      ],
      leading: IconButton(
        onPressed: _showSearchDialog,
        autofocus: false,
        tooltip: 'Search your Books'.tr(),
        icon: const Icon(Icons.search_rounded),
        alignment: Alignment.center,
        enableFeedback: true,
      ),
    );
  }

  /// AppBar for the Wishlist screen
  AppBar get _wishlistAppBar {
    return AppBar(
      actions: <IconButton>[
        IconButton(
          onPressed: _openSettingsScreen,
          icon: const Icon(Icons.settings_rounded),
        ),
      ],
      leading: IconButton(
        alignment: Alignment.center,
        autofocus: false,
        enableFeedback: true,
        tooltip: 'Search your Wishlist'.tr(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        onPressed: _showSearchDialog,
        icon: const Icon(Icons.search_rounded),
      ),
      automaticallyImplyLeading: false,
      title: Text('Wishlist'.tr()),
    );
  }

  /// All the Options for the Dropdown Menu
  List<DropdownMenuItem<Book>> get _bookDropDownItems {
    final List<DropdownMenuItem<Book>> list = [];

    list.add(
      DropdownMenuItem(
        alignment: Alignment.center,
        enabled: true,
        value: const Book.none(),
        onTap: () {
          setState(() {
            _bloc!.diarySearchBook = null;
          });
        },
        child: Text('None'.tr()),
      ),
    );

    for (Book book in BookList.books) {
      list.add(
        DropdownMenuItem(
          alignment: Alignment.center,
          enabled: true,
          value: book,
          onTap: () {
            setState(() {
              _bloc!.diarySearchBook = book;
            });
          },
          child: Text(book.title),
        ),
      );
    }

    return list;
  }

  /// The TextStyle used for
  /// the 'Filter' Label inside the
  /// search Dialog
  TextStyle get _filterLabelStyle {
    return const TextStyle(
      fontStyle: FontStyle.normal,
      fontSize: 22.5,
      fontWeight: FontWeight.w400,
    );
  }

  /// Returns the body
  /// at the current Index.
  Scrollbar get _body {
    final Set<Scrollbar> pB = {
      _homeBody,
      _diaryBody,
      _wishlistBody,
      _bookBody,
    };
    return pB.elementAt(_bloc!.currentBNBIndex);
  }

  /// The Body of the mobile
  /// Homescreen
  Scrollbar get _homeBody {
    final List<Statistic> stats = _bloc!.statistics;
    final List<DiaryEntry> entries = _bloc!.homeEntries;
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.6,
            child: ListView(
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
              children: <StatisticContainerMobile>[
                // Is always the current Book.
                StatisticContainerMobile(
                  statistic: stats[0],
                  onTap: () => _openBookDetailsScreen(stats[0].book),
                ),
                StatisticContainerMobile(statistic: stats[1]),
              ],
            ),
          ),
          entries.isNotEmpty
              ? ListView.builder(
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  addSemanticIndexes: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  dragStartBehavior: DragStartBehavior.down,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  reverse: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _bloc!.homeEntries.length,
                  itemBuilder: (_, counter) {
                    return ModelContainerMobile(entry: entries[counter]);
                  },
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  textBaseline: TextBaseline.alphabetic,
                  textDirection: TextDirection.ltr,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        textBaseline: TextBaseline.alphabetic,
                        textDirection: TextDirection.ltr,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Text('No last Entries found'.tr()),
                          GestureDetector(
                            behavior: HitTestBehavior.deferToChild,
                            dragStartBehavior: DragStartBehavior.down,
                            onTap: () => _onDiaryFabTap(),
                            child: Text(
                              'Add one'.tr(),
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  /// Body for the Diary
  Scrollbar get _diaryBody {
    return Diary.entries.isNotEmpty
        ? Scrollbar(
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
                return ModelContainerMobile(
                  entry: Diary.entries[c],
                );
              },
            ),
          )
        : _getEmptyBody('Entries');
  }

  /// Shown when the [what]
  /// is empty.
  Scrollbar _getEmptyBody(String what) {
    return Scrollbar(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Text(
              'You\'ve got no $what yet.'.tr(),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              dragStartBehavior: DragStartBehavior.down,
              onTap: () {
                switch (what) {
                  case 'Entries':
                    _onDiaryFabTap();
                    break;
                  case 'Books':
                    _openAddBookScreen();
                    break;
                  case 'Wishes':
                    _onWishlistFabTap();
                    break;
                }
              },
              child: Text(
                'Add one'.tr(),
                style: TextStyle(
                  color: Colors.blue.shade600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Body for the Book Screen.
  Scrollbar get _bookBody {
    return BookList.books.isNotEmpty
        ? Scrollbar(
            controller: _bookSController,
            child: ListView.builder(
              controller: _bookSController,
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              addSemanticIndexes: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              dragStartBehavior: DragStartBehavior.down,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              reverse: false,
              scrollDirection: Axis.vertical,
              itemCount: BookList.books.length,
              itemBuilder: (_, counter) {
                return ModelContainerMobile(
                  book: BookList.books[counter],
                );
              },
            ),
          )
        : _getEmptyBody('Books');
  }

  /// Body of the Wishlist Screen.
  /// This displayes the users wishes of Books.
  Scrollbar get _wishlistBody {
    return Wishlist.wishes.isNotEmpty
        ? Scrollbar(
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
              itemCount: Wishlist.wishes.length,
              itemBuilder: (_, counter) {
                return ModelContainerMobile(
                  wish: Wishlist.wishes[counter],
                );
              },
            ),
          )
        : _getEmptyBody('Wishes');
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
            backgroundColor: Coloring.mainColor,
            activeIcon: const Icon(Icons.home_rounded),
            tooltip: 'Home and Explore'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_outlined),
            label: 'Diary'.tr(),
            backgroundColor: Coloring.mainColor,
            activeIcon: const Icon(Icons.menu_book_rounded),
            tooltip: 'The Actual Diary'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_outline),
            label: 'Wishlist'.tr(),
            backgroundColor: Coloring.mainColor,
            activeIcon: const Icon(Icons.bookmark_rounded),
            tooltip: 'Your Wishlist of Books'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book_outlined),
            label: 'Books'.tr(),
            backgroundColor: Coloring.mainColor,
            activeIcon: const Icon(Icons.book_rounded),
            tooltip: 'All your Books'.tr(),
          ),
        ],
      ),
    );
  }

  /// The Search Dialog for the
  /// Diary Screen.
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          scrollable: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          title: Text('Search your Entries'.tr()),
          content: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            dragStartBehavior: DragStartBehavior.down,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: false,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: [
                AddModelContainerMobile(
                  name: 'Keyword'.tr(),
                  done: (str) => _bloc!.searchKeyword = str,
                  opacity: 0.7,
                ),
                Center(
                  child: Text(
                    'Filter'.tr(),
                    style: _filterLabelStyle,
                  ),
                ),
                AddModelContainerMobile(
                  name: 'Book'.tr(),
                  opacity: 0.7,
                  child: DropdownButton<Book>(
                    items: _bookDropDownItems,
                    alignment: Alignment.center,
                    autofocus: false,
                    enableFeedback: true,
                    value: _bloc!.diarySearchBook ?? const Book.none(),
                    onChanged: (book) {
                      if (book == null) {
                        _bloc!.diarySearchBook = null;
                      } else if (book == const Book.none()) {
                        _bloc!.diarySearchBook = null;
                      } else {
                        _bloc!.diarySearchBook = BookList.books
                            .where((element) => element == book)
                            .first;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <TextButton>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              autofocus: false,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                SearchResults results = _bloc!.onSearchTap();
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.searchResultsScreen,
                  arguments: results,
                );
              },
              autofocus: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text('Ok'.tr()),
            ),
          ],
        );
      },
    );
  }

  /// Opens the Book Details Screen.
  /// This is used to show
  /// details about the most recent
  /// Book on the Homescreen.
  void _openBookDetailsScreen(Book? book) {
    if (book == null) {
      return;
    } else {
      Navigator.pushNamed(
        context,
        Routes.bookDetailsScreen,
        arguments: book,
      ).then((value) => setState(() {}));
    }
  }

  /// Called when the Button the
  /// the Diary Screen
  /// is tapped
  void _onDiaryFabTap() {
    Navigator.pushNamed(
      context,
      Routes.addEntryScreen,
      arguments: AddOrEdit.add(),
    ).then(
      (value) => setState(() {}),
    );
  }

  /// Called when the Button the
  /// the Wishlist Screen
  /// is tapped
  void _onWishlistFabTap() {
    Navigator.pushNamed(
      context,
      Routes.addWishScreen,
      arguments: AddOrEdit.add(),
    ).then(
      (value) => setState(() {}),
    );
  }

  /// Method called when the User
  /// clicked the 'Add Book' Item on the Dropdown.
  void _openAddBookScreen() {
    Navigator.pushNamed(
      context,
      Routes.addBookScreen,
      arguments: AddOrEdit.add(),
    ).then(
      (value) => setState(() {}),
    );
  }

  /// Opens the Settings Screen.
  void _openSettingsScreen() {
    Navigator.pushNamed(context, Routes.settingsScreen).then(
      (value) => setState(() {}),
    );
  }
}
