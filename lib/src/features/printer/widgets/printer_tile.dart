import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class PrinterTile extends StatelessWidget {
  const PrinterTile({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  final String asset;
  final String title;
  final String description;
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
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: colors.tertiary1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Button(
        onPressed: onPressed,
        padding: const EdgeInsetsGeometry.all(12),
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
