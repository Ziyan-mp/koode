import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_routes.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/profile_service.dart';
import '../../widgets/common/app_background.dart';
import '../complaints/my_complaints_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() {
      _isLoading = true;
    });

    final currentUser = await _profileService.getUserProfile();

    if (currentUser == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
      return;
    }

    if (mounted) {
      setState(() {
        _user = currentUser;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  Future<void> _navigateToEditProfile() async {
    if (_user == null) return;
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(user: _user!),
      ),
    );
    if (result == true) {
      _loadProfileData();
    }
  }

  void _navigateToMyComplaints() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyComplaintsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: AppBackground(
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
      );
    }

    final user = _user!;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadProfileData,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: User Profile Header Card
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
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: AppColors.primaryLight,
                                  child: Text(
                                    user.fullName.isNotEmpty
                                        ? user.fullName[0].toUpperCase()
                                        : 'S',
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.fullName,
                                        style: AppTextStyles.heading.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        user.email,
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryLight,
                                          borderRadius:
                                              AppRadius.pillBorderRadius,
                                        ),
                                        child: Text(
                                          'Reg: ${user.studentId ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            AppSpacing.mdHeight,
                            const Divider(height: 1, color: AppColors.border),
                            AppSpacing.mdHeight,

                            // Academic & Contact Details Grid
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _InfoTile(
                                  label: 'Department',
                                  value: user.department,
                                  icon: Icons.school_outlined,
                                ),
                                Container(
                                  height: 30,
                                  width: 1,
                                  color: AppColors.border,
                                ),
                                _InfoTile(
                                  label: 'Semester / Year',
                                  value: user.yearSemester ?? 'N/A',
                                  icon: Icons.calendar_today_outlined,
                                ),
                                Container(
                                  height: 30,
                                  width: 1,
                                  color: AppColors.border,
                                ),
                                _InfoTile(
                                  label: 'Mobile',
                                  value: user.phoneNumber?.isNotEmpty == true
                                      ? user.phoneNumber!
                                      : 'N/A',
                                  icon: Icons.phone_outlined,
                                ),
                              ],
                            ),

                            AppSpacing.lgHeight,

                            // Edit Profile Button
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: _navigateToEditProfile,
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                ),
                                label: const Text(
                                  'EDIT PROFILE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: AppRadius.mediumBorderRadius,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  AppSpacing.lgHeight,

                  // Section 2: Menu Options List
                  const Text(
                    'Menu & Account Settings',
                    style: AppTextStyles.subHeading,
                  ),
                  AppSpacing.mdHeight,

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withAlpha(217),
                      borderRadius: AppRadius.largeBorderRadius,
                      boxShadow: AppShadows.light,
                    ),
                    child: Column(
                      children: [
                        _OptionTile(
                          icon: Icons.assignment_outlined,
                          title: 'My Complaints',
                          onTap: _navigateToMyComplaints,
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        _OptionTile(
                          icon: Icons.lock_outline,
                          title: 'Change Password',
                          onTap: _navigateToEditProfile,
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        _OptionTile(
                          icon: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.privacyPolicy,
                            );
                          },
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        _OptionTile(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Contact support@koode.campus'),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        _OptionTile(
                          icon: Icons.info_outline,
                          title: 'About Koode',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.aboutKoode,
                            );
                          },
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        _OptionTile(
                          icon: Icons.logout,
                          title: 'Logout',
                          isDestructive: true,
                          onTap: _handleLogout,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red.shade700 : AppColors.textPrimary;
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDestructive ? color : AppColors.primary,
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      trailing: isDestructive
          ? null
          : const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
    );
  }
}
