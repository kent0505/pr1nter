import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.width,
    this.color,
    this.onPressed,
  });

  final String title;
  final double? width;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    final active = onPressed != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: Constants.milliseconds),
      height: 56,
      width: width,
      decoration: BoxDecoration(
        color: color ?? (active ? colors.accent : colors.text2),
        borderRadius: BorderRadius.circular(56),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color == null
                    ? active
                        ? colors.bg
                        : colors.text3
                    : colors.text,
                fontSize: 18,
                fontFamily: AppFonts.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
