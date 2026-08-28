import 'dart:ui';

import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_routes.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../services/auth_service.dart';
import '../../utils/validators.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_isLoading) return;

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final newPassword = _newPasswordController.text;

    /*
     * Simple password reset.
     *
     * The backend should identify the student using the email
     * and securely update the password.
     *
     * If your current AuthService still requires a verification
     * token, we will update AuthService/backend next.
     */

    final result = await _authService.resetPassword(
      email: email,
      token: '',
      newPassword: newPassword,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result.status == AuthStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset successfully! Please login with your new password.',
          ),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 3),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: AppSpacing.lgHorizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSpacing.xlHeight,

                  // Koode Logo
                  const AppLogo(
                    size: 80,
                    showTagline: true,
                  ),

                  AppSpacing.xxlHeight,

                  // Glassmorphism Card
                  ClipRRect(
                    borderRadius: AppRadius.extraLargeBorderRadius,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 12,
                        sigmaY: 12,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withAlpha(217),
                          borderRadius:
                              AppRadius.extraLargeBorderRadius,
                          border: Border.all(
                            color: AppColors.white.withAlpha(200),
                            width: 1.5,
                          ),
                          boxShadow: AppShadows.medium,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Forgot Password?',
                                style: AppTextStyles.heading,
                              ),

                              AppSpacing.xsHeight,

                              const Text(
                                'Enter your registered email and create a new password.',
                                style: AppTextStyles.caption,
                              ),

                              AppSpacing.lgHeight,

                              // Email
                              CustomTextField(
                                controller: _emailController,
                                labelText: 'Student Email',
                                hintText: 'student@campus.edu',
                                prefixIcon: Icons.email_outlined,
                                keyboardType:
                                    TextInputType.emailAddress,
                                textInputAction:
                                    TextInputAction.next,
                                validator: Validators.email,
                              ),

                              AppSpacing.mdHeight,

                              // New Password
                              CustomTextField(
                                controller: _newPasswordController,
                                labelText: 'New Password',
                                hintText: '••••••••',
                                prefixIcon: Icons.lock_outline,
                                obscureText:
                                    _obscureNewPassword,
                                textInputAction:
                                    TextInputAction.next,
                                validator: Validators.password,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureNewPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color:
                                        AppColors.textSecondary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureNewPassword =
                                          !_obscureNewPassword;
                                    });
                                  },
                                ),
                              ),

                              AppSpacing.mdHeight,

                              // Confirm Password
                              CustomTextField(
                                controller:
                                    _confirmPasswordController,
                                labelText: 'Confirm New Password',
                                hintText: '••••••••',
                                prefixIcon:
                                    Icons.lock_reset_outlined,
                                obscureText:
                                    _obscureConfirmPassword,
                                textInputAction:
                                    TextInputAction.done,
                                validator: (value) =>
                                    Validators.confirmPassword(
                                  value,
                                  _newPasswordController.text,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color:
                                        AppColors.textSecondary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                                onSubmitted: (_) {
                                  _resetPassword();
                                },
                              ),

                              AppSpacing.lgHeight,

                              // Reset Password
                              PrimaryButton(
                                text: 'RESET PASSWORD',
                                isLoading: _isLoading,
                                onPressed: _resetPassword,
                              ),

                              AppSpacing.mdHeight,

                              // Back to Login
                              Center(
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.login,
                                      (route) => false,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  label: Text(
                                    'Back to Login',
                                    style: AppTextStyles.caption
                                        .copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
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

                  AppSpacing.xlHeight,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}