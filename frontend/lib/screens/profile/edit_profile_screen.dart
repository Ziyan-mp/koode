import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../models/user_model.dart';
import '../../services/profile_service.dart';
import '../../utils/validators.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProfileService _profileService = ProfileService();

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _studentIdController;
  late TextEditingController _phoneController;
  late TextEditingController _departmentController;
  late TextEditingController _yearSemesterController;
  late TextEditingController _passwordController;

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user.fullName);
    _emailController = TextEditingController(text: widget.user.email);
    _studentIdController = TextEditingController(text: widget.user.studentId ?? 'N/A');
    _phoneController = TextEditingController(text: widget.user.phoneNumber ?? '');
    _departmentController = TextEditingController(text: widget.user.department);
    _yearSemesterController = TextEditingController(text: widget.user.yearSemester ?? '');
    _passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    _yearSemesterController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final updatedUser = widget.user.copyWith(
        fullName: _fullNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        department: _departmentController.text.trim(),
        yearSemester: _yearSemesterController.text.trim(),
        password: _passwordController.text,
      );

      final success = await _profileService.updateProfile(updatedUser);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update profile.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // App Bar Row with Back Button
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Edit Profile',
                        style: AppTextStyles.heading,
                      ),
                    ],
                  ),

                  AppSpacing.lgHeight,

                  // Profile Card Form
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
                            // Avatar Icon
                            Center(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundColor: AppColors.primaryLight,
                                    child: Text(
                                      widget.user.fullName.isNotEmpty
                                          ? widget.user.fullName[0].toUpperCase()
                                          : 'S',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 16,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            AppSpacing.lgHeight,

                            // Full Name (Editable)
                            CustomTextField(
                              controller: _fullNameController,
                              labelText: 'Full Name',
                              prefixIcon: Icons.person_outline,
                              validator: (val) => Validators.requiredField(
                                val,
                                fieldName: 'Full Name',
                              ),
                            ),
                            AppSpacing.mdHeight,

                            // Student Email (Read Only)
                            CustomTextField(
                              controller: _emailController,
                              labelText: 'Student Email (Read Only)',
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: null,
                            ),
                            AppSpacing.mdHeight,

                            // Register Number (Read Only)
                            CustomTextField(
                              controller: _studentIdController,
                              labelText: 'Register Number (Read Only)',
                              prefixIcon: Icons.badge_outlined,
                              validator: null,
                            ),
                            AppSpacing.mdHeight,

                            // Phone Number (Editable)
                            CustomTextField(
                              controller: _phoneController,
                              labelText: 'Mobile Number',
                              prefixIcon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validator: Validators.phoneNumber,
                            ),
                            AppSpacing.mdHeight,

                            // Department (Editable)
                            CustomTextField(
                              controller: _departmentController,
                              labelText: 'Department',
                              prefixIcon: Icons.school_outlined,
                              validator: (val) => Validators.requiredField(
                                val,
                                fieldName: 'Department',
                              ),
                            ),
                            AppSpacing.mdHeight,

                            // Semester/Year (Editable)
                            CustomTextField(
                              controller: _yearSemesterController,
                              labelText: 'Semester / Year',
                              prefixIcon: Icons.calendar_today_outlined,
                              validator: (val) => Validators.requiredField(
                                val,
                                fieldName: 'Semester / Year',
                              ),
                            ),
                            AppSpacing.mdHeight,

                            // Password (Editable)
                            CustomTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              prefixIcon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              validator: Validators.password,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),

                            AppSpacing.lgHeight,

                            // Save Changes Button
                            PrimaryButton(
                              text: 'SAVE CHANGES',
                              isLoading: _isLoading,
                              onPressed: _saveProfile,
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
      ),
    );
  }
}
