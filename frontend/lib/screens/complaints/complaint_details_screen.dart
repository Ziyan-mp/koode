import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../models/complaint_model.dart';
import '../../widgets/common/app_background.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintDetailsScreen({
    super.key,
    required this.complaint,
  });

  Color _getStatusColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'resolved':
        return Colors.green.shade700;
      case 'in progress':
      case 'inprogress':
        return Colors.orange.shade700;
      case 'rejected':
        return Colors.red.shade700;
      case 'pending':
      default:
        return Colors.blue.shade700;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.trim().toLowerCase()) {
      case 'resolved':
        return Icons.check_circle_outline;
      case 'in progress':
      case 'inprogress':
        return Icons.autorenew;
      case 'rejected':
        return Icons.cancel_outlined;
      case 'pending':
      default:
        return Icons.hourglass_empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(complaint.status);
    final statusIcon = _getStatusIcon(complaint.status);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Navigation Bar Row
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Complaint Details',
                      style: AppTextStyles.heading,
                    ),
                  ],
                ),

                AppSpacing.lgHeight,

                // Glassmorphism Card Container
                ClipRRect(
                  borderRadius: AppRadius.extraLargeBorderRadius,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Badge & ID Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                complaint.id.startsWith('#')
                                    ? complaint.id
                                    : '#${complaint.id}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(30),
                                  borderRadius: AppRadius.pillBorderRadius,
                                  border: Border.all(
                                    color: statusColor.withAlpha(80),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(statusIcon, size: 14, color: statusColor),
                                    const SizedBox(width: 6),
                                    Text(
                                      complaint.status.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          AppSpacing.mdHeight,

                          // Title
                          Text(
                            complaint.title,
                            style: AppTextStyles.heading.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          AppSpacing.xsHeight,

                          // Category & Date Info
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: AppRadius.pillBorderRadius,
                                ),
                                child: Text(
                                  complaint.category,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                complaint.dateSubmitted,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),

                          AppSpacing.lgHeight,

                          // Description
                          const Text(
                            'Description',
                            style: AppTextStyles.subHeading,
                          ),
                          AppSpacing.xsHeight,
                          Text(
                            complaint.description,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textPrimary,
                              height: 1.5,
                            ),
                          ),

                          AppSpacing.lgHeight,

                          // Additional Metadata Table (Location, Priority, Assigned Department)
                          if (complaint.location != null ||
                              complaint.priority != null ||
                              complaint.assignedDepartment != null) ...[
                            const Text(
                              'Additional Details',
                              style: AppTextStyles.subHeading,
                            ),
                            AppSpacing.smHeight,
                            if (complaint.location != null)
                              _DetailRow(
                                label: 'Location:',
                                value: complaint.location!,
                              ),
                            if (complaint.priority != null)
                              _DetailRow(
                                label: 'Priority:',
                                value: complaint.priority!,
                              ),
                            if (complaint.assignedDepartment != null)
                              _DetailRow(
                                label: 'Assigned Dept:',
                                value: complaint.assignedDepartment!,
                              ),
                            AppSpacing.lgHeight,
                          ],

                          // Admin Remarks (if available)
                          if (complaint.adminRemarks != null &&
                              complaint.adminRemarks!.isNotEmpty) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight.withAlpha(120),
                                borderRadius: AppRadius.mediumBorderRadius,
                                border: Border.all(
                                  color: AppColors.primary.withAlpha(80),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.admin_panel_settings_outlined,
                                        size: 18,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Admin Remarks',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSpacing.xsHeight,
                                  Text(
                                    complaint.adminRemarks!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSpacing.lgHeight,
                          ],

                          // Status Timeline Section
                          const Text(
                            'Status Timeline',
                            style: AppTextStyles.subHeading,
                          ),
                          AppSpacing.smHeight,
                          if (complaint.timeline.isEmpty)
                            _TimelineTile(
                              title: 'Submitted',
                              date: complaint.dateSubmitted,
                              note: 'Complaint submitted by user.',
                              isFirst: true,
                              isLast: true,
                            )
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: complaint.timeline.length,
                              itemBuilder: (context, index) {
                                final item = complaint.timeline[index];
                                return _TimelineTile(
                                  title: item.status,
                                  date: item.date,
                                  note: item.note,
                                  isFirst: index == 0,
                                  isLast: index == complaint.timeline.length - 1,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final String title;
  final String date;
  final String note;
  final bool isFirst;
  final bool isLast;

  const _TimelineTile({
    required this.title,
    required this.date,
    required this.note,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: AppColors.border,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (note.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    note,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
