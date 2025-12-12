import 'package:flutter/material.dart';

import '../../constants.dart';

class TextAnim extends StatelessWidget {
  const TextAnim({
    super.key,
    required this.title,
    this.color,
    this.fontSize = 20,
    this.fontFamily = AppFonts.w700,
    this.textStyle,
  });

  final String title;
  final Color? color;
  final double fontSize;
  final String fontFamily;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: Constants.milliseconds),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Text(
        key: ValueKey(title),
        title,
        style: textStyle ??
            TextStyle(
              color: color ?? colors.text,
              fontSize: fontSize,
              fontFamily: fontFamily,
            ),
      ),
    );
  }
}
