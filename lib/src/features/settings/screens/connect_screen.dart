import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/image_widget.dart';
import '../../../core/widgets/svg_widget.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  static const routePath = '/ConnectScreen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    final style = TextStyle(
      color: colors.text3,
      fontSize: 16,
      fontFamily: AppFonts.w500,
    );

    final boldStyle = TextStyle(
      color: colors.text3,
      fontSize: 16,
      fontFamily: AppFonts.w700,
    );

    return Scaffold(
      appBar: const Appbar(title: 'Wi-Fi printer setup'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Connecting using WPS (if supported by your router',
            style: TextStyle(
              color: colors.text,
              fontSize: 24,
              fontFamily: AppFonts.w700,
            ),
          ),
          const SizedBox(height: 26),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '1. Make sure your ',
                  style: style,
                ),
                TextSpan(
                  text: 'printer is turned on',
                  style: boldStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const _Card(
            children: [
              Positioned(
                top: 30,
                left: 74,
                child: SvgWidget(
                  Assets.printer2,
                  height: 156,
                ),
              ),
              Positioned(
                top: 28,
                left: 177,
                child: ImageWidget(
                  asset: Assets.power,
                  height: 148,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 204,
                child: SvgWidget(
                  Assets.touch,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '2. Press and hold the Wi-Fi or WPS button on the printer for 3-5 seconds, ',
                  style: boldStyle,
                ),
                TextSpan(
                  text: 'until the indicator light starts blinking',
                  style: style,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _Card(
            children: [
              const Positioned(
                top: 30,
                left: 74,
                child: SvgWidget(
                  Assets.printer2,
                  height: 156,
                ),
              ),
              Positioned(
                top: 66,
                left: 220,
                child: Container(
                  height: 60,
                  width: 60,
                  color: colors.tertiary1,
                ),
              ),
              const Positioned(
                top: 28,
                left: 177,
                child: ImageWidget(
                  asset: Assets.wifi,
                  height: 148,
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 204,
                child: SvgWidget(
                  Assets.touch,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '3. Press the WPS button on your router within 2 minutes ',
                  style: boldStyle,
                ),
                TextSpan(
                  text: 'of completing step 2',
                  style: style,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const _Card(
            children: [
              Positioned(
                top: -70,
                left: 0,
                right: 0,
                child: ImageWidget(
                  asset: Assets.router,
                  height: 330,
                ),
              ),
              Positioned(
                bottom: -48,
                left: 68,
                child: SvgWidget(
                  Assets.touch,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '4. Wait for the printer to connect ',
                  style: boldStyle,
                ),
                TextSpan(
                  text: '(the indicator should stop blinking once connected)',
                  style: style,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _Card(
            children: [
              const Positioned(
                top: 40,
                left: 0,
                child: ImageWidget(
                  asset: Assets.power,
                  height: 132,
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 50,
                    width: 60,
                    color: colors.text2,
                  ),
                ),
              ),
              const Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: ImageWidget(
                  asset: Assets.wifi,
                  height: 132,
                ),
              ),
              const Positioned(
                top: 40,
                right: 0,
                child: ImageWidget(
                  asset: Assets.wifi,
                  height: 132,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 214,
      decoration: BoxDecoration(
        color: colors.tertiary1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(children: children),
    );
  }
}
