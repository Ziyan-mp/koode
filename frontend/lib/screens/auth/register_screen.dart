import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_routes.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Form Key for validation
  final _formKey = GlobalKey<FormState>();

  // Screen State Variables
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _selectedDepartment;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _departmentController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final List<String> _departments = const [
    'Computer Science',
    'Information Technology',
    'Electronics',
    'Electrical',
    'Mechanical',
    'Civil',
    'Commerce',
    'Management',
    'Other',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _departmentController.dispose();
    _studentIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles Form Validation, Focus Unfocusing, and Simulated Registration
  Future<void> _register() async {
    // Dismiss active keyboard
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate async registration API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        debugPrint("Registration Successful");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: GestureDetector(
          // Dismiss keyboard when tapping outside input fields
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppLogo(
                      size: 80,
                      showTagline: true,
                    ),
                    AppSpacing.lgHeight,

                    // Translucent Card wrapping Registration Form
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
                              const Text(
                                'Create Account',
                                style: AppTextStyles.heading,
                              ),
                              AppSpacing.xsHeight,
                              Text(
                                'Register to access Koode',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              AppSpacing.lgHeight,

                              CustomTextField(
                                controller: _fullNameController,
                                labelText: 'Full Name',
                                hintText: 'Enter your full name',
                                prefixIcon: Icons.person_outline,
                                validator: (value) => Validators.requiredField(
                                  value,
                                  fieldName: 'Full Name',
                                ),
                              ),
                              AppSpacing.mdHeight,

                              CustomTextField(
                                controller: _emailController,
                                labelText: 'Email Address',
                                hintText: 'Enter your college email',
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.email,
                              ),
                              AppSpacing.mdHeight,

                              CustomTextField(
                                controller: _phoneNumberController,
                                labelText: 'Phone Number',
                                hintText: 'Enter your mobile number',
                                prefixIcon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone,
                                validator: Validators.phoneNumber,
                              ),
                              AppSpacing.mdHeight,

                              DropdownButtonFormField<String>(
                                initialValue: _selectedDepartment,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDepartment = value;
                                    _departmentController.text = value ?? '';
                                  });
                                },
                                validator: (value) => Validators.requiredField(
                                  value,
                                  fieldName: 'Department',
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Department',
                                  hintText: 'Select your department',
                                  prefixIcon: Icon(
                                    Icons.school_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.surface,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: AppRadius.mediumBorderRadius,
                                    borderSide: BorderSide(color: AppColors.border),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: AppRadius.mediumBorderRadius,
                                    borderSide: BorderSide(color: AppColors.border),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: AppRadius.mediumBorderRadius,
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: AppRadius.mediumBorderRadius,
                                    borderSide: BorderSide(color: AppColors.error),
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.textPrimary,
                                ),
                                items: _departments.map((dept) {
                                  return DropdownMenuItem<String>(
                                    value: dept,
                                    child: Text(dept),
                                  );
                                }).toList(),
                              ),
                              AppSpacing.mdHeight,

                              CustomTextField(
                                controller: _studentIdController,
                                labelText: 'Student ID',
                                hintText: 'Enter your student ID',
                                prefixIcon: Icons.badge_outlined,
                                keyboardType: TextInputType.text,
                                validator: (value) => Validators.requiredField(
                                  value,
                                  fieldName: 'Student ID',
                                ),
                              ),
                              AppSpacing.mdHeight,

                              CustomTextField(
                                controller: _passwordController,
                                labelText: 'Password',
                                hintText: 'Create a password',
                                prefixIcon: Icons.lock_outline,
                                obscureText: _obscurePassword,
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
                                validator: Validators.password,
                              ),
                              AppSpacing.mdHeight,

                              CustomTextField(
                                controller: _confirmPasswordController,
                                labelText: 'Confirm Password',
                                hintText: 'Re-enter your password',
                                prefixIcon: Icons.lock_reset_outlined,
                                obscureText: _obscureConfirmPassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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
                                  _passwordController.text,
                                ),
                              ),
                              AppSpacing.lgHeight,

                              // Submit Registration Button
                              PrimaryButton(
                                text: 'REGISTER',
                                isLoading: _isLoading,
                                onPressed: _register,
                              ),
                              AppSpacing.mdHeight,

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        AppRoutes.login,
                                      );
                                    },
                                    child: Text(
                                      'Login',
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}