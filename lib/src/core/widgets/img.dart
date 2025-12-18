import 'package:flutter/material.dart';

import '../utils.dart';

class Img extends StatelessWidget {
  const Img({
    super.key,
    this.asset = '',
    this.height,
    this.width,
    this.fit,
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.center,
  });

  final String asset;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry borderRadius;
  final Alignment alignment;

  static Widget errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    logger('Image error: $error');

    return const SizedBox();
  }

  static Widget frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    return AnimatedOpacity(
      opacity: frame == null ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        asset,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        frameBuilder: frameBuilder,
        errorBuilder: errorBuilder,
      ),
    );
  }
}
