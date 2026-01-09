import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/img.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../subscription/bloc/subscription_bloc.dart';
import '../../subscription/data/subscription_repository.dart';

class PrintableDetailScreen extends StatefulWidget {
  const PrintableDetailScreen({super.key, required this.asset});

  static const routePath = '/PrintableDetailScreen';

  final String asset;

  @override
  State<PrintableDetailScreen> createState() => _PrintableDetailScreenState();
}

class _PrintableDetailScreenState extends State<PrintableDetailScreen> {
  final screenshotController = ScreenshotController();

  pw.Document document = pw.Document();

  Uint8List bytes = Uint8List(0);

  late File file;

  bool isReady = false;

  void onShare() async {
    await shareFiles([file]);
  }

  void onPrint() async {
    await printDocument(await document.save());
  }

  void onShowPaywall() {
    context.read<SubscriptionRepository>().showPaywall();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bytes = await getBytes(screenshotController);
      file = await getFile(bytes);
      document = await buildDocument([file]);
      setState(() {
        isReady = true;
      });
    });
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
                  color: colors.accent,
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
                  : Img(asset: widget.asset),
            ),
          ),
          const Spacer(),
          ButtonWrapper(
            children: [
              MainButton(
                title: 'Print',
                onPressed: !isReady
                    ? null
                    : context.read<SubscriptionBloc>().state.subscribed
                        ? onPrint
                        : onShowPaywall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
