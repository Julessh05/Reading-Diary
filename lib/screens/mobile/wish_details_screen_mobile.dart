library mobile_screens;

import 'package:flutter/material.dart';
import 'package:reading_diary/models/wish.dart' show Wish;

/// Represents a single Wish of the User
/// and shows you all information.
class WishDetailsScreenMobile extends StatefulWidget {
  const WishDetailsScreenMobile({
    required this.wish,
    Key? key,
  }) : super(key: key);

  /// The Wish this Screen
  /// represents.
  final Wish wish;

  @override
  State<WishDetailsScreenMobile> createState() =>
      _WishDetailsScreenMobileState();
}

class _WishDetailsScreenMobileState extends State<WishDetailsScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
