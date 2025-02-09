import 'dart:io';

/// The Arguments passed to an Image Screen.
class ImageScreenArguments {
  const ImageScreenArguments({
    required this.file,
    this.title,
  });

  /// The File that this Image is stored in.
  final File file;

  /// The Title of this Screens AppBar.
  final String? title;
}
