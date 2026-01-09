import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../subscription/bloc/subscription_bloc.dart';
import '../../subscription/data/subscription_repository.dart';
import '../models/preview.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.preview});

  static const routePath = '/PreviewScreen';

  final Preview preview;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  pw.Document document = pw.Document();

  PdfController? controller;

  bool isPDF = false;
  bool isDocumentReady = false;

  late Preview preview;

  void onPrint() async {
    context.read<SubscriptionBloc>().add(UseFreeDoc());
    final bytes =
        isPDF ? await preview.files.first.readAsBytes() : await document.save();
    await printDocument(bytes);
  }

  void onShowPaywall() {
    context.read<SubscriptionRepository>().showPaywall();
  }

  @override
  void initState() {
    super.initState();
    preview = widget.preview;

    final path = preview.files.first.path.toLowerCase();

    isPDF = path.endsWith('.pdf');

    if (isPDF) {
      controller = PdfController(
        document: PdfDocument.openFile(preview.files.first.path),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        document = await buildDocument(
          preview.files,
          txt: path.endsWith('.txt'),
          path: preview.font,
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

    final bloc = context.watch<SubscriptionBloc>();
    final locked = !bloc.state.subscribed && bloc.state.freeDoc <= 0;

    return Scaffold(
      appBar: Appbar(
        title: 'Preview',
        right: Button(
          onPressed: locked ? onShowPaywall : onPrint,
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
