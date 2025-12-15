import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/svg_widget.dart';
import '../data/printer_repository.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.path});

  static const routePath = '/CameraScreen';

  final String path;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final pdf = pw.Document();
  Uint8List? imageBytes;

  late PrinterRepository _repository;

  void createPdf() async {
    try {
      imageBytes = await File(widget.path).readAsBytes();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                pw.MemoryImage(imageBytes!),
              ),
            );
          },
        ),
      );
    } catch (e) {
      logger(e);
    }
  }

  void onPrint() async {
    await _repository.printPdf(pdf);
  }

  @override
  void initState() {
    super.initState();
    _repository = context.read<PrinterRepository>();
    createPdf();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(
        title: 'Camera',
        right: Button(
          onPressed: onPrint,
          child: const SvgWidget(Assets.printer),
        ),
      ),
      body: PdfPreview(
        useActions: false,
        pdfPreviewPageDecoration: BoxDecoration(color: colors.bg),
        scrollViewDecoration: BoxDecoration(color: colors.tertiary2),
        loadingWidget: const LoadingWidget(),
        build: (format) {
          return pdf.save();
        },
      ),
    );
  }
}
