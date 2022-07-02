library main;

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_diary/screens/shared/unknown_screen.dart';
import 'package:reading_diary/storage/storage.dart';
import 'package:reading_diary/values/translations.dart';
import 'package:string_translate/string_translate.dart'
    show Translation, TranslationDelegates, TranslationLocales;

void main() async {
  await Hive.initFlutter();
  // TODO: check if await is needed here.
  Storage.init();
  runApp(const ReadingDiary());
}

class ReadingDiary extends StatelessWidget {
  const ReadingDiary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Translation.init(
      supportedLocales: {},
      defaultLocale: TranslationLocales.english,
      translations: translations,
    );
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
      initialRoute: '/',
      onUnknownRoute: (settings) => _onUnkownRoute(settings),

      // Themes,
    );
  }

  /// Most routes for this App.
  /// Only contains Routes that don't have
  /// a paramter to pass.
  Map<String, Widget Function(BuildContext)> get _routes {
    return {};
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
