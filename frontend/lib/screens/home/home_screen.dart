import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/common/app_background.dart';
import '../complaints/create_complaint_screen.dart';

/// Production-Grade Home Screen for Koode – Your Voice, Your Campus
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Page Controller & Timer for Auto-Sliding Event Banners
  late final PageController _pageController;
  Timer? _bannerTimer;
  int _currentBannerIndex = 0;

  // Bottom Navigation Index
  int _selectedBottomNavIndex = 0;

  // Event Banner Dummy Data
  final List<_EventBannerItem> _events = const [
    _EventBannerItem(
      title: 'Annual Cultural Fest',
      date: '15–17 August',
      location: 'College Auditorium',
      description: 'Celebrate talent, music & arts across campus',
      gradientColors: [AppColors.primary, AppColors.secondary],
      icon: Icons.festival_outlined,
    ),
    _EventBannerItem(
      title: 'Hackathon 2026',
      date: '22–23 August',
      location: 'Tech Hub Lab',
      description: '24-hour coding marathon & innovation challenge',
      gradientColors: [AppColors.secondary, AppColors.accent],
      icon: Icons.code_rounded,
    ),
    _EventBannerItem(
      title: 'Placement Drive',
      date: '05 September',
      location: 'Main Hall',
      description: 'Meet top campus recruiters and career advisors',
      gradientColors: [AppColors.accent, AppColors.primary],
      icon: Icons.work_outline_rounded,
    ),
    _EventBannerItem(
      title: 'Sports Meet',
      date: '12–14 September',
      location: 'Campus Grounds',
      description: 'Annual inter-departmental athletic tournament',
      gradientColors: [AppColors.primaryDark, AppColors.primary],
      icon: Icons.sports_soccer_rounded,
    ),
  ];

  // 12 Complaint Categories Data
  final List<_CategoryData> _categories = const [
    _CategoryData(title: 'Classroom', icon: Icons.class_outlined),
    _CategoryData(title: 'Laboratory', icon: Icons.science_outlined),
    _CategoryData(title: 'Library', icon: Icons.menu_book_outlined),
    _CategoryData(title: 'Hostel', icon: Icons.apartment_outlined),
    _CategoryData(title: 'Bus', icon: Icons.directions_bus_outlined),
    _CategoryData(title: 'Electricity', icon: Icons.bolt_outlined),
    _CategoryData(title: 'Water', icon: Icons.water_drop_outlined),
    _CategoryData(title: 'Canteen', icon: Icons.restaurant_outlined),
    _CategoryData(title: 'Cleanliness', icon: Icons.cleaning_services_outlined),
    _CategoryData(title: 'Sports', icon: Icons.sports_soccer_outlined),
    _CategoryData(title: 'Internet', icon: Icons.wifi_outlined),
    _CategoryData(title: 'Others', icon: Icons.more_horiz_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Auto-slide banner every 5 seconds
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_pageController.hasClients) return;
      final nextIndex = (_currentBannerIndex + 1) % _events.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Welcome Header
                const _WelcomeHeader(studentName: 'Labeeba'),

                AppSpacing.lgHeight,

                // Section 2 & 3: Auto Sliding Event Banner (Height 200)
                _EventBannerSlider(
                  events: _events,
                  pageController: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                ),

                AppSpacing.smHeight,

                // Section 4: Animated Page Indicator
                _PageIndicator(
                  count: _events.length,
                  currentIndex: _currentBannerIndex,
                ),

                AppSpacing.lgHeight,

                // Section 5: Complaint Categories Grid
                const Text(
                  'Complaint Categories',
                  style: AppTextStyles.heading,
                ),

                AppSpacing.mdHeight,

                _CategoryGrid(
                  categories: _categories,
                  isTablet: isTablet,
                ),

                // Bottom Spacing for FAB & Navigation
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),

      // Section 6: Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateComplaintScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: AppColors.white,
          size: 28,
        ),
      ),

      // Section 7: Material 3 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface.withAlpha(240),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/* ============================================================================
 * Helper Widgets & Data Models
 * ============================================================================ */

/// Welcome Header Section (Good Morning 👋, Student Name, Avatar with Logo)
class _WelcomeHeader extends StatelessWidget {
  final String studentName;

  const _WelcomeHeader({required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(217),
        borderRadius: AppRadius.largeBorderRadius,
        boxShadow: AppShadows.light,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning 👋',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpacing.xsHeight,
                Text(
                  studentName,
                  style: AppTextStyles.display.copyWith(
                    fontSize: 26,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            AppAssets.logo,
            width: 56,
            height: 56,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

/// Auto-Sliding Event Banner Slider Widget (Height: 200)
class _EventBannerSlider extends StatelessWidget {
  final List<_EventBannerItem> events;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const _EventBannerSlider({
    required this.events,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return _EventBannerCard(event: event);
        },
      ),
    );
  }
}

/// Single Event Banner Card
class _EventBannerCard extends StatelessWidget {
  final _EventBannerItem event;

  const _EventBannerCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        borderRadius: AppRadius.largeBorderRadius,
        gradient: LinearGradient(
          colors: event.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.largeBorderRadius,
        child: Stack(
          children: [
            // Decorative background pattern circles
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withAlpha(25),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: -40,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withAlpha(20),
                ),
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Event Date & Location Tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.white.withAlpha(45),
                            borderRadius: AppRadius.pillBorderRadius,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.event_outlined,
                                size: 14,
                                color: AppColors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${event.date} • ${event.location}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.smHeight,

                        // Title
                        Text(
                          event.title,
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Subtitle
                        Text(
                          event.description,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.white.withAlpha(220),
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSpacing.smHeight,

                        // Register Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primaryDark,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.pillBorderRadius,
                            ),
                          ),
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Event Theme Icon Container
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withAlpha(35),
                      border: Border.all(
                        color: AppColors.white.withAlpha(80),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      event.icon,
                      size: 34,
                      color: AppColors.white,
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

/// Animated Page Indicator Component (● ○ ○ ○)
class _PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _PageIndicator({
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: isActive ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.grey.withAlpha(100),
            borderRadius: AppRadius.pillBorderRadius,
          ),
        );
      }),
    );
  }
}

/// Responsive Grid View of Complaint Categories
class _CategoryGrid extends StatelessWidget {
  final List<_CategoryData> categories;
  final bool isTablet;

  const _CategoryGrid({
    required this.categories,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 4 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isTablet ? 1.4 : 1.35,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(category: category);
      },
    );
  }
}

/// Single Complaint Category Card Widget (White with 85% opacity, rounded corners, soft shadow)
class _CategoryCard extends StatelessWidget {
  final _CategoryData category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(217),
        borderRadius: AppRadius.mediumBorderRadius,
        boxShadow: AppShadows.light,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.mediumBorderRadius,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateComplaintScreen(
                  selectedCategory: category.title,
                ),
              ),
            );
          },
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

/// Data Model for Event Banner
class _EventBannerItem {
  final String title;
  final String date;
  final String location;
  final String description;
  final List<Color> gradientColors;
  final IconData icon;

  const _EventBannerItem({
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.gradientColors,
    required this.icon,
  });
}

/// Data Model for Complaint Category
class _CategoryData {
  final String title;
  final IconData icon;

  const _CategoryData({
    required this.title,
    required this.icon,
  });
}
