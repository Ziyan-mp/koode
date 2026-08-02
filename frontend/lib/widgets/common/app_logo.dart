import 'package:flutter/material.dart';
import '../../config/app_assets.dart';

/// Reusable AppLogo widget that renders the official Malayalam logo asset.
class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppLogo({
    super.key,
    double? width = 180,
    double? size,
    this.height,
    this.fit = BoxFit.contain,
    bool showTagline = true,
  }) : width = size ?? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.high,
    );
  }
}