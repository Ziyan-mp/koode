import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';

/// Reusable Recent Complaints Section widget for Home Screen
class RecentComplaintsSection extends StatelessWidget {
  final ValueChanged<int>? onComplaintTap;
  final VoidCallback? onViewAllTap;

  const RecentComplaintsSection({
    super.key,
    this.onComplaintTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final complaints = const [
      _ComplaintData(
        title: 'Projector Not Working',
        category: 'Academic',
        status: 'Pending',
        date: '01 Aug 2026',
      ),
      _ComplaintData(
        title: 'Water Leakage in Hostel',
        category: 'Hostel',
        status: 'In Progress',
        date: '30 Jul 2026',
      ),
      _ComplaintData(
        title: 'Library AC Not Working',
        category: 'Library',
        status: 'Resolved',
        date: '28 Jul 2026',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Complaints',
              style: AppTextStyles.subHeading,
            ),
            TextButton(
              onPressed: onViewAllTap ?? () => debugPrint('View All Complaints'),
              child: Text(
                'View All',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.xsHeight,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: complaints.length,
          separatorBuilder: (context, index) => AppSpacing.mdHeight,
          itemBuilder: (context, index) {
            final complaint = complaints[index];
            return _RecentComplaintCard(
              complaint: complaint,
              onTap: () {
                if (onComplaintTap != null) {
                  onComplaintTap!(index);
                } else {
                  debugPrint('Complaint $index');
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class _ComplaintData {
  final String title;
  final String category;
  final String status;
  final String date;

  const _ComplaintData({
    required this.title,
    required this.category,
    required this.status,
    required this.date,
  });
}

class _RecentComplaintCard extends StatelessWidget {
  final _ComplaintData complaint;
  final VoidCallback onTap;

  const _RecentComplaintCard({
    required this.complaint,
    required this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.warning;
      case 'in progress':
        return AppColors.secondary;
      case 'resolved':
        return AppColors.success;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(complaint.status);

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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              complaint.title,
                              style: AppTextStyles.title.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          AppSpacing.smWidth,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(25),
                              borderRadius: AppRadius.pillBorderRadius,
                              border: Border.all(
                                color: statusColor.withAlpha(120),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              complaint.status,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.smHeight,
                      Row(
                        children: [
                          Text(
                            complaint.category,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            ' • ',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            complaint.date,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.smWidth,
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
