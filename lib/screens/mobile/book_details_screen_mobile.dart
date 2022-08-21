library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/blocs.dart' show BookDetailsBloc;
import 'package:reading_diary/components/mobile/model_details_container_mobile.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/models/add_or_edit.dart';
import 'package:reading_diary/models/book.dart' show Book;
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

/// Screen that represents a single Book in the App
/// and shows you all Information about this Book.
class BookDetailsScreenMobile extends StatefulWidget {
  const BookDetailsScreenMobile({
    required this.book,
    Key? key,
  }) : super(key: key);

  /// The Book this Screen
  /// represents
  final Book book;

  @override
  State<BookDetailsScreenMobile> createState() =>
      _BookDetailsScreenMobileState();
}

class _BookDetailsScreenMobileState extends State<BookDetailsScreenMobile> {
  /// The corresponding Bloc for this Screen.
  BookDetailsBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  /// The AppBar for that screen.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(widget.book.title),
      actions: <IconButton>[
        IconButton(
          onPressed: _editBTNPressed,
          icon: const Icon(Icons.edit_rounded),
          autofocus: false,
          alignment: Alignment.center,
          enableFeedback: true,
          tooltip: 'Edit Book'.tr(),
        ),
        IconButton(
          onPressed: _deleteBTNPressed,
          icon: const Icon(Icons.delete_rounded),
          autofocus: false,
        ),
      ],
    );
  }

  Scrollbar get _body {
    final double percentualProgress = _bloc!.calculateProcentualProgress(
      widget.book,
    );
    return Scrollbar(
      child: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          widget.book.author != null
              ? ModelDetailsContainerMobile(
                  name: 'Author'.tr(),
                  data: widget.book.author!,
                  small: true,
                )
              : Container(),
          ModelDetailsContainerMobile(
            name: 'Pages'.tr(),
            data: widget.book.pages.toString(),
            small: true,
          ),
          ModelDetailsContainerMobile(
            name: 'Current Page'.tr(),
            data: widget.book.currentPage.toString(),
            small: true,
          ),
          ModelDetailsContainerMobile(
            name: 'Progress'.tr(),
            small: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.red,
                  semanticsLabel: 'Progress'.tr(),
                  semanticsValue: 'Percentual Value: $percentualProgress%',
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                  value: percentualProgress * 0.01,
                ),
                const SizedBox(height: 10),
                Text('$percentualProgress%')
              ],
            ),
          ),
          ModelDetailsContainerMobile(
            name: 'Notes'.tr(),
            data: widget.book.notes.isNotEmpty
                ? widget.book.notes
                : 'No Notes'.tr(),
          ),
          widget.book.price != null
              ? ModelDetailsContainerMobile(
                  name: 'Price'.tr(),
                  data: '${widget.book.price.toString()}€',
                  small: true,
                )
              : Container(),
          () {
            if (widget.book.url != null) {
              if (widget.book.url!.isNotEmpty) {
                return GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () async {
                    final Uri u = Uri.parse(widget.book.url!);
                    await launchUrl(u, mode: LaunchMode.platformDefault);
                  },
                  child: ModelDetailsContainerMobile(
                    name: 'Post',
                    data: widget.book.url!,
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }(),
          FittedBox(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'.tr()),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Called when the delete Button is pressed.
  void _deleteBTNPressed() {
    _bloc!.deleteBook(widget.book);
    Navigator.pop(context);
  }

  /// Called whe the Edit Button
  /// is Pressed
  void _editBTNPressed() {
    Navigator.pushNamed(
      context,
      Routes.addBookScreen,
      arguments: AddOrEdit.book(book: widget.book),
    );
  }
}
