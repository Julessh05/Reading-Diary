library mobile_components;

import 'package:flutter/material.dart';

/// A Container that shows a specific Part of information,
/// depending on a single Entry.
class EntryDetailsContainerMobile extends StatelessWidget {
  const EntryDetailsContainerMobile(
    this._data, {
    Key? key,
  }) : super(key: key);

  /// The data actually beeing
  /// used in the Container.
  final String _data;

  @override
  Widget build(BuildContext context) {
    return Card(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          children: [
            Text(_data),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
