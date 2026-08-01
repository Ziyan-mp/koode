import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';

/// Reusable Quick Actions Section widget for Home Screen
class QuickActionsSection extends StatelessWidget {
  final VoidCallback? onNewComplaintTap;
  final VoidCallback? onMyComplaintsTap;
  final VoidCallback? onNoticesTap;
  final VoidCallback? onProfileTap;

  const QuickActionsSection({
    super.key,
    this.onNewComplaintTap,
    this.onMyComplaintsTap,
    this.onNoticesTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionItem(
        title: 'New Complaint',
        icon: Icons.add_circle_outline,
        iconColor: AppColors.primary,
        iconBgColor: AppColors.primaryLight,
        onTap: onNewComplaintTap ?? () => debugPrint('New Complaint'),
      ),
      _QuickActionItem(
        title: 'My Complaints',
        icon: Icons.assignment_outlined,
        iconColor: AppColors.secondary,
        iconBgColor: AppColors.secondaryLight,
        onTap: onMyComplaintsTap ?? () => debugPrint('My Complaints'),
      ),
      _QuickActionItem(
        title: 'Notices',
        icon: Icons.campaign_outlined,
        iconColor: AppColors.accent,
        iconBgColor: AppColors.accentLight,
        onTap: onNoticesTap ?? () => debugPrint('Notices'),
      ),
      _QuickActionItem(
        title: 'Profile',
        icon: Icons.person_outline,
        iconColor: AppColors.primaryDark,
        iconBgColor: AppColors.primaryLight,
        onTap: onProfileTap ?? () => debugPrint('Profile'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: AppTextStyles.subHeading,
        ),
        AppSpacing.mdHeight,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (context, index) {
            final action = actions[index];
            return _QuickActionCard(action: action);
          },
        ),
      ],
    );
  }
}

class _QuickActionItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.onTap,
  });
}

class _QuickActionCard extends StatelessWidget {
  final _QuickActionItem action;

  const _QuickActionCard({
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.mediumBorderRadius,
        boxShadow: AppShadows.light,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.mediumBorderRadius,
          onTap: action.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: action.iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    action.icon,
                    color: action.iconColor,
                    size: 28,
                  ),
                ),
                AppSpacing.smHeight,
                Text(
                  action.title,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
