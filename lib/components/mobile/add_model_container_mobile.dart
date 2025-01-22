library mobile_components;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:helpful_extensions/helpful_extensions.dart';

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
    this.initialValue,
    this.textCapitalization = TextCapitalization.sentences,
    this.selectOnTap = false,
    this.iconButton,
    super.key,
  })  : assert(
          child == null && done != null || child != null,
          'If you don\'t speficy a child, you have to pass a done Function',
        ),
        assert(
          big == true && child != null || big == false,
          'You can only have a bigger container, when you specify your own child',
        );

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

  /// The initial Value for this
  /// Widget's TextField
  final String? initialValue;

  /// The Text Capitalization for this
  /// Widget's Text Field.
  final TextCapitalization textCapitalization;

  /// Whether the initial Value in
  /// this Text Field should be selected
  /// when the User taps on the
  /// Text Field.
  final bool selectOnTap;

  /// An Icon button in the right
  /// upper corner of this Widget.
  final IconButton? iconButton;

  @override
  State<StatefulWidget> createState() => _AddModelContainerMobileState();
}

class _AddModelContainerMobileState extends State<AddModelContainerMobile> {
  /// The Controller for this Widgets TextField.
  final TextEditingController _controller = TextEditingController();

  final FocusNode _focus = FocusNode();

  bool _firstFocus = true;

  @override
  void initState() {
    if (widget.selectOnTap) {
      _focus.addListener(() {
        if (_firstFocus) {
          if (_focus.hasFocus) {
            _controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controller.text.length,
            );
            _firstFocus = false;
          }
        } else {
          return;
        }
      });
    }

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /*
      height: () {
        const double minHeight = 175;
        final double height;
        if (widget.big) {
          height = MediaQuery.of(context).size.height / 3.3;
        } else if (widget.multiline) {
          height = MediaQuery.of(context).size.height;
        } else {
          height = MediaQuery.of(context).size.height / 4.5;
        }
        return height < minHeight ? minHeight : height;
      }(),
       */
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
              widget.iconButton != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      textBaseline: TextBaseline.alphabetic,
                      textDirection: TextDirection.ltr,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        const Spacer(flex: 2),
                        Text(widget.name, style: _tStyle),
                        const Spacer(flex: 1),
                        widget.iconButton != null
                            ? IconButton(
                                alignment: widget.iconButton!.alignment,
                                autofocus: widget.iconButton!.autofocus,
                                constraints: widget.iconButton!.constraints,
                                enableFeedback: true,
                                tooltip: widget.iconButton!.tooltip,
                                style: widget.iconButton!.style,
                                icon: widget.iconButton!.icon,
                                onPressed: () =>
                                    widget.iconButton!.onPressed!(),
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .secondaryColor,
                              )
                            : Container(),
                      ],
                    )
                  : Text(widget.name, style: _tStyle),
              const SizedBox(height: 18),
              widget.child ??
                  SizedBox(
                    height: widget.multiline
                        ? MediaQuery.of(context).size.height / 1.2
                        : 80,
                    child: TextField(
                      focusNode: _focus,
                      autocorrect: true,
                      controller: _controller,
                      autofocus: widget.autofocus,
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
                      textCapitalization: widget.textCapitalization,
                      selectionControls: MaterialTextSelectionControls(),
                      textDirection: TextDirection.ltr,
                      textInputAction: widget.textInputAction,
                      maxLines: widget.multiline ? 99999 : widget.maxLines,
                      minLines: widget.multiline
                          ? MediaQuery.of(context).size.height ~/ 20
                          : 1,
                      showCursor: true,
                      onChanged: widget.done,
                      onSubmitted: widget.done,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      dragStartBehavior: DragStartBehavior.down,
                      obscuringCharacter: '*',
                      scribbleEnabled: true,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
