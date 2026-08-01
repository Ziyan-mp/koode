import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../screens/complaints/create_complaint_screen.dart';

/// Reusable Complaint Categories Section widget for Home Screen
class ComplaintCategoriesSection extends StatelessWidget {
  final ValueChanged<String>? onCategorySelected;

  const ComplaintCategoriesSection({
    super.key,
    this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = const [
      _CategoryItem(
        title: 'Academic',
        icon: Icons.school_outlined,
      ),
      _CategoryItem(
        title: 'Hostel',
        icon: Icons.apartment_outlined,
      ),
      _CategoryItem(
        title: 'Transport',
        icon: Icons.directions_bus_outlined,
      ),
      _CategoryItem(
        title: 'Library',
        icon: Icons.menu_book_outlined,
      ),
      _CategoryItem(
        title: 'Cafeteria',
        icon: Icons.restaurant_outlined,
      ),
      _CategoryItem(
        title: 'Infrastructure',
        icon: Icons.domain_outlined,
      ),
      _CategoryItem(
        title: 'Others',
        icon: Icons.more_horiz,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complaint Categories',
          style: AppTextStyles.subHeading,
        ),
        AppSpacing.mdHeight,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return _CategoryCard(
              category: category,
              onTap: () {
                if (onCategorySelected != null) {
                  onCategorySelected!(category.title);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateComplaintScreen(
                        selectedCategory: category.title,
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class _CategoryItem {
  final String title;
  final IconData icon;

  const _CategoryItem({
    required this.title,
    required this.icon,
  });
}

class _CategoryCard extends StatelessWidget {
  final _CategoryItem category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.onTap,
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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category.icon,
                    color: AppColors.primary,
                    size: 26,
                  ),
                ),
                AppSpacing.smHeight,
                Text(
                  category.title,
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
