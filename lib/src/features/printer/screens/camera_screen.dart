import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/svg_widget.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.path});

  static const routePath = '/CameraScreen';

  final String path;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  pw.Document document = pw.Document();

  void onPrint() async {
    await printDocument(document);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      document = await buildDocument([File(widget.path)]);
    });
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
        onError: (context, error) {
          return Text(error.toString());
        },
        build: (format) {
          return document.save();
        },
      ),
    );
  }
}
