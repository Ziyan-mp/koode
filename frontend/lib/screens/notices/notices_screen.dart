import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/common/app_background.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white.withAlpha(217),
                borderRadius: AppRadius.largeBorderRadius,
                boxShadow: AppShadows.medium,
              ),
              child: const Text(
                'Notices Screen',
                style: AppTextStyles.heading,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
