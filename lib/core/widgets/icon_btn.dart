import 'package:flutter/material.dart';

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
    return Button(
      onPressed: onPressed,
      child: Center(
        child: SvgWidget(
          asset,
          color: color,
        ),
      ),
    );
  }
}
