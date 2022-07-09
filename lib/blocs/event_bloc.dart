library blocs;

import 'dart:async';

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:reading_diary/models/events/event.dart';

/// The Bloc that handles App wide
/// Events.
class EventBloc extends Bloc {
  /// Controlls the Events of the App.
  static StreamController<Event> stream = StreamController<Event>();

  @override
  void dispose() {
    stream.close();
  }
}
