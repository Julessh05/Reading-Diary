library values;

import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show StandardTranslations, TranslationLocales;

/// All the actual Translations for this App.
/// Is private.
/// Use the corresponding getter [translations]
final Map<String, Map<Locale, String>> _translations = {
  'Current Page:': {
    TranslationLocales.german: 'Aktuelle Seite:',
    TranslationLocales.french: 'Page actuelle:',
    TranslationLocales.spanish: 'Página actual:',
    TranslationLocales.portuguese: 'Pagina atual:',
  },
  'Current Page': {
    TranslationLocales.german: 'Aktuelle Seite',
    TranslationLocales.french: 'Page actuelle',
    TranslationLocales.spanish: 'Página actual',
    TranslationLocales.portuguese: 'Pagina atual',
  },
  'Add Book': {
    TranslationLocales.german: 'Buch hinzufügen',
    TranslationLocales.french: 'Ajouter un livre',
    TranslationLocales.spanish: 'Añadir libro',
    TranslationLocales.portuguese: 'Adicionar livro',
  },
  'Title': {
    TranslationLocales.german: 'Titel',
    TranslationLocales.french: 'Titre',
    TranslationLocales.spanish: 'Título',
    TranslationLocales.portuguese: 'Título',
  },
  'Author': {
    TranslationLocales.german: 'Autor',
    TranslationLocales.french: 'Auteur',
    TranslationLocales.spanish: 'Autor',
    TranslationLocales.portuguese: 'Autor',
  },
  'Pages': {
    TranslationLocales.german: 'Seiten',
    TranslationLocales.french: 'pages',
    TranslationLocales.spanish: 'Paginas',
    TranslationLocales.portuguese: 'Páginas',
  },
  'Notes': {
    TranslationLocales.german: 'Notizen',
    TranslationLocales.french: 'Noter',
    TranslationLocales.spanish: 'Notas',
    TranslationLocales.portuguese: 'Notas',
  },
  'Price': {
    TranslationLocales.german: 'Preis',
    TranslationLocales.french: 'Prix',
    TranslationLocales.spanish: 'Valor',
    TranslationLocales.portuguese: 'Preço',
  },
  'Error creating Book': {
    TranslationLocales.german: 'Fehler beim erstellen des Buchs',
    TranslationLocales.french: 'Erreur lors de la création du livre',
    TranslationLocales.spanish: 'Error al crear el libro',
    TranslationLocales.portuguese: 'Erro ao criar o livro',
  },
  'Exactly this Book does already exists': {
    TranslationLocales.german: 'Genau dieses Buch existiert bereits',
    TranslationLocales.french: 'Exactement ce livre existe déjà',
    TranslationLocales.spanish: 'Exactamente este Libro ya existe',
    TranslationLocales.portuguese: 'Exatamente este livro já existe',
  },
  'Please use that Book or add another one': {
    TranslationLocales.german:
        'Bitte benutze dieses Buch oder füge ein neues hinzu.',
    TranslationLocales.french:
        'Veuillez utiliser ce livre ou en ajouter un autre',
    TranslationLocales.spanish: 'Utilice ese libro o agregue otro',
    TranslationLocales.portuguese:
        'Por favor, use esse livro ou adicione outro',
  },
  'Add new Entry': {
    TranslationLocales.german: 'Eintrag hinzufügen',
    TranslationLocales.french: 'Ajouter une nouvelle entrée',
    TranslationLocales.spanish: 'Agregar nueva entrada',
    TranslationLocales.portuguese: 'Adicionar nova entrada',
  },
  'Content': {
    TranslationLocales.german: 'Inhalt',
    TranslationLocales.french: 'Contenu',
    TranslationLocales.spanish: 'Contenido',
    TranslationLocales.portuguese: 'Contente',
  },
  'Date': {
    TranslationLocales.german: 'Datum',
    TranslationLocales.french: 'Date',
    TranslationLocales.spanish: 'Fecha',
    TranslationLocales.portuguese: 'Encontro',
  },
  'Book': {
    TranslationLocales.german: 'Buch',
    TranslationLocales.french: 'Livre',
    TranslationLocales.spanish: 'Libro',
    TranslationLocales.portuguese: 'Livro',
  },
  'Pages read': {
    TranslationLocales.german: 'Gelesene Seiten',
    TranslationLocales.french: 'Pages lues',
    TranslationLocales.spanish: 'páginas leídas',
    TranslationLocales.portuguese: 'Páginas lidas',
  },
  'None': {
    TranslationLocales.german: 'Keines',
    TranslationLocales.french: 'Aucune',
    TranslationLocales.spanish: 'Ninguno',
    TranslationLocales.portuguese: 'Nenhum',
  },
  'Start Page': {
    TranslationLocales.german: 'Startseite',
    TranslationLocales.french: 'Page de démarrage',
    TranslationLocales.spanish: 'Página de inicio',
    TranslationLocales.portuguese: 'Página inicial',
  },
  'End Page': {
    TranslationLocales.german: 'Endseite',
    TranslationLocales.french: 'Page de fin',
    TranslationLocales.spanish: 'Página final',
    TranslationLocales.portuguese: 'Página final',
  },
  'Pick a Date': {
    TranslationLocales.german: 'Wähle eine Datum',
    TranslationLocales.french: 'Choisis une date',
    TranslationLocales.spanish: 'Selecciona una fecha',
    TranslationLocales.portuguese: 'Escolha uma data',
  },
  'Current Date': {
    TranslationLocales.german: 'Aktuelles Datum',
    TranslationLocales.french: 'Données actuelles',
    TranslationLocales.spanish: 'Fecha actual',
    TranslationLocales.portuguese: 'Data atual',
  },
  'Tap to change': {
    TranslationLocales.german: 'Zum Bearbeiten tippen',
    TranslationLocales.french: 'Appuyez pour changer',
    TranslationLocales.spanish: 'Toca para cambiar',
    TranslationLocales.portuguese: 'Toque para alterar',
  },
  'Add a Wish': {
    TranslationLocales.german: 'Wunsch hinzufügen',
    TranslationLocales.french: 'Ajouter un souhait',
    TranslationLocales.spanish: 'Añadir un deseo',
    TranslationLocales.portuguese: 'Adicionar um desejo',
  },
  'Add Entry': {
    TranslationLocales.german: 'Eintrag hinzufügen',
    TranslationLocales.french: 'Ajouter une entrée',
    TranslationLocales.spanish: 'Añadir entrada',
    TranslationLocales.portuguese: 'Adicionar entrada',
  },
  'Add Wish': {
    TranslationLocales.german: 'Wunsch hinzufügen',
    TranslationLocales.french: 'Ajouter un souhait',
    TranslationLocales.spanish: 'Añadir deseo',
    TranslationLocales.portuguese: 'Adicionar desejo',
  },
  'Home': {
    TranslationLocales.german: 'Start',
    TranslationLocales.french: 'Pont d\'entrée',
    TranslationLocales.spanish: 'Hogar',
    TranslationLocales.portuguese: 'Casa',
  },
  'Search your Entries': {
    TranslationLocales.german: 'Durchsuche deine Einträge',
    TranslationLocales.french: 'Rechercher vos entrées',
    TranslationLocales.spanish: 'Busca tus Entradas',
    TranslationLocales.portuguese: 'Pesquise suas entradas',
  },
  'Diary': {
    TranslationLocales.german: 'Tagebuch',
    TranslationLocales.french: 'Journal',
    TranslationLocales.spanish: 'Diario',
    TranslationLocales.portuguese: 'Diário',
  },
  'Books': {
    TranslationLocales.german: 'Bücher',
    TranslationLocales.french: 'Livres',
    TranslationLocales.spanish: 'Libros',
    TranslationLocales.portuguese: 'Livros',
  },
  'Search your Wishlist': {
    TranslationLocales.german: 'Durchsuche deine Wunschliste',
    TranslationLocales.french: 'Recherchez votre liste de souhaits',
    TranslationLocales.spanish: 'Busca tu lista de deseos',
    TranslationLocales.portuguese: 'Pesquise sua lista de desejos',
  },
  'Wishlist': {
    TranslationLocales.german: 'Wunschliste',
    TranslationLocales.french: 'Liste de souhaits',
    TranslationLocales.spanish: 'Lista de deseos',
    TranslationLocales.portuguese: 'Pesquise sua lista de desejos',
  },
  'Home and Explore': {
    TranslationLocales.german: 'Start und Entdecken',
    TranslationLocales.french: 'Accueil et Explorer',
    TranslationLocales.spanish: 'Inicio y explorar',
    TranslationLocales.portuguese: 'Página inicial e explorar',
  },
  'The Actual Diary': {
    TranslationLocales.german: 'Das tatsächliche Tagebuch',
    TranslationLocales.french: 'Le véritable journal',
    TranslationLocales.spanish: 'El diario real',
    TranslationLocales.portuguese: 'O verdadeiro diário',
  },
  'Your Wishlist of Books': {
    TranslationLocales.german: 'Deine Wunschliste an Büchern',
    TranslationLocales.french: 'Votre liste de souhaits de livres',
    TranslationLocales.spanish: 'Tu lista de deseos de libros',
    TranslationLocales.portuguese: 'Sua lista de livros',
  },
  'All your Books': {
    TranslationLocales.german: 'Alle deine Bücher',
    TranslationLocales.french: 'Tous vos livres',
    TranslationLocales.spanish: 'Todos tus libros',
    TranslationLocales.portuguese: 'Todos os seus livros',
  },
  'Keyword': {
    TranslationLocales.german: 'Stichwort',
    TranslationLocales.french: 'Mot-clé',
    TranslationLocales.spanish: 'Palabra clave',
    TranslationLocales.portuguese: 'Palavra-chave',
  },
  'Filter': {
    TranslationLocales.german: 'Filter',
    TranslationLocales.french: 'Filtre',
    TranslationLocales.spanish: 'Filtrar',
    TranslationLocales.portuguese: 'Filtro',
  },
  'Search your Wishes': {
    TranslationLocales.german: 'Dursuche deine Wünsche',
    TranslationLocales.french: 'Recherchez vos souhaits',
    TranslationLocales.spanish: 'Busca tus deseos',
    TranslationLocales.portuguese: 'Pesquise seus desejos',
  },
  'Search your Books': {
    TranslationLocales.german: 'Durchsuche deine Bücher',
    TranslationLocales.french: 'Rechercher vos livres',
    TranslationLocales.spanish: 'Busca tus libros',
    TranslationLocales.portuguese: 'Pesquise seus livros',
  },
  'Something went wrong, we couldn\'t find the screen you where looking for': {
    TranslationLocales.german:
        'Etwas ist falsch gelaufen, wir konnten den Bildschirm den du suchst nicht finden',
    TranslationLocales.french:
        'Une erreur s\'est produite, nous n\'avons pas pu trouver l\'écran que vous recherchiez',
    TranslationLocales.spanish:
        'Algo salió mal, no pudimos encontrar la pantalla que estabas buscando',
    TranslationLocales.portuguese:
        'Algo deu errado, não conseguimos encontrar a tela que você estava procurando',
  },
  'Settings': {
    TranslationLocales.german: 'Einstellungen',
    TranslationLocales.french: 'Réglages',
    TranslationLocales.spanish: 'Ajustes',
    TranslationLocales.portuguese: 'Definições',
  },
  'Language': {
    TranslationLocales.german: 'Sprache',
    TranslationLocales.french: 'Langue',
    TranslationLocales.spanish: 'Idioma',
    TranslationLocales.portuguese: 'Linguagem',
  },
  'Set the Language of your App.': {
    TranslationLocales.german: 'Lege die Sprache deiner App fest.',
    TranslationLocales.french: 'Définir la langue de votre application',
    TranslationLocales.spanish: 'Establece el idioma de tu aplicación',
    TranslationLocales.portuguese: 'Defina o idioma do seu aplicativo',
  },
  'Theme': {
    TranslationLocales.german: 'Thema',
    TranslationLocales.french: 'Thème',
    TranslationLocales.spanish: 'Tema',
    TranslationLocales.portuguese: 'Tema',
  },
  'Set your Personal Style.': {
    TranslationLocales.german: 'Lege deinen persönlichen Stil fest.',
    TranslationLocales.french: 'Définissez votre style personnel',
    TranslationLocales.spanish: 'Establece tu estilo personal',
    TranslationLocales.portuguese: 'Defina seu estilo pessoal',
  },
  'Choose a Language': {
    TranslationLocales.german: 'Wähle eine Sprache',
    TranslationLocales.french: 'Choisissez une langue',
    TranslationLocales.spanish: 'Elija un idioma',
    TranslationLocales.portuguese: 'Escolha um idioma',
  },
  'Choose a Theme Mode': {
    TranslationLocales.german: 'Wähle einen Themen Modus',
    TranslationLocales.french: 'Choisissez un mode thématique',
    TranslationLocales.spanish: 'Elija un modo de tema',
    TranslationLocales.portuguese: 'Escolha um modo de tema',
  },
  'System': {
    TranslationLocales.german: 'System',
    TranslationLocales.french: 'Système',
    TranslationLocales.spanish: 'Sistema',
    TranslationLocales.portuguese: 'Sistema',
  },
  'Light': {
    TranslationLocales.german: 'Hell',
    TranslationLocales.french: 'Lumière',
    TranslationLocales.spanish: 'Ligero',
    TranslationLocales.portuguese: 'Leve',
  },
  'Dark': {
    TranslationLocales.german: 'Dunkel',
    TranslationLocales.french: 'Sombre',
    TranslationLocales.spanish: 'Oscuro',
    TranslationLocales.portuguese: 'Escuro',
  },
  'You\'ve got no Entries yet.': {
    TranslationLocales.german: 'Du hast bisher noch keine Einträge.',
    TranslationLocales.french: 'Vous n\'avez pas encore d\'entrées.',
    TranslationLocales.spanish: 'Aún no tienes Entradas.',
    TranslationLocales.portuguese: 'Você ainda não tem entradas.',
  },
  'You\'ve got no Books yet.': {
    TranslationLocales.german: 'Du hast bisher noch keine Bücher.',
    TranslationLocales.french: 'Vous n\'avez pas encore de livres.',
    TranslationLocales.spanish: 'Aún no tienes libros.',
    TranslationLocales.portuguese: 'Você ainda não tem Livros.',
  },
  'You\'ve got no Wishes yet.': {
    TranslationLocales.german: 'Du hast bisher noch keine Wünsche',
    TranslationLocales.french: 'Vous n\'avez pas encore de souhaits.',
    TranslationLocales.spanish: 'Aún no tienes deseos.',
    TranslationLocales.portuguese: 'Você ainda não tem desejos.',
  },
  'Add one': {
    TranslationLocales.german: 'Hinzufügen',
    TranslationLocales.french: 'Ajoute un',
    TranslationLocales.spanish: 'Agrega uno',
    TranslationLocales.portuguese: 'Adicione um',
  },
  'Not specified': {
    TranslationLocales.german: 'Nicht angegeben',
    TranslationLocales.french: 'Non précisé',
    TranslationLocales.spanish: 'No especificado',
    TranslationLocales.portuguese: 'Não especificado',
  },
  'No Notes': {
    TranslationLocales.german: 'Keine Notizen',
    TranslationLocales.french: 'Aucune note',
    TranslationLocales.spanish: 'Sin notas',
    TranslationLocales.portuguese: 'Sem notas',
  },
  'Edit Entry': {
    TranslationLocales.german: 'Buch bearbeiten',
    TranslationLocales.french: 'Modifier le livre',
    TranslationLocales.spanish: 'Editar libro',
    TranslationLocales.portuguese: 'Editar livro',
  },
  'Edit Book': {
    TranslationLocales.german: 'Buch bearbeiten',
    TranslationLocales.french: 'Modifier le livre',
    TranslationLocales.spanish: 'Editar libro',
    TranslationLocales.portuguese: 'Editar livro',
  },
  'Edit Wish': {
    TranslationLocales.german: 'Wunsch bearbeten',
    TranslationLocales.french: 'Modifier le souhait',
    TranslationLocales.spanish: 'Editar deseo',
    TranslationLocales.portuguese: 'Editar desejo',
  },
  'Choose a Book': {
    TranslationLocales.german: 'Wähle ein Buch',
    TranslationLocales.french: 'Choisissez un livre',
    TranslationLocales.spanish: 'Escoge un libro',
    TranslationLocales.portuguese: 'Escolha um livro',
  },
  'Nothing with this Keyword found': {
    TranslationLocales.german: 'Nichts mit diesem Stichwort gefunden',
    TranslationLocales.french: 'Rien trouvé avec ce mot-clé',
    TranslationLocales.spanish: 'No se encontró nada con esta palabra clave',
    TranslationLocales.portuguese: 'Nada encontrado com esta palavra-chave',
  },
  'URL Error': {
    TranslationLocales.german: 'URL Fehler',
    TranslationLocales.french: 'Erreur d\'URL',
    TranslationLocales.spanish: 'Error de URL',
    TranslationLocales.portuguese: 'Erro de URL',
  },
  'Contact us': {
    TranslationLocales.german: 'Kontaktiere uns',
    TranslationLocales.french: 'Contactez-nous',
    TranslationLocales.spanish: 'Contacta con nosotras',
    TranslationLocales.portuguese: 'Contate-Nos',
  },
  'Show supported URLs': {
    TranslationLocales.german: 'Unterstützte URLs',
    TranslationLocales.french: 'Afficher les URL prises en charge',
    TranslationLocales.spanish: 'Mostrar URL admitidas',
    TranslationLocales.portuguese: 'Mostrar URLs compatíveis',
  },
  'For Safety Reasons, only a few specific URL\'s are allowed.': {
    TranslationLocales.german:
        'Aus Sicherheitsgründen sind nur ein paar wenige URLs erlaubt.',
    TranslationLocales.french:
        'Pour des raisons de sécurité, seules quelques URL spécifiques sont autorisées.',
    TranslationLocales.spanish:
        'Por motivos de seguridad, solo se permiten unas pocas URL específicas.',
    TranslationLocales.portuguese:
        'Por motivos de segurança, apenas alguns URLs específicos são permitidos.',
  },
  'Please check your URL.': {
    TranslationLocales.german: 'Bitte überprüfe deine URL.',
    TranslationLocales.french: 'Veuillez vérifier votre URL.',
    TranslationLocales.spanish: 'Por favor, compruebe su URL.',
    TranslationLocales.portuguese: 'Por favor, verifique o seu URL.',
  },
  'If we made a mistake, contact us.': {
    TranslationLocales.german:
        'Wenn wir einen Fehler gemacht habe, kontaktiere uns.',
    TranslationLocales.french: 'Si nous avons fait une erreur, contactez-nous.',
    TranslationLocales.spanish: 'Si cometimos un error, contáctenos.',
    TranslationLocales.portuguese:
        'Se cometemos um erro, entre em contato conosco.',
  },
  'Supported URLs': {
    TranslationLocales.german: 'Unterstützte URLs',
    TranslationLocales.french: 'URL prises en charge',
    TranslationLocales.spanish: 'URL admitidas',
    TranslationLocales.portuguese: 'URLs compatíveis',
  },
  'Information': {
    TranslationLocales.german: 'Informationen',
    TranslationLocales.french: 'Informations',
    TranslationLocales.spanish: 'Información',
    TranslationLocales.portuguese: 'Em formação',
  },
  'Show detailed Information about the App': {
    TranslationLocales.german: 'Zeige detailierte Informationen über die App',
    TranslationLocales.french:
        'Afficher des informations détaillées sur l\'application',
    TranslationLocales.spanish:
        'Mostrar información detallada sobre la aplicación',
    TranslationLocales.portuguese:
        'Mostrar informações detalhadas sobre o aplicativo',
  },
  'Most recent Book': {
    TranslationLocales.german: 'Letztes Buch',
    TranslationLocales.french: 'Livre le plus récent',
    TranslationLocales.spanish: 'Libro más reciente',
    TranslationLocales.portuguese: 'Livro mais recente',
  },
  'No recent Book': {
    TranslationLocales.german: 'Kein letztes Buch',
    TranslationLocales.french: 'Aucun livre récent',
    TranslationLocales.spanish: 'Sin libro reciente',
    TranslationLocales.portuguese: 'Nenhum livro recente',
  },
  'No last Entries found': {
    TranslationLocales.german: 'Keine letzten Einträge gefunden',
    TranslationLocales.french: 'Aucune dernière entrée trouvée',
    TranslationLocales.spanish: 'No se encontraron últimas entradas',
    TranslationLocales.portuguese: 'Nenhuma última entrada encontrada',
  },
};

/// Getter for the Translations.
/// Adds the Standard Translations to the
/// Custom Translations.
Map<String, Map<Locale, String>> get translations {
  _translations.addAll(StandardTranslations.all);
  return _translations;
}
