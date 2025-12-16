import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/image_widget.dart';
import '../../../core/widgets/svg_widget.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key, required this.paths});

  static const routePath = '/ScannerScreen';

  final List<String> paths;

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  List<File> files = [];

  void onCopyText() async {}

  void onAddImage() async {
    await scan().then((value) {
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
    await printDocument(await buildDocument(files));
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
                  errorBuilder: ImageWidget.errorBuilder,
                  frameBuilder: ImageWidget.frameBuilder,
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
                  onPressed: onCopyText,
                  child: SvgWidget(
                    Assets.copy,
                    color: colors.accent,
                  ),
                ),
                Button(
                  onPressed: onAddImage,
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
