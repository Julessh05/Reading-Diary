library mobile_components;

import 'package:flutter/material.dart';

class StatisticContainerMobile extends StatelessWidget {
  const StatisticContainerMobile({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final mqs = MediaQuery.of(context).size;
    final size = Size(mqs.width, mqs.height);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
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
              gradient: const LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.purple,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                stops: [0.1, 1.2],
                tileMode: TileMode.mirror,
                transform: GradientRotation(20),
              ),
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
            ),
            position: DecorationPosition.background,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  // TODO: change
                  // left: 25
                  left: 0,
                  bottom: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  textBaseline: TextBaseline.alphabetic,
                  textDirection: TextDirection.ltr,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Text(content, style: _ctStyle, textAlign: TextAlign.center),
                    Text(title, style: _tStyle, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get _tStyle {
    return const TextStyle(
      fontSize: 30,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get _ctStyle {
    return const TextStyle(
      fontSize: 17,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    );
  }
}
