import 'dart:io';
import 'dart:ui';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils.dart';

abstract interface class PrinterRepository {
  const PrinterRepository();

  Future<void> printPdf(Document pdf);
  Future<void> shareFiles(List<File> files);
}

final class PrinterRepositoryImpl implements PrinterRepository {
  PrinterRepositoryImpl();

  @override
  Future<void> printPdf(Document pdf) async {
    try {
      await Printing.layoutPdf(
        format: PdfPageFormat.a4,
        onLayout: (PdfPageFormat format) async => await pdf.save(),
      );
    } catch (e) {
      logger(e);
    }
  }

  @override
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
}
