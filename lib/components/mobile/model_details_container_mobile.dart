library mobile_components;

import 'package:flutter/material.dart';

/// A Container that shows a specific Part of information,
/// depending on a single Entry.
class ModelDetailsContainerMobile extends StatelessWidget {
  const ModelDetailsContainerMobile({
    required this.name,
    this.data,
    this.child,
    this.small = false,
    this.multiline = false,
    Key? key,
  })  : assert(
          child == null && data != null || child != null && data == null,
          'You can eighter pass a child or a String of data, not both.',
        ),
        super(key: key);

  /// The Name of the Field
  final String name;

  /// Whether this is a small or normal
  /// Container
  /// Default is false
  final bool small;

  /// If the Container represents an
  /// mutlitline Text like the
  /// Content of an Entry,
  /// set this to true.
  /// Default is false
  final bool multiline;

  /// The actual Data being displayed.
  final String? data;

  /// The child passed instead of the [data]
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: () {
        if (small) {
          return MediaQuery.of(context).size.height / 6;
        } else if (multiline) {
          return MediaQuery.of(context).size.height;
        } else {
          return MediaQuery.of(context).size.height / 4.5;
        }
      }(),
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
              Text(name, style: _tStyle),
              const SizedBox(height: 18),
              data != null ? Text(data!) : child!,
            ],
          ),
        ),
      ),
    );
  }

  /// Text Style for the [name]
  TextStyle get _tStyle {
    return const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
  }
}
