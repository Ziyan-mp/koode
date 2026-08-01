import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';

/// Reusable Complaint Statistics Section widget for Home Screen
class ComplaintStatisticsSection extends StatelessWidget {
  final int pendingCount;
  final int inProgressCount;
  final int resolvedCount;
  final int rejectedCount;

  const ComplaintStatisticsSection({
    super.key,
    this.pendingCount = 12,
    this.inProgressCount = 5,
    this.resolvedCount = 18,
    this.rejectedCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem(
        title: 'Pending',
        count: pendingCount,
        icon: Icons.pending_actions_outlined,
        color: AppColors.warning,
      ),
      _StatItem(
        title: 'In Progress',
        count: inProgressCount,
        icon: Icons.sync,
        color: AppColors.secondary,
      ),
      _StatItem(
        title: 'Resolved',
        count: resolvedCount,
        icon: Icons.check_circle_outline,
        color: AppColors.success,
      ),
      _StatItem(
        title: 'Rejected',
        count: rejectedCount,
        icon: Icons.cancel_outlined,
        color: AppColors.error,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complaint Statistics',
          style: AppTextStyles.subHeading,
        ),
        AppSpacing.mdHeight,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (context, index) {
            final stat = stats[index];
            return _StatCard(stat: stat);
          },
        ),
      ],
    );
  }
}

class _StatItem {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });
}

class _StatCard extends StatelessWidget {
  final _StatItem stat;

  const _StatCard({
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.mediumBorderRadius,
        boxShadow: AppShadows.light,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: stat.color.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  stat.icon,
                  color: stat.color,
                  size: 24,
                ),
              ),
              Text(
                '${stat.count}',
                style: AppTextStyles.display.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.smHeight,
          Text(
            stat.title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
