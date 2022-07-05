library shared_screens;

import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart';

class UnknwonScreen extends StatelessWidget {
  const UnknwonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            const Spacer(flex: 5),
            const Icon(
              Icons.question_mark_rounded,
              size: 75,
            ),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Something went wrong, we couldn\'t find the screen you where looking for'
                    .tr(),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 5)
          ],
        ),
      ),
    );
  }
}
