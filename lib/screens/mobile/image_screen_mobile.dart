import 'package:flutter/material.dart';
import 'package:reading_diary/models/image_screen_arguments.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// A Screen that displays an Image (passed throug
/// the [args.file] argument) in full screen.
class ImageScreenMobile extends StatelessWidget {
  const ImageScreenMobile({
    required this.args,
    super.key,
  });

  final ImageScreenArguments args;

  @override
  Widget build(BuildContext context) {
    final mqS = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(args.title ?? 'Image'.tr()),
      ),
      body: Image.file(
        args.file,
        width: mqS.width,
        height: mqS.height,
      ),
    );
  }
}
