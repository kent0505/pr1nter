import 'dart:developer' as developer;
import 'dart:io';
import 'dart:typed_data';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' show Rect;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void logger(Object message) => developer.log(message.toString());

int getTimestamp() {
  return DateTime.now().millisecondsSinceEpoch;
}

bool isIOS() {
  return Platform.isIOS;
}

Future<String> pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return '';
  return image.path;
}

Future<String> pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'txt', 'png', 'jpg'],
  );
  return result?.files.single.path ?? '';
}

Future<void> launchURL(String url) async {
  try {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  } catch (e) {
    logger('Error launching url: $e');
  }
}

Future<Uint8List> getBytes(ScreenshotController controller) async {
  try {
    final bytes = await controller.capture();
    if (bytes == null) throw Exception('null bytes');
    return bytes;
  } catch (e) {
    logger(e);
    return Uint8List(0);
  }
}

Future<File> getFile(Uint8List bytes) async {
  try {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/printable.png');
    await file.writeAsBytes(bytes);
    return file;
  } catch (e) {
    logger(e);
    return File('');
  }
}

Future<void> printDocument(Document pdf) async {
  try {
    await Printing.layoutPdf(
      format: PdfPageFormat.a4,
      onLayout: (PdfPageFormat format) async => await pdf.save(),
    );
  } catch (e) {
    logger(e);
  }
}

Future<void> shareFiles(List<File> files) async {
  try {
    if (files.isEmpty) return;
    await SharePlus.instance.share(
      ShareParams(
        sharePositionOrigin: const Rect.fromLTWH(100, 100, 200, 200),
        files: List.generate(
          files.length,
          (index) {
            return XFile(files[index].path);
          },
        ),
      ),
    );
  } catch (e) {
    logger(e);
  }
}

Future<List<String>> scan() async {
  final scanned = await CunningDocumentScanner.getPictures();
  if (scanned != null && scanned.isNotEmpty) {
    return scanned;
  }
  return [];
}

Future<Document> buildDocument(List<File> files) async {
  final document = Document();
  for (final file in files) {
    final bytes = await file.readAsBytes();
    document.addPage(
      Page(
        margin: EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return Center(
            child: Image(
              MemoryImage(bytes),
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
  return document;
}
