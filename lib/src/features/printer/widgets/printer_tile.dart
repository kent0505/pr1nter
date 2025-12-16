import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../vip/screens/vip_screen.dart';

class PrinterTile extends StatelessWidget {
  const PrinterTile({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
    this.locked = false,
    required this.onPressed,
  });

  final String asset;
  final String title;
  final String description;
  final bool locked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    final width = MediaQuery.sizeOf(context).width;
    final isIpad = width >= 500;
    final size = (width / (isIpad ? 3 : 2)) - (isIpad ? 24 : 20);

    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colors.tertiary1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Button(
        onPressed: locked
            ? () {
                VipScreen.open(context);
              }
            : onPressed,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 98,
                  child: SvgWidget(asset),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 16,
                    fontFamily: AppFonts.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 14,
                    fontFamily: AppFonts.w500,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            if (locked)
              const Positioned(
                top: 0,
                right: 0,
                child: SvgWidget(
                  Assets.locked,
                  height: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
