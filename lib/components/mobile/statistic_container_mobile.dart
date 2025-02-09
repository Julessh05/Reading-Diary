import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:helpful_extensions/helpful_extensions.dart' show ColorMapping;
import 'package:modern_themes/modern_themes.dart' show Coloring;
import 'package:reading_diary/models/statistic.dart';

class StatisticContainerMobile extends StatelessWidget {
  const StatisticContainerMobile({
    required this.statistic,
    this.onTap,
    super.key,
  });

  /// The Statistic this Container Displays
  final Statistic statistic;

  /// The Function called, when
  /// the User taps on this Container.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final mqs = MediaQuery.of(context).size;
    final size = Size(mqs.width, mqs.height);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        dragStartBehavior: DragStartBehavior.down,
        onTap: onTap,
        child: SizedBox(
          width: size.width / 1.2,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            borderOnForeground: false,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.transparent,
            child: DecoratedBox(
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.src,
                gradient: LinearGradient(
                  colors: [
                    Coloring.mainColor,
                    Coloring.mainColor.gradientColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  stops: const [.1, .8],
                  tileMode: TileMode.mirror,
                  transform: const GradientRotation(20),
                ),
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
              ),
              position: DecorationPosition.background,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    bottom: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    textBaseline: TextBaseline.alphabetic,
                    textDirection: TextDirection.ltr,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Text(
                        statistic.data.isNotEmpty
                            ? statistic.data
                            : statistic.book!.title,
                        style: _ctStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        statistic.title,
                        style: _tStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The Text Style for the Title
  TextStyle get _tStyle {
    return TextStyle(
      fontSize: 25,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: Coloring.secondaryColor,
    );
  }

  /// The Text Style for the Content.
  TextStyle get _ctStyle {
    return TextStyle(
      fontSize: 17,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: Coloring.secondaryColor,
    );
  }
}
