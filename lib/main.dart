library main;

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive, HiveX;
import 'package:reading_diary/logic/navigating/routes.dart';
import 'package:reading_diary/logic/navigating/widget_router.dart';
import 'package:reading_diary/screens/shared/unknown_screen.dart';
import 'package:reading_diary/storage/storage.dart';
import 'package:reading_diary/style/themes.dart';
import 'package:reading_diary/values/translations.dart';
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations;

void main() async {
  await Hive.initFlutter();
  // TODO: check if await is needed here.
  await Storage.init();
  runApp(const ReadingDiary());
}

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
class ReadingDiary extends StatelessWidget {
  const ReadingDiary({Key? key}) : super(key: key);

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
      Routes.addEntryScreen: (_) => WidgetRouter.addEntryScreen(),
      Routes.addBookScreen: (_) => WidgetRouter.addBookScreen(),
      Routes.addWishScreen: (_) => WidgetRouter.addWishScreen(),
      Routes.settingsScreen: (_) => WidgetRouter.settingsScreen(),
      Routes.unknownscreen: (_) => WidgetRouter.unknownScreen(),
    };
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
