import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/common/app_logo.dart';

class AboutKoodeScreen extends StatelessWidget {
  const AboutKoodeScreen({super.key});

  // Application Version from project specifications
  static const String _appVersion = '1.0.0';
  static const String _buildNumber = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Back to Profile',
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'About Koode',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // App Branding Hero Card
                          ClipRRect(
                            borderRadius: AppRadius.extraLargeBorderRadius,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 32.0,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withAlpha(217),
                                  borderRadius: AppRadius.extraLargeBorderRadius,
                                  border: Border.all(
                                    color: AppColors.white.withAlpha(200),
                                    width: 1.5,
                                  ),
                                  boxShadow: AppShadows.medium,
                                ),
                                child: Column(
                                  children: [
                                    // Initiative Tag
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF004D61).withAlpha(20),
                                        borderRadius: AppRadius.pillBorderRadius,
                                      ),
                                      child: const Text(
                                        'AN INITIATIVE OF UDSF CEV',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF004D61),
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                    AppSpacing.mdHeight,

                                    // Koode Malayalam Logo
                                    const AppLogo(
                                      size: 84,
                                      showTagline: false,
                                    ),
                                    AppSpacing.smHeight,

                                    // App Name
                                    const Text(
                                      AppConstants.appName,
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    AppSpacing.xsHeight,

                                    // Tagline
                                    Text(
                                      AppConstants.tagline,
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    AppSpacing.smHeight,

                                    // Version Pill
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLight,
                                        borderRadius: AppRadius.pillBorderRadius,
                                      ),
                                      child: const Text(
                                        'Version $_appVersion (Build $_buildNumber)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          AppSpacing.lgHeight,

                          // Card 1: What is Koode?
                          _buildSectionCard(
                            icon: Icons.school_outlined,
                            title: 'What is Koode?',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Koode is a unified, student-focused campus management platform designed to empower students and modernize campus life. With Koode, students can easily manage academic activities and address campus concerns in one integrated space:',
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.textPrimary.withAlpha(220),
                                    height: 1.5,
                                  ),
                                ),
                                AppSpacing.mdHeight,
                                _buildFeatureItem(
                                  icon: Icons.campaign_outlined,
                                  title: 'Filing Campus Complaints',
                                  description:
                                      'Quickly submit grievances with categories, descriptions, priority levels, and photo attachments.',
                                ),
                                _buildFeatureItem(
                                  icon: Icons.track_changes_outlined,
                                  title: 'Tracking Submitted Complaints',
                                  description:
                                      'Monitor real-time status updates, resolution progress, and admin remarks directly from your dashboard.',
                                ),
                                _buildFeatureItem(
                                  icon: Icons.menu_book_outlined,
                                  title: 'Accessing Academic Notes & Materials',
                                  description:
                                      'Browse and download semester-wise study materials, lecture notes, syllabus guides, and reference documents.',
                                ),
                                _buildFeatureItem(
                                  icon: Icons.campaign_rounded,
                                  title: 'Viewing Campus Information',
                                  description:
                                      'Stay informed with verified institutional notices, upcoming campus events, fests, and placement drives.',
                                ),
                              ],
                            ),
                          ),

                          AppSpacing.mdHeight,

                          // Card 2: Our Purpose
                          _buildSectionCard(
                            icon: Icons.lightbulb_outline_rounded,
                            title: 'Our Purpose',
                            child: Text(
                              'The core mission of Koode is to foster a transparent, responsive, and connected campus community. By eliminating traditional bureaucratic hurdles, Koode provides an accessible digital bridge between students and campus authorities—ensuring every student’s voice is heard, grievances are resolved efficiently, and academic resources are readily accessible to all.',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textPrimary.withAlpha(220),
                                height: 1.55,
                              ),
                            ),
                          ),

                          AppSpacing.mdHeight,

                          // Card 3: App Ownership & Credits
                          _buildSectionCard(
                            icon: Icons.verified_outlined,
                            title: 'App Ownership & Credits',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow('Project Initiative', 'UDSF CEV'),
                                const Divider(height: 16, color: AppColors.border),
                                _buildDetailRow('Platform', 'Koode Campus Management System'),
                                const Divider(height: 16, color: AppColors.border),
                                _buildDetailRow('Target Audience', 'Students & Campus Administration'),
                                const Divider(height: 16, color: AppColors.border),
                                _buildDetailRow('Current Version', '$_appVersion+$_buildNumber'),
                                const Divider(height: 16, color: AppColors.border),
                                _buildDetailRow('Copyright', '© 2026 UDSF CEV. All rights reserved.'),
                              ],
                            ),
                          ),

                          AppSpacing.xlHeight,

                          // Back to Profile Button
                          Center(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back, size: 18),
                              label: const Text('BACK TO PROFILE'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: AppRadius.pillBorderRadius,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section Card Wrapper
  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(217),
        borderRadius: AppRadius.largeBorderRadius,
        border: Border.all(
          color: AppColors.white.withAlpha(200),
          width: 1.2,
        ),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: AppRadius.mediumBorderRadius,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.mdHeight,
          child,
        ],
      ),
    );
  }

  // Feature Bullet Item Builder
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 14,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Detail Row Builder
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
