import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.asset = '',
    this.imageUrl = '',
    this.height,
    this.width,
    this.fit,
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.center,
  });

  final String asset;
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry borderRadius;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      height: height,
      width: width,
    );

    if (asset.isNotEmpty) {
      child = Image.asset(
        asset,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        frameBuilder: frameBuilder,
        errorBuilder: errorBuilder,
      );
    } else if (imageUrl.isNotEmpty) {
      child = CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        placeholder: (context, url) => const SizedBox(),
        errorWidget: (context, url, error) => const SizedBox(),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: child,
    );
  }

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
}
