import 'package:flutter/material.dart';

import '../../constants.dart';

class BorderWidget extends StatelessWidget {
  const BorderWidget({
    super.key,
    required this.radius,
    required this.child,
  });

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          width: 1,
          color: colors.tertiary2,
        ),
      ),
      child: child,
    );
  }
}
