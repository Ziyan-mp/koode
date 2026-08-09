import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/common/app_logo.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Policy Content
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Banner Card
                          ClipRRect(
                            borderRadius: AppRadius.extraLargeBorderRadius,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24.0),
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
                                    const AppLogo(
                                      size: 64,
                                      showTagline: true,
                                    ),
                                    AppSpacing.mdHeight,
                                    Text(
                                      'Koode Privacy Policy',
                                      style: AppTextStyles.heading.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    AppSpacing.xsHeight,
                                    Text(
                                      'Last Updated: August 2026',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpacing.smHeight,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLight,
                                        borderRadius: AppRadius.pillBorderRadius,
                                      ),
                                      child: Text(
                                        'Your privacy and data security are our core priorities.',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          AppSpacing.lgHeight,

                          // Section 1: Introduction
                          _buildPolicySection(
                            icon: Icons.info_outline_rounded,
                            title: '1. Introduction',
                            content:
                                'Welcome to Koode ("we", "our", or "us"). Koode is an official campus-centric platform dedicated to streamlining grievance redressal, academic materials sharing, and institutional communication for students and staff. This Privacy Policy outlines how your personal information is collected, stored, processed, and protected when using the Koode mobile and web application.',
                          ),

                          // Section 2: Information We Collect
                          _buildPolicySection(
                            icon: Icons.list_alt_rounded,
                            title: '2. Information We Collect',
                            content:
                                'To provide reliable campus management features, we collect information that you directly provide to us, including:\n\n'
                                '• Student Identification details (Full Name, College Email, Register/Student ID, Department, Semester/Year).\n'
                                '• Authentication credentials (passwords stored using industry-standard cryptographic hashing).\n'
                                '• User Profile details (contact phone number, avatar/profile image, gender, college name).\n'
                                '• System activity logs and session timestamps.',
                          ),

                          // Section 3: How We Use Information
                          _buildPolicySection(
                            icon: Icons.psychology_outlined,
                            title: '3. How We Use Information',
                            content:
                                'We utilize the collected information strictly for academic and campus administrative operations, such as:\n\n'
                                '• Verifying institutional student/faculty enrollment and identity.\n'
                                '• Routing complaints and queries to respective department heads or administrative authorities.\n'
                                '• Keeping you updated on complaint resolution progress and campus notices.\n'
                                '• Providing seamless access to academic notes, syllabus, and study resources.\n'
                                '• Ensuring compliance with campus rules and protecting against unauthorized access.',
                          ),

                          // Section 4: Account Information
                          _buildPolicySection(
                            icon: Icons.account_circle_outlined,
                            title: '4. Account Information',
                            content:
                                'Your account credentials and academic profile are linked to your institutional email. You have the ability to view and edit your profile details at any time from the Edit Profile screen. You are responsible for maintaining the confidentiality of your login credentials.',
                          ),

                          // Section 5: Complaints and User-Submitted Content
                          _buildPolicySection(
                            icon: Icons.campaign_outlined,
                            title: '5. Complaints and User-Submitted Content',
                            content:
                                'When you submit a grievance or feedback via Koode:\n\n'
                                '• The complaint title, description, category, and priority are transmitted to authorized campus administrators.\n'
                                '• The submission timestamp and current status (Pending, In Progress, Resolved, Rejected) are tracked in the system.\n'
                                '• Administrative feedback and timeline updates are visible within your complaint details view.',
                          ),

                          // Section 6: Uploaded Images and Attachments
                          _buildPolicySection(
                            icon: Icons.attachment_rounded,
                            title: '6. Uploaded Images and Attachments',
                            content:
                                'When attaching photographic evidence or documents to your complaints, profile, or notes:\n\n'
                                '• Attachments are processed only to assist administrators in resolving reported issues.\n'
                                '• We do not access or collect media from your device outside the explicitly selected files.\n'
                                '• Uploaded files are stored securely with restricted access controls.',
                          ),

                          // Section 7: Data Storage and Security
                          _buildPolicySection(
                            icon: Icons.security_rounded,
                            title: '7. Data Storage and Security',
                            content:
                                'We implement robust technical and organizational measures to safeguard your personal data from unauthorized access, alteration, loss, or disclosure. Data transmissions are encrypted using standard TLS protocols, and stored records adhere to strict institutional data governance standards.',
                          ),

                          // Section 8: Sharing of Information
                          _buildPolicySection(
                            icon: Icons.share_outlined,
                            title: '8. Sharing of Information',
                            content:
                                'Koode does NOT sell, rent, or trade your personal information to third-party commercial entities. Information is only shared within the campus ecosystem with verified department coordinators, administrative officers, or relevant grievance review committees tasked with investigating specific complaints.',
                          ),

                          // Section 9: User Rights
                          _buildPolicySection(
                            icon: Icons.verified_user_outlined,
                            title: '9. User Rights',
                            content:
                                'As a registered student or staff member, you have the right to:\n\n'
                                '• Access your personal data recorded within the application.\n'
                                '• Request corrections to erroneous academic or profile information.\n'
                                '• Reset your account password securely at any time.\n'
                                '• Request the deletion or deactivation of your account through the administrative helpdesk.',
                          ),

                          // Section 10: Data Retention
                          _buildPolicySection(
                            icon: Icons.history_rounded,
                            title: '10. Data Retention',
                            content:
                                'We retain your personal data and submitted records for the duration of your academic enrollment or as necessary to fulfill institutional record-keeping obligations and grievance resolution audits.',
                          ),

                          // Section 11: Changes to This Privacy Policy
                          _buildPolicySection(
                            icon: Icons.update_rounded,
                            title: '11. Changes to This Privacy Policy',
                            content:
                                'We may update our Privacy Policy periodically to reflect technological improvements or institutional policy changes. Any revisions will be reflected on this page with an updated revision date. Continued use of Koode constitutes acceptance of the updated terms.',
                          ),

                          // Section 12: Contact Us
                          _buildPolicySection(
                            icon: Icons.contact_support_outlined,
                            title: '12. Contact Us',
                            content:
                                'If you have any questions, concerns, or feedback regarding this Privacy Policy or our data handling practices, please contact the campus administrative cell:\n\n'
                                '• Email: privacy@koode.campus.edu (Placeholder / Configurable)\n'
                                '• Office: Student Grievance & Technical Cell\n'
                                '• Organization: UDSF CEV\n'
                                '• Portal: Koode Campus Helpdesk',
                          ),

                          AppSpacing.xlHeight,

                          // Bottom Back to Profile Button
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

  // Section Card Builder
  Widget _buildPolicySection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
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
          Text(
            content,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary.withAlpha(220),
              height: 1.55,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}
