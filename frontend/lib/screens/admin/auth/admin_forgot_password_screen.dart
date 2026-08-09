import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_radius.dart';
import '../../../config/app_shadows.dart';
import '../../../config/app_spacing.dart';
import '../../../config/app_text_styles.dart';
import '../../../services/admin_service.dart';
import '../../../services/auth_service.dart';
import '../../../utils/validators.dart';
import '../../../widgets/common/app_logo.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/primary_button.dart';

class AdminForgotPasswordScreen extends StatefulWidget {
  const AdminForgotPasswordScreen({super.key});

  @override
  State<AdminForgotPasswordScreen> createState() =>
      _AdminForgotPasswordScreenState();
}

class _AdminForgotPasswordScreenState extends State<AdminForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();
  final AdminService _adminService = AdminService();

  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isCodeSent = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  String? _simulatedCode;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Request admin reset link
  Future<void> _handleSendResetLink() async {
    if (_isLoading) return; // Prevent multiple requests
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final result = await _adminService.requestPasswordReset(email);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (result.status == AuthStatus.success) {
          setState(() {
            _isCodeSent = true;
            _simulatedCode = result.resetCode;
            if (_simulatedCode != null) {
              _codeController.text = _simulatedCode!;
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Password reset instructions have been sent to your email.',
              ),
              backgroundColor: AppColors.success,
              duration: Duration(seconds: 4),
            ),
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
    }
  }

  // Complete admin password reset
  Future<void> _handleResetPassword() async {
    if (_isLoading) return; // Prevent multiple requests
    FocusScope.of(context).unfocus();

    if (_resetFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final code = _codeController.text.trim();
      final newPassword = _newPasswordController.text;

      final result = await _adminService.resetPassword(
        email: email,
        token: code,
        newPassword: newPassword,
      );

      if (mounted) {
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

          // Return to Admin Login
          Navigator.pop(context);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Branding Header
                const Text(
                  "AN INITIATIVE OF UDSF CEV",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF004D61),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const AppLogo(
                  size: 64,
                  showTagline: true,
                ),
                const SizedBox(height: 24),

                // Form Container Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white.withAlpha(220),
                    borderRadius: AppRadius.largeBorderRadius,
                    border: Border.all(
                      color: const Color(0xFF004D61).withAlpha(100),
                      width: 1.5,
                    ),
                    boxShadow: AppShadows.medium,
                  ),
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: _isCodeSent
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: _buildEmailRequestStep(),
                    secondChild: _buildResetPasswordStep(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Step 1: Admin email entry & request reset link
  Widget _buildEmailRequestStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Admin Password Recovery",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          AppSpacing.xsHeight,
          const Text(
            "Enter your registered Admin ID (email) to reset your administrative access password.",
            style: AppTextStyles.caption,
          ),
          AppSpacing.lgHeight,

          // Admin ID Field
          CustomTextField(
            labelText: "Admin ID",
            hintText: "admin@campus.edu",
            prefixIcon: Icons.admin_panel_settings_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your Admin ID';
              }
              if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          AppSpacing.lgHeight,

          // Send Reset Link Button
          PrimaryButton(
            text: "Send Reset Link",
            isLoading: _isLoading,
            onPressed: _handleSendResetLink,
          ),
          const SizedBox(height: 12),

          // Back to Admin Login
          Center(
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 16,
                color: AppColors.secondary,
              ),
              label: const Text(
                "Back to Admin Login",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 2: Verification code and new admin password
  Widget _buildResetPasswordStep() {
    return Form(
      key: _resetFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () {
                  setState(() {
                    _isCodeSent = false;
                  });
                },
              ),
              const SizedBox(width: 8),
              const Text(
                "Set New Admin Password",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          AppSpacing.xsHeight,
          Text(
            "Enter the verification code sent to ${_emailController.text.trim()} and create a new password.",
            style: AppTextStyles.caption,
          ),
          AppSpacing.mdHeight,

          // Code Field
          CustomTextField(
            controller: _codeController,
            labelText: "Verification Code",
            hintText: "Enter 6-digit code",
            prefixIcon: Icons.pin_outlined,
            keyboardType: TextInputType.number,
            validator: (value) => Validators.requiredField(
              value,
              fieldName: "Verification code",
            ),
          ),
          AppSpacing.mdHeight,

          // New Password Field
          CustomTextField(
            labelText: "New Password",
            hintText: "••••••••",
            prefixIcon: Icons.lock_outline,
            obscureText: _obscureNewPassword,
            controller: _newPasswordController,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNewPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscureNewPassword = !_obscureNewPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a new password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          AppSpacing.mdHeight,

          // Confirm Password Field
          CustomTextField(
            labelText: "Confirm New Password",
            hintText: "••••••••",
            prefixIcon: Icons.lock_reset_outlined,
            obscureText: _obscureConfirmPassword,
            controller: _confirmPasswordController,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (value) => Validators.confirmPassword(
              value,
              _newPasswordController.text,
            ),
          ),
          AppSpacing.lgHeight,

          // Reset Button
          PrimaryButton(
            text: "Update Admin Password",
            isLoading: _isLoading,
            onPressed: _handleResetPassword,
          ),
          const SizedBox(height: 8),

          // Resend Code Option
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive instructions?",
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
              TextButton(
                onPressed: _isLoading ? null : _handleSendResetLink,
                child: Text(
                  'Resend',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Back to Admin Login
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Back to Admin Login",
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
