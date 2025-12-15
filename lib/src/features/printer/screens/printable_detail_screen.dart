import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/image_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../data/printer_repository.dart';

class PrintableDetailScreen extends StatefulWidget {
  const PrintableDetailScreen({super.key, required this.asset});

  static const routePath = '/PrintableDetailScreen';

  final String asset;

  @override
  State<PrintableDetailScreen> createState() => _PrintableDetailScreenState();
}

class _PrintableDetailScreenState extends State<PrintableDetailScreen> {
  final screenshotController = ScreenshotController();

  Uint8List bytes = Uint8List(0);
  File file = File('');
  final pdf = pw.Document();

  late PrinterRepository _repository;

  void onShare() async {
    await _repository.shareFiles([file]);
  }

  void onPrint() async {
    await _repository.printPdf(pdf);
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bytes = await getBytes(screenshotController);
      file = await getFile(bytes);
      pdf.addPage(
        pw.Page(
          margin: pw.EdgeInsets.zero,
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Center(
              child: pw.Image(
                pw.MemoryImage(bytes),
                fit: pw.BoxFit.contain,
              ),
            );
          },
        ),
      );
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _repository = context.read<PrinterRepository>();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(
        title: 'Preview',
        right: bytes.isEmpty
            ? null
            : Button(
                onPressed: onShare,
                child: SvgWidget(
                  Assets.share,
                  color: colors.text,
                ),
              ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Screenshot(
              controller: screenshotController,
              child: widget.asset.endsWith('svg')
                  ? SvgWidget(
                      widget.asset,
                      width: MediaQuery.sizeOf(context).width,
                    )
                  : ImageWidget(asset: widget.asset),
            ),
          ),
          const Spacer(),
          ButtonWrapper(
            children: [
              MainButton(
                title: 'Print',
                onPressed: bytes.isEmpty ? null : onPrint,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
