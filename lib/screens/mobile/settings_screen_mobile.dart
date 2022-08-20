library mobile_screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:color_chooser/color_chooser.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:reading_diary/blocs/settings_bloc.dart';
import 'package:reading_diary/components/mobile/settings_tile_mobile.dart';
import 'package:reading_diary/main.dart';
import 'package:reading_diary/models/setting.dart' show allSettings;
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations, TranslationDelegates;

/// Mobile Version of the Settings Screen.
class SettingsScreenMobile extends StatefulWidget {
  const SettingsScreenMobile({Key? key}) : super(key: key);

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
      child: ListView(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        scrollDirection: Axis.vertical,
        children: [
          // Language Setting.
          SettingsTileMobile(
            setting: allSettings
                .where((element) => element.name == 'Language')
                .first,
            onTap: _showLanguageDialog,
          ),

          // Theme Setting
          SettingsTileMobile(
            setting:
                allSettings.where((element) => element.name == 'Theme').first,
            onTap: _showThemeDialog,
          ),

          ListTile(
            autofocus: false,
            enableFeedback: true,
            isThreeLine: false,
            title: const Text('Color Chooser'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ColorChooserScreenMobile(
                    changeColorFunction: (Color color) =>
                        _bloc!.changeColor(color),
                  ),
                ),
              );
            },
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
        ],
      ),
    );
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
        color: Colors.blue.shade800,
        backgroundBlendMode: BlendMode.src,
        shape: BoxShape.rectangle,
      ),
      position: DecorationPosition.background,
      child: Align(
        heightFactor: 2,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
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

  /// shows a Dialog with
  /// detailed Inforamtion about this App.
  void _showInformationDialog() {
    showDialog(
      context: context,
      builder: (c) {
        return const AboutDialog(
          applicationLegalese: '© Julian Schumacher 2022',
          applicationName: 'Reading Diary',
          applicationVersion: appVersion,
          applicationIcon: Icon(Icons.menu_book_rounded),
        );
      },
    );
  }
}
