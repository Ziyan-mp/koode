import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback? onView;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;

  const NoteCard({
    super.key,
    required this.note,
    this.onView,
    this.onDownload,
    this.onShare,
  });

  Color _getFileTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'PDF':
        return Colors.red.shade700;
      case 'PPT':
      case 'PPTX':
        return Colors.deepOrange.shade700;
      case 'DOC':
      case 'DOCX':
        return Colors.blue.shade700;
      case 'ZIP':
      case 'RAR':
        return Colors.purple.shade700;
      default:
        return AppColors.primary;
    }
  }

  IconData _getFileTypeIcon(String type) {
    switch (type.toUpperCase()) {
      case 'PDF':
        return Icons.picture_as_pdf_outlined;
      case 'PPT':
      case 'PPTX':
        return Icons.slideshow_outlined;
      case 'DOC':
      case 'DOCX':
        return Icons.description_outlined;
      case 'ZIP':
      case 'RAR':
        return Icons.folder_zip_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getFileTypeColor(note.fileType);
    final typeIcon = _getFileTypeIcon(note.fileType);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(220),
        borderRadius: AppRadius.mediumBorderRadius,
        border: Border.all(
          color: AppColors.white.withAlpha(200),
          width: 1.2,
        ),
        boxShadow: AppShadows.light,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: File Type Badge & Semester Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(30),
                  borderRadius: AppRadius.pillBorderRadius,
                  border: Border.all(color: typeColor.withAlpha(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(typeIcon, size: 14, color: typeColor),
                    const SizedBox(width: 4),
                    Text(
                      note.fileType.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: AppRadius.pillBorderRadius,
                ),
                child: Text(
                  note.semester,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          AppSpacing.smHeight,

          // Note Title
          Text(
            note.title,
            style: AppTextStyles.subHeading.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 6),

          // Subject Tag
          Row(
            children: [
              const Icon(
                Icons.book_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  note.subject,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          AppSpacing.smHeight,

          // Upload Details (Uploaded By & Date)
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 13,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  note.uploadedBy,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.calendar_today_outlined,
                size: 12,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                note.uploadDate,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // File Size
          Row(
            children: [
              const Icon(
                Icons.attach_file,
                size: 13,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                note.fileSize,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const Spacer(),
          const Divider(height: 20, color: AppColors.border),

          // Action Buttons: View, Download, Share
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onView,
                  icon: const Icon(Icons.visibility_outlined, size: 16),
                  label: const Text('View'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: const RoundedRadiusBorder(
                      borderRadius: AppRadius.smallBorderRadius,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onDownload,
                  icon: const Icon(Icons.download_outlined, size: 16),
                  label: const Text('Download'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,
                    shape: const RoundedRadiusBorder(
                      borderRadius: AppRadius.smallBorderRadius,
                    ),
                  ),
                ),
              ),
              if (onShare != null) ...[
                const SizedBox(width: 4),
                IconButton(
                  onPressed: onShare,
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  tooltip: 'Share',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Helper extension for rounded radius on button style
class RoundedRadiusBorder extends RoundedRectangleBorder {
  const RoundedRadiusBorder({required BorderRadius borderRadius})
      : super(borderRadius: borderRadius);
}
