library mobile_components;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;

/// A Container with an input field and
/// the Option to replace that input field
/// with your own Widget [child]
class AddModelContainerMobile extends StatelessWidget {
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
    this.initialValue,
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
  /// TextFormField
  final TextInputType keyboardType;

  /// The Text Input Action, determining what
  /// should be done after filling in the
  /// TextFormField
  final TextInputAction textInputAction;

  /// The max Lines for the TextFormField
  final int? maxLines;

  /// The Function beeing called, when the
  /// User has finished entering
  /// his Text
  final void Function(String)? done;

  /// An Optional child Widget,
  /// if you don't need a TextFormField
  final Widget? child;

  /// If you want the Card
  /// to be bigger than normal,
  /// set this to true.
  final bool big;

  /// Whether this is a full Screen TextFormField or not.
  final bool multiline;

  /// The Opacity of this Containers Card.
  final double opacity;

  /// The Icon displayed at the end of
  /// the TextFormField
  final Icon? suffixIcon;

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: () {
        if (big) {
          return MediaQuery.of(context).size.height / 3.3;
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
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(opacity),
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
              child ??
                  SizedBox(
                    height: multiline
                        ? MediaQuery.of(context).size.height / 1.2
                        : 80,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: initialValue,
                      autocorrect: true,
                      autofocus: autofocus,
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
                      textCapitalization: TextCapitalization.sentences,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      selectionControls: MaterialTextSelectionControls(),
                      textDirection: TextDirection.ltr,
                      textInputAction: textInputAction,
                      maxLines: multiline ? 99999 : maxLines,
                      minLines: multiline
                          ? MediaQuery.of(context).size.height ~/ 20
                          : 1,
                      showCursor: true,
                      onChanged: done,
                      maxLengthEnforcement:
                          MaxLengthEnforcement.truncateAfterCompositionEnds,
                      decoration: InputDecoration(
                        suffixIcon: suffixIcon,
                      ),
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
