library desktop_screens;

import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/blocs.dart' show HomescreenBloc;

/// The Desktop Version of the Homescreen
/// for this App.
class HomescreenDesktop extends StatefulWidget {
  const HomescreenDesktop({Key? key}) : super(key: key);

  @override
  State<HomescreenDesktop> createState() => _HomescreenDesktopState();
}

class _HomescreenDesktopState extends State<HomescreenDesktop> {
  /// The Bloc for the Homescreen.
  HomescreenBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Text('Test'),
      ),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
