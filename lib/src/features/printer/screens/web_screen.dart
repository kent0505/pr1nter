import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  static const routePath = '/WebScreen';

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late InAppWebViewController webViewController;

  void onLeft() async {
    if (await webViewController.canGoBack()) {
      await webViewController.goBack();
    }
  }

  void onRight() async {
    if (await webViewController.canGoForward()) {
      await webViewController.goForward();
    }
  }

  void onReload() async {
    await webViewController.reload();
  }

  void onPrint() async {
    await webViewController.takeScreenshot().then((bytes) async {
      if (bytes != null) {
        await printDocument(
          await buildDocument(
            [await getFile(bytes)],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(
        title: 'Web Pages',
        right: Button(
          onPressed: onPrint,
          child: SvgWidget(
            Assets.printer,
            color: colors.text,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri('https://google.com'),
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
            ),
          ),
          Container(
            height: Constants.navBarHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 4,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  onPressed: onLeft,
                  child: SvgWidget(
                    Assets.back,
                    color: colors.text,
                  ),
                ),
                Button(
                  onPressed: onRight,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: SvgWidget(
                      Assets.back,
                      color: colors.text,
                    ),
                  ),
                ),
                Button(
                  onPressed: onReload,
                  child: Icon(
                    CupertinoIcons.refresh,
                    color: colors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
