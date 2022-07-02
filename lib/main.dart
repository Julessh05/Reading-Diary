library main;

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_diary/storage/storage.dart';
import 'package:string_translate/string_translate.dart' show Translation;

void main() async {
  await Hive.initFlutter();
  // TODO: check if await is needed here.
  Storage.init();
  runApp(const ReadingDiary());
}

class ReadingDiary extends StatelessWidget {
  const ReadingDiary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String title = 'Reading Diary';
    return MaterialApp();
  }
}
