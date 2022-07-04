library mobile_components;

import 'package:flutter/material.dart';

class BookContainerMobile extends StatelessWidget {
  const BookContainerMobile({
    required this.date,
    required this.title,
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final String title;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text(title),
                Text(
                  '${date.day}.${date.month}.${date.year}',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
