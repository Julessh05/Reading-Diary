library mobile_components;

import 'package:flutter/material.dart';
import 'package:reading_diary/models/diary_entry.dart';

class EntryContainerMobile extends StatelessWidget {
  const EntryContainerMobile({
    required this.entry,
    Key? key,
  }) : super(key: key);

  final DiaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      child: Card(
        elevation: 8,
        borderOnForeground: false,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).scaffoldBackgroundColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Colors.transparent,
            style: BorderStyle.solid,
            width: 0.3,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              bottom: 15,
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(),
              position: DecorationPosition.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                textBaseline: TextBaseline.alphabetic,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Text(
                    '${entry.date.day}.${entry.date.month}.${entry.date.year}',
                    style: _dStyle,
                  ),
                  Text(entry.title!, style: _tStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get _tStyle {
    return const TextStyle(
      fontSize: 25,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get _dStyle {
    return const TextStyle(
      fontSize: 15,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
    );
  }
}
