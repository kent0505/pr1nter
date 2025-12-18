import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/svg_widget.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.paths});

  static const routePath = '/PreviewScreen';

  final List<String> paths;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  pw.Document document = pw.Document();

  PdfController? controller;

  bool isPDF = false;
  bool isDocumentReady = false;

  void onPrint() async {
    final bytes = isPDF
        ? await File(widget.paths.first).readAsBytes()
        : await document.save();
    await printDocument(bytes);
  }

  @override
  void initState() {
    super.initState();

    isPDF = widget.paths.first.toLowerCase().endsWith('.pdf');

    if (isPDF) {
      controller = PdfController(
        document: PdfDocument.openFile(widget.paths.first),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        document = await buildDocument(
          widget.paths.map((e) => File(e)).toList(),
        );

        setState(() {
          isDocumentReady = true;
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(
        title: 'Preview',
        right: Button(
          onPressed: onPrint,
          child: const SvgWidget(Assets.printer),
        ),
      ),
      body: isPDF
          ? PdfView(
              controller: controller!,
              onDocumentError: (error) {
                logger(error.toString());
              },
            )
          : !isDocumentReady
              ? const Loading()
              : PdfPreview(
                  useActions: false,
                  pdfPreviewPageDecoration: BoxDecoration(color: colors.bg),
                  scrollViewDecoration: BoxDecoration(color: colors.tertiary2),
                  loadingWidget: const Loading(),
                  build: (_) => document.save(),
                ),
    );
  }
}
