library mobile_components;

import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;

/// A Container with an input Dialog and a
class AddEntryContainer extends StatelessWidget {
  const AddEntryContainer({
    required this.name,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.done,
    this.child,
    this.big = false,
    Key? key,
  })  : assert(
          child == null && done != null || child != null,
          'If you don\'t speficy a child, you have to pass a done Function',
        ),
        assert(
          big == true && child != null || big == false,
          'You can only have a bigger container, when you specify your own child',
        ),
        super(key: key);

  final String name;
  final bool autofocus;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLines;
  final void Function(String)? done;
  final Widget? child;
  final bool big;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: big
          ? MediaQuery.of(context).size.height / 3.3
          : MediaQuery.of(context).size.height / 4.5,
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
              Text(
                name,
                style: _tStyle,
              ),
              const SizedBox(height: 18),
              child ??
                  SizedBox(
                    height: 80,
                    child: TextField(
                      autocorrect: true,
                      autofocus: autofocus,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      dragStartBehavior: DragStartBehavior.down,
                      enableIMEPersonalizedLearning: true,
                      enableInteractiveSelection: true,
                      enableSuggestions: true,
                      enabled: true,
                      expands: false,
                      obscureText: false,
                      keyboardAppearance: Theme.of(context).brightness,
                      scrollPhysics: const BouncingScrollPhysics(),
                      keyboardType: keyboardType,
                      readOnly: false,
                      smartDashesType: SmartDashesType.enabled,
                      smartQuotesType: SmartQuotesType.enabled,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      textCapitalization: TextCapitalization.words,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      scribbleEnabled: true,
                      selectionControls: MaterialTextSelectionControls(),
                      textDirection: TextDirection.ltr,
                      textInputAction: textInputAction,
                      maxLines: maxLines,
                      minLines: 1,
                      selectionHeightStyle: BoxHeightStyle.tight,
                      selectionWidthStyle: BoxWidthStyle.tight,
                      showCursor: true,
                      onSubmitted: done,
                      onChanged: done,
                      maxLengthEnforcement:
                          MaxLengthEnforcement.truncateAfterCompositionEnds,
                    ),
                  ),
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
