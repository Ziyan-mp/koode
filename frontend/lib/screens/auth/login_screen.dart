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
import '../admin/auth/admin_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final password = _passwordController.text;

      final result = await _authService.login(
        email: email,
        password: password,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (result.status == AuthStatus.success) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.home,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.message),
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
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: AppSpacing.lgHorizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSpacing.xlHeight,

                  // Logo, Title & Tagline
                  const AppLogo(
                    size: 80,
                    showTagline: true,
                  ),

                  AppSpacing.xxlHeight,

                  // Translucent Glassmorphism Form Card (85% Opacity)
                  ClipRRect(
                    borderRadius: AppRadius.extraLargeBorderRadius,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withAlpha(217),
                          borderRadius: AppRadius.extraLargeBorderRadius,
                          border: Border.all(
                            color: AppColors.white.withAlpha(200),
                            width: 1.5,
                          ),
                          boxShadow: AppShadows.medium,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome Back',
                                style: AppTextStyles.heading,
                              ),
                              AppSpacing.xsHeight,
                              const Text(
                                'Sign in to access your campus dashboard',
                                style: AppTextStyles.caption,
                              ),
                              AppSpacing.lgHeight,

                              // Student Email Field
                              CustomTextField(
                                controller: _emailController,
                                labelText: 'Student Email',
                                hintText: 'student@campus.edu',
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.email,
                              ),
                              AppSpacing.mdHeight,

                              // Password Field
                              CustomTextField(
                                controller: _passwordController,
                                labelText: 'Password',
                                hintText: '••••••••',
                                prefixIcon: Icons.lock_outline,
                                obscureText: _obscurePassword,
                                validator: Validators.password,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              AppSpacing.xsHeight,

                              // Forgot Password Button
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              AppSpacing.mdHeight,

                              // Primary Login Button
                              PrimaryButton(
                                text: 'LOGIN',
                                isLoading: _isLoading,
                                onPressed: _login,
                              ),
                              AppSpacing.mdHeight,

                              // Register Navigation Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style: AppTextStyles.caption,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.register,
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              // Admin Login Button
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminLoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Login as Admin",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
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