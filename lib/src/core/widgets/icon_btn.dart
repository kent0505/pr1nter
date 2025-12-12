import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';
import 'svg_widget.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({
    super.key,
    required this.asset,
    this.color,
    required this.onPressed,
  });

  final String asset;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: onPressed,
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: colors.tertiary2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: SvgWidget(
            asset,
            color: color,
          ),
        ),
      ),
    );
  }
}
