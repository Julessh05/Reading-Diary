library main;

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive, HiveX;
import 'package:modern_themes/modern_themes.dart';
import 'package:reading_diary/blocs/event_bloc.dart';
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/logic/navigating/widget_router.dart';
import 'package:reading_diary/models/events/event.dart';
import 'package:reading_diary/models/events/reload_event.dart';
import 'package:reading_diary/screens/shared/unknown_screen.dart';
import 'package:reading_diary/storage/storage.dart';
import 'package:reading_diary/values/translations.dart';
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations;

void main() async {
  await Hive.initFlutter();
  await Storage.init();
  runApp(const ReadingDiary());
}

/// The current Version of the App
/// as a String.
const String appVersion = '3.0.0';

/// Determines the Platform this Apps is running on.
/// Also sets the [WidgetRouter.isDesktop] Variable.
void _isDesktop() {
  const desktopOS = <String>{'macos', 'windows', 'linux'};
  if (desktopOS.contains(Platform.operatingSystem)) {
    WidgetRouter.isDesktop = true;
  } else {
    WidgetRouter.isDesktop = false;
  }
}

/// The Main widget for this App.
/// Returns the Material App.
class ReadingDiary extends StatefulWidget {
  const ReadingDiary({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReadingDiaryState();
}

class _ReadingDiaryState extends State<ReadingDiary> {
  @override
  void initState() {
    EventBloc.stream.stream.listen((event) {
      _handleEvents(event);
    });
    super.initState();
  }

  void _handleEvents(Event event) {
    if (event is ReloadEvent) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Chack for Desktop and set
    // corresponding Values
    _isDesktop();

    // Init Translation Package
    Translation.init(
      supportedLocales: TranslationLocales.all,
      defaultLocale: TranslationLocales.english,
      translations: translations,
    );

    /// The Title of the App
    const String title = 'Reading Diary';

    return MaterialApp(
      /* Developer Section */
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      debugShowCheckedModeBanner: true,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      debugShowMaterialGrid: false,

      /* App Section */

      // General
      scrollBehavior: const MaterialScrollBehavior(),
      title: title,
      onGenerateTitle: (_) => title,
      restorationScopeId: '$title restauration scope ID',
      useInheritedMediaQuery: false,

      // Locales
      locale: Translation.activeLocale,
      supportedLocales: Translation.supportedLocales,
      localizationsDelegates: TranslationDelegates.localizationDelegates,

      // Keys
      key: const GlobalObjectKey(title),
      navigatorKey: const GlobalObjectKey<NavigatorState>(
        '$title Navigator Key',
      ),
      scaffoldMessengerKey: const GlobalObjectKey<ScaffoldMessengerState>(
        '$title Scaffold Messenger Key',
      ),

      // Routes
      routes: _routes,
      initialRoute: Routes.homescreen,
      onGenerateRoute: (settings) => _onGenerateRoute(settings),
      onUnknownRoute: (settings) => _onUnkownRoute(settings),

      // Themes,
      themeMode: Themes.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      highContrastTheme: Themes.highContrastLightTheme,
      highContrastDarkTheme: Themes.highContrastDarkTheme,
    );
  }

  /// Most routes for this App.
  /// Only contains Routes that don't have
  /// a paramter to pass.
  Map<String, Widget Function(BuildContext)> get _routes {
    return {
      Routes.homescreen: (_) => WidgetRouter.homescreen(),
      Routes.settingsScreen: (_) => WidgetRouter.settingsScreen(),
      Routes.unknownscreen: (_) => WidgetRouter.unknownScreen(),
    };
  }

  /// Function called when the App calls
  /// a Screen that needs any parameters.
  MaterialPageRoute? _onGenerateRoute(RouteSettings settings) {
    // Entry Details Screen
    if (settings.name == Routes.entryDetailsScreen) {
      return MaterialPageRoute(
        builder: (_) {
          return WidgetRouter.entryDetailsScreen(settings: settings);
        },
      );
    } else if (settings.name == Routes.bookDetailsScreen) {
      return MaterialPageRoute(
        builder: (_) {
          return WidgetRouter.bookDetailsScreen(settings: settings);
        },
      );
    } else if (settings.name == Routes.wishDetailsScreen) {
      return MaterialPageRoute(
        builder: (_) {
          return WidgetRouter.wishDetailsScreen(settings: settings);
        },
      );
    } else if (settings.name == Routes.addEntryScreen) {
      return MaterialPageRoute(
        builder: (_) {
          return WidgetRouter.addEntryScreen(settings: settings);
        },
      );
    } else if (settings.name == Routes.addBookScreen) {
      return MaterialPageRoute(
        builder: (_) {
          return WidgetRouter.addBookScreen(settings: settings);
        },
      );
    } else if (settings.name == Routes.addWishScreen) {
      return MaterialPageRoute(
        builder: (_) {
          return WidgetRouter.addWishScreen(settings: settings);
        },
      );
    } else if (settings.name == Routes.searchResultsScreen) {
      return MaterialPageRoute(
        builder: (_) {
          return WidgetRouter.searchResultsScreen(settings: settings);
        },
      );
    } else {
      return null;
    }
  }

  /// Returnst the Unknown Screen.
  /// Called everytime, the App did not find a Route
  /// to navigate to.
  MaterialPageRoute<UnknwonScreen> _onUnkownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const UnknwonScreen(),
    );
  }
}
