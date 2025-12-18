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

class PickedScreen extends StatefulWidget {
  const PickedScreen({super.key, required this.paths});

  static const routePath = '/PickedScreen';

  final List<String> paths;

  @override
  State<PickedScreen> createState() => _PickedScreenState();
}

class _PickedScreenState extends State<PickedScreen> {
  pw.Document document = pw.Document();

  PdfController? controller;

  void onPrint() async {
    final bytes = await File(widget.paths.first).readAsBytes();

    await Printing.layoutPdf(
      onLayout: (_) => bytes,
    );

    // await printDocument(document);
  }

  @override
  void initState() {
    super.initState();
    controller = PdfController(
      document: PdfDocument.openFile(widget.paths.first),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      document = await buildDocument(List.generate(
        widget.paths.length,
        (index) {
          return File(widget.paths[index]);
        },
      ));

      setState(() {});
    });
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
        title: 'Camera',
        right: Button(
          onPressed: onPrint,
          child: const SvgWidget(Assets.printer),
        ),
      ),
      body: widget.paths.first.endsWith('.pdf')
          ? PdfView(
              controller: controller!,
              onDocumentError: (error) {
                return logger(error.toString());
              },
            )
          : PdfPreview(
              useActions: false,
              pdfPreviewPageDecoration: BoxDecoration(color: colors.bg),
              scrollViewDecoration: BoxDecoration(color: colors.tertiary2),
              loadingWidget: const Loading(),
              onError: (context, error) {
                return Text(
                  'Invalid file',
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 16,
                    fontFamily: AppFonts.w600,
                  ),
                );
              },
              build: (format) {
                return document.save();
              },
            ),
    );
  }
}
