import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';

/// Reusable Home Banner widget encouraging campus complaint submission
class HomeBanner extends StatelessWidget {
  final VoidCallback? onCreateComplaint;

  const HomeBanner({
    super.key,
    this.onCreateComplaint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 180),
      decoration: BoxDecoration(
        borderRadius: AppRadius.largeBorderRadius,
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.largeBorderRadius,
        child: Stack(
          children: [
            // Decorative background circle 1
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withAlpha(30),
                ),
              ),
            ),

            // Decorative background circle 2
            Positioned(
              right: 40,
              bottom: -40,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withAlpha(20),
                ),
              ),
            ),

            // Banner Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Left Side Info & Action Button
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Your Voice Matters',
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSpacing.xsHeight,
                        Text(
                          'Report campus issues and help improve your college environment.',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.white.withAlpha(220),
                            fontSize: 12,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSpacing.mdHeight,
                        ElevatedButton.icon(
                          onPressed: onCreateComplaint ??
                              () => debugPrint('Create Complaint'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primaryDark,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.pillBorderRadius,
                            ),
                          ),
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 18,
                          ),
                          label: const Text(
                            'Create Complaint',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.smWidth,

                  // Right Side Illustration Placeholder
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withAlpha(45),
                      border: Border.all(
                        color: AppColors.white.withAlpha(80),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.campaign_outlined,
                        size: 40,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
