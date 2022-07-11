library mobile_components;

import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;

/// A Container with an input field and
/// the Option to replace that input field
/// with your own Widget [child]
class AddModelContainerMobile extends StatefulWidget {
  const AddModelContainerMobile({
    required this.name,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.done,
    this.child,
    this.big = false,
    this.multiline = false,
    this.opacity = 1,
    this.suffixIcon,
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

  /// The Name of the Input Field.
  /// Shown on top of the Field
  final String name;

  /// Whether or not the Field should be targeted
  /// by autofocus
  final bool autofocus;

  /// The Keyboard Type for the
  /// TextField
  final TextInputType keyboardType;

  /// The Text Input Action, determining what
  /// should be done after filling in the
  /// TextField
  final TextInputAction textInputAction;

  /// The max Lines for the TextField
  final int? maxLines;

  /// The Function beeing called, when the
  /// User has finished entering
  /// his Text
  final void Function(String)? done;

  /// An Optional child Widget,
  /// if you don't need a TextField
  final Widget? child;

  /// If you want the Card
  /// to be bigger than normal,
  /// set this to true.
  final bool big;

  /// Whether this is a full Screen Textfield or not.
  final bool multiline;

  /// The Opacity of this Containers Card.
  final double opacity;

  /// The Icon displayed at the end of
  /// the TextField
  final Icon? suffixIcon;

  @override
  State<AddModelContainerMobile> createState() =>
      _AddModelContainerMobileState();
}

class _AddModelContainerMobileState extends State<AddModelContainerMobile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: () {
        if (widget.big) {
          return MediaQuery.of(context).size.height / 3.3;
        } else if (widget.multiline) {
          return MediaQuery.of(context).size.height;
        } else {
          return MediaQuery.of(context).size.height / 4.5;
        }
      }(),
      child: Card(
        elevation: 8,
        borderOnForeground: false,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context)
            .scaffoldBackgroundColor
            .withOpacity(widget.opacity),
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
              Text(widget.name, style: _tStyle),
              const SizedBox(height: 18),
              widget.child ??
                  SizedBox(
                    height: widget.multiline
                        ? MediaQuery.of(context).size.height / 1.2
                        : 80,
                    child: TextField(
                      autocorrect: true,
                      autofocus: widget.autofocus,
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
                      keyboardType: widget.keyboardType,
                      readOnly: false,
                      smartDashesType: SmartDashesType.enabled,
                      smartQuotesType: SmartQuotesType.enabled,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      textCapitalization: TextCapitalization.sentences,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      scribbleEnabled: true,
                      selectionControls: MaterialTextSelectionControls(),
                      textDirection: TextDirection.ltr,
                      textInputAction: widget.textInputAction,
                      maxLines: widget.multiline ? 99999 : widget.maxLines,
                      minLines: widget.multiline
                          ? MediaQuery.of(context).size.height ~/ 20
                          : 1,
                      selectionHeightStyle: BoxHeightStyle.tight,
                      selectionWidthStyle: BoxWidthStyle.tight,
                      showCursor: true,
                      onSubmitted: widget.done,
                      onChanged: widget.done,
                      maxLengthEnforcement:
                          MaxLengthEnforcement.truncateAfterCompositionEnds,
                      decoration: InputDecoration(
                        suffixIcon: widget.suffixIcon,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  /// Text Style for the [widget.name]
  TextStyle get _tStyle {
    return const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
  }
}
