library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:color_chooser/color_chooser.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:helpful_extensions/helpful_extensions.dart' show ColorMapping;
import 'package:modern_themes/modern_themes.dart' show Coloring;
import 'package:reading_diary/blocs/settings_bloc.dart';
import 'package:reading_diary/components/mobile/settings_tile_mobile.dart';
import 'package:reading_diary/main.dart';
import 'package:reading_diary/models/setting.dart' show Setting;
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations, TranslationDelegates;
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

/// Enum that tells
/// the launch Function,
/// which one of the Social
/// Media Button has been pressed.
enum OpenURL {
  /// THe User wants to open the Facebook Page
  facebook,

  /// The User wants to contact the Developer via E-Mail
  mail,

  /// The User wants to open the Github Link
  code,
}

/// Mobile Version of the Settings Screen.
class SettingsScreenMobile extends StatefulWidget {
  const SettingsScreenMobile({super.key});

  @override
  State<SettingsScreenMobile> createState() => _SettingsScreenMobileState();
}

class _SettingsScreenMobileState extends State<SettingsScreenMobile> {
  /// The Bloc used for this Screen.
  SettingsBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    // Init Bloc
    _bloc = BlocParent.of(context);
    Setting.changeIconOnRuntime(context);

    return Scaffold(
      appBar: _appBar,
      body: _body,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  /// AppBar of the mobile Version
  /// of the Settings Screen.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text('Settings'.tr()),
    );
  }

  /// Body for the Settings
  /// Screen.
  Scrollbar get _body {
    return Scrollbar(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          ListView(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            dragStartBehavior: DragStartBehavior.down,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            reverse: false,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              // Language Setting.
              SettingsTileMobile(
                setting: Setting.settingForName(Setting.languageName),
                onTap: _showLanguageDialog,
              ),

              // Theme Setting
              SettingsTileMobile(
                setting: Setting.settingForName(Setting.themeName),
                onTap: _showThemeDialog,
              ),

              SettingsTileMobile(
                setting: Setting.settingForName(Setting.colorName),
                onTap: _showColorChooser,
              ),

              /// Information Tile
              ListTile(
                autofocus: false,
                enableFeedback: true,
                enabled: true,
                isThreeLine: false,
                title: Text('Information'.tr()),
                subtitle: Text('Show detailed Information about the App'.tr()),
                leading: const Icon(Icons.info_rounded),
                onTap: _showInformationDialog,
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 3),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 6.8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    textBaseline: TextBaseline.alphabetic,
                    textDirection: TextDirection.ltr,
                    verticalDirection: VerticalDirection.down,
                    children: <IconButton>[
                      IconButton(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .secondaryColor,
                        alignment: Alignment.center,
                        autofocus: false,
                        enableFeedback: true,
                        tooltip: ''.tr(),
                        onPressed: () => _contact(OpenURL.facebook),
                        icon: const Icon(Icons.facebook_rounded),
                      ),
                      IconButton(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .secondaryColor,
                        alignment: Alignment.center,
                        autofocus: false,
                        enableFeedback: true,
                        tooltip: ''.tr(),
                        onPressed: () => _contact(OpenURL.mail),
                        icon: const Icon(Icons.email_rounded),
                      ),
                      IconButton(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .secondaryColor,
                        alignment: Alignment.center,
                        autofocus: false,
                        enableFeedback: true,
                        tooltip: ''.tr(),
                        onPressed: () => _contact(OpenURL.code),
                        icon: const Icon(Icons.code_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '© Julian Schumacher \n2023',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Opens a link depending on
  /// the specified [what] Argument,
  /// that tells this Function
  /// which Button has been pressed.
  void _contact(OpenURL what) async {
    final Uri uri;
    switch (what) {
      case OpenURL.facebook:
        uri = Uri.parse('https://www.facebook.com/jules.mediadesign');
        break;
      case OpenURL.mail:
        uri = Uri.parse('mailto:support@julianschumacher.dev');
        break;
      case OpenURL.code:
        uri = Uri.parse('https://github.com/Julessh05/Reading-Diary');
        break;
    }
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  /// Function called to show
  /// the Language Chooser Dialog.
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Choose a Language'.tr()),
          children: <SimpleDialogOption>[
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeLanguage(TranslationLocales.english);
                Navigator.pop(context);
              }),
              child: _getDialogTile('English'.tr()),
            ),
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeLanguage(TranslationLocales.german);
                Navigator.pop(context);
              }),
              child: _getDialogTile('German'.tr()),
            ),
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeLanguage(TranslationLocales.french);
                Navigator.pop(context);
              }),
              child: _getDialogTile('French'.tr()),
            ),
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeLanguage(TranslationLocales.spanish);
                Navigator.pop(context);
              }),
              child: _getDialogTile('Spanish'.tr()),
            ),
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeLanguage(TranslationLocales.portuguese);
                Navigator.pop(context);
              }),
              child: _getDialogTile('Portuguese'.tr()),
            ),
          ],
        );
      },
    );
  }

  /// The Tile that represents a single
  /// Option in the Dialogs shown on the
  /// Settings Screen.
  Widget _getDialogTile(String text) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: Coloring.mainColor,
        backgroundBlendMode: BlendMode.src,
        shape: BoxShape.rectangle,
      ),
      position: DecorationPosition.background,
      child: Align(
        heightFactor: 2,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: Coloring.secondaryColor),
        ),
      ),
    );
  }

  /// Shows the Dialog with whih
  /// the User can choose the
  /// Theme Mode of this App.
  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Choose a Theme Mode'.tr()),
          children: <SimpleDialogOption>[
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeThememode(ThemeMode.system);
                Navigator.pop(context);
              }),
              child: _getDialogTile('System'.tr()),
            ),
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeThememode(ThemeMode.light);
                Navigator.pop(context);
              }),
              child: _getDialogTile('Light'.tr()),
            ),
            SimpleDialogOption(
              onPressed: () => setState(() {
                _bloc!.changeThememode(ThemeMode.dark);
                Navigator.pop(context);
              }),
              child: _getDialogTile('Dark'.tr()),
            ),
          ],
        );
      },
    );
  }

  /// Opens the Color Chooser
  /// Screen depending on the OS.
  void _showColorChooser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) {
        return ColorChooserScreen(
          title: 'Choose a Color'.tr(),
          changeColorFunction: (c) => _bloc!.changeColor(c),
        );
      }),
    );
  }

  /// shows a Dialog with
  /// detailed Inforamtion about this App.
  void _showInformationDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return const AboutDialog(
          applicationLegalese: '© Julian Schumacher 2023',
          applicationName: 'Reading Diary',
          applicationVersion: appVersion,
          applicationIcon: Icon(Icons.menu_book_rounded),
        );
      },
    );
  }
}
