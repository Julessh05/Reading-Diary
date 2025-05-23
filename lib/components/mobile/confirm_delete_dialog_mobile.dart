import 'package:flutter/material.dart'
    show
        AlertDialog,
        Alignment,
        BuildContext,
        Clip,
        Navigator,
        Text,
        TextButton;
import 'package:reading_diary/models/reading_diary_objects.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// Returns an Alert Dialog, that is shown
/// when the User wnats to delete something.
AlertDialog confirmDeleteDialogMobile({
  required String title,
  required ReadingDiaryObjects what,
  required BuildContext context,
  required void Function() onConfirm,
}) {
  return AlertDialog(
    alignment: Alignment.center,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    scrollable: true,
    title: Text('Confirm Delete'.tr()),
    content: _getContent(what, title),
    actions: <TextButton>[
      TextButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        autofocus: false,
        child: Text('Cancel'.tr()),
        onPressed: () => Navigator.pop(context),
      ),
      TextButton(
        autofocus: false,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: () {
          onConfirm();
          Navigator.pop(context);
        },
        child: Text('Confirm'.tr()),
      ),
    ],
  );
}

/// Returns the Content of the Dialog.
Text _getContent(ReadingDiaryObjects what, String title) {
  switch (what) {
    case ReadingDiaryObjects.book:
      return Text(
        '${'Confirm Deletion of:'.tr()} $title (${'Book'.tr()}). \n${'With deleting this Book, all the linked Entries and Wishes will be deleted too.'.tr()}',
      );
    case ReadingDiaryObjects.entry:
      return Text(
        '${'Confirm Deletion of:'.tr()} $title (${'Entry'.tr()}).',
      );
    case ReadingDiaryObjects.wish:
      return Text(
        '${'Confirm Deletion of:'.tr()} $title (${'Wish'.tr()}).',
      );
  }
}
