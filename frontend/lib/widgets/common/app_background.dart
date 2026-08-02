import 'package:flutter/material.dart';
import '../../config/app_assets.dart';

/// Reusable full-screen background widget that displays the official application background image.
class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAssets.background,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          filterQuality: FilterQuality.high,
        ),
        child,
      ],
    );
  }
}
