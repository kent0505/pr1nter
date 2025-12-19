import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/img.dart';
import '../../../core/widgets/snack.dart';
import '../../../core/widgets/svg_widget.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key, required this.paths});

  final List<String> paths;

  static const routePath = '/ScannerScreen';

  static Future<List<String>> getPictures(BuildContext context) async {
    try {
      final scanned = await CunningDocumentScanner.getPictures();
      if (scanned != null && scanned.isNotEmpty) {
        return scanned;
      }
    } catch (e) {
      logger(e);
      if (context.mounted) {
        Snack.show(
          context,
          'Camera permission not granted',
        );
      }
    }
    return [];
  }

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  List<File> files = [];

  final textRecognizer = TextRecognizer();

  void onCopy() async {
    final recognizedText = await textRecognizer.processImage(
      InputImage.fromFile(files.first),
    );
    final text = recognizedText.text;
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
    }
    if (mounted) {
      Snack.show(
        context,
        text.isEmpty ? 'Text not found' : 'Text copied to clipboard',
      );
    }
  }

  void onAdd() async {
    await ScannerScreen.getPictures(context).then((value) {
      for (String path in value) {
        files.add(File(path));
      }
      setState(() {});
    });
  }

  void onShare() {
    shareFiles(files);
  }

  void onPrint() async {
    final document = await buildDocument(files);
    await printDocument(await document.save());
  }

  @override
  void initState() {
    super.initState();
    files = List.generate(
      widget.paths.length,
      (index) {
        return File(widget.paths[index]);
      },
    );
  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(
        title: 'Scanned Document',
        right: Button(
          onPressed: onPrint,
          child: SvgWidget(
            Assets.printer,
            color: colors.accent,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: files.length,
              itemBuilder: (context, index) {
                return Image.file(
                  files[index],
                  errorBuilder: Img.errorBuilder,
                  frameBuilder: Img.frameBuilder,
                );
              },
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  onPressed: onCopy,
                  child: SvgWidget(
                    Assets.copy,
                    color: colors.accent,
                  ),
                ),
                Button(
                  onPressed: onAdd,
                  child: SvgWidget(
                    Assets.add,
                    color: colors.accent,
                  ),
                ),
                Button(
                  onPressed: onShare,
                  child: SvgWidget(
                    Assets.share,
                    color: colors.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 34),
        ],
      ),
    );
  }
}
