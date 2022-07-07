library values;

import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show StandardTranslations, TranslationLocales;

/// All the actual Translations for this App.
/// Is private.
/// Use the corresponding getter [translations]
final Map<String, Map<Locale, String>> _translations = {
  'Current Page': {
    TranslationLocales.german: 'Aktuelle Seite',
  },
  'Add Book': {
    TranslationLocales.german: 'Buch hinzufügen',
  },
  'Title': {
    TranslationLocales.german: 'Titel',
  },
  'Author': {
    TranslationLocales.german: 'Autor',
  },
  'Pages': {
    TranslationLocales.german: 'Seiten',
  },
  'Notes': {
    TranslationLocales.german: 'Notizen',
  },
  'Price': {
    TranslationLocales.german: 'Preis',
  },
  'Error creating Book': {
    TranslationLocales.german: 'Fehler beim erstellen des Buchs',
  },
  'Exactly this Book does already exists': {
    TranslationLocales.german: 'Genau dieses Buch existiert bereits',
  },
  'Please use that Book or add another one': {
    TranslationLocales.german:
        'Bitte benutze dieses Buch oder füge ein neues hinzu.',
  },
  'Add new Entry': {
    TranslationLocales.german: 'Eintrag hinzufügen',
  },
  'Content': {
    TranslationLocales.german: 'Inhalt',
  },
  'Date': {
    TranslationLocales.german: 'Datum',
  },
  'Book': {
    TranslationLocales.german: 'Buch',
  },
  'Pages read': {
    TranslationLocales.german: 'Gelesene Seiten',
  },
  'None': {
    TranslationLocales.german: 'Keines',
  },
  'Start Page': {
    TranslationLocales.german: 'Startseite',
  },
  'End Page': {
    TranslationLocales.german: 'Endseite',
  },
  'Pick a Date': {
    TranslationLocales.german: 'Wähle eine Datum',
  },
  'Current Date': {
    TranslationLocales.german: 'Aktuelles Datum',
  },
  'Tap to change': {
    TranslationLocales.german: 'Zum Bearbeiten tippen',
  },
  'Add a Wish': {
    TranslationLocales.german: 'Wunsch hinzufügen',
  },
  'Add Entry': {
    TranslationLocales.german: 'Eintrag hinzufügen',
  },
  'Add Wish': {
    TranslationLocales.german: 'Wunsch hinzufügen',
  },
  'Home': {
    TranslationLocales.german: 'Start',
  },
  'Search your Entries': {
    TranslationLocales.german: 'Durchsuche deine Einträge',
  },
  'Diary': {
    TranslationLocales.german: 'Tagebuch',
  },
  'Books': {
    TranslationLocales.german: 'Bücher',
  },
  'Search your Wishlist': {
    TranslationLocales.german: 'Durchsuche deine Wunschliste',
  },
  'Wishlist': {
    TranslationLocales.german: 'Wunschliste',
  },
  'Home and Explore': {
    TranslationLocales.german: 'Start und Entdecken',
  },
  'The Actual Diary': {
    TranslationLocales.german: 'Das tatsächliche Tagebuch',
  },
  'Your Wishlist of Books': {
    TranslationLocales.german: 'Deine Wunschliste an Büchern',
  },
  'All your Books': {
    TranslationLocales.german: 'Alle deine Bücher',
  },
  'Keyword': {
    TranslationLocales.german: 'Stichwort',
  },
  'Filter': {
    TranslationLocales.german: 'Filter',
  },
  'Search your Wishes': {
    TranslationLocales.german: 'Dursuche deine Wünsche',
  },
  'Search your Books': {
    TranslationLocales.german: 'Durchsuche deine Bücher',
  },
  'Something went wrong, we couldn\'t find the screen you where looking for': {
    TranslationLocales.german:
        'Etwas ist falsch gelaufen, wir konnten den Bildschirm den du suchst nicht finden',
  },
  'Settings': {
    TranslationLocales.german: 'Einstellungen',
  },
};

/// Getter for the Translations.
/// Adds the Standard Translations to the
/// Custom Translations.
Map<String, Map<Locale, String>> get translations {
  _translations.addAll(StandardTranslations.actions);
  _translations.addAll(StandardTranslations.error);

  return _translations;
}
