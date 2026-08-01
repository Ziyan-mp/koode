import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showTagline;

  const AppLogo({
    super.key,
    this.size = 72,
    this.showTagline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Soft sky blue outer halo glow
            Container(
              width: size + 20,
              height: size + 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight.withAlpha(120),
              ),
            ),

            // Inner aqua/teal circle container
            Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent,
                    AppColors.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: const [
                  // Birds Motif Top Right
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Icon(
                      Icons.flutter_dash,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  // Main Icon
                  Center(
                    child: Icon(
                      Icons.campaign_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Malayalam brand text "കൂടെ" / "Koode"
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'കൂടെ',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Koode',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        if (showTagline) ...[
          const SizedBox(height: 4),
          const Text(
            'Your Voice, Your Campus',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}