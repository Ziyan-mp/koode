import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_radius.dart';
import '../../config/app_shadows.dart';
import '../../config/app_spacing.dart';
import '../../config/app_text_styles.dart';
import '../../config/app_routes.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Full-screen Illustrated Sky Gradient Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),

          // 2. Floating Abstract Shapes & Decorative Background Elements
          Positioned(
            top: -size.width * 0.25,
            right: -size.width * 0.2,
            child: Container(
              width: size.width * 0.75,
              height: size.width * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight.withAlpha(90),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.12,
            left: -size.width * 0.15,
            child: Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryLight.withAlpha(110),
              ),
            ),
          ),

          Positioned(
            bottom: size.height * 0.05,
            right: -size.width * 0.1,
            child: Container(
              width: size.width * 0.6,
              height: size.width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentLight.withAlpha(100),
              ),
            ),
          ),

          // Subtle Floating Geometric Cloud Shapes
          Positioned(
            top: size.height * 0.08,
            right: size.width * 0.1,
            child: Icon(
              Icons.cloud_queue_rounded,
              size: 48,
              color: AppColors.white.withAlpha(180),
            ),
          ),

          Positioned(
            top: size.height * 0.16,
            left: size.width * 0.12,
            child: Icon(
              Icons.flutter_dash,
              size: 32,
              color: AppColors.accent.withAlpha(120),
            ),
          ),

          // 3. Foreground Scrollable Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: AppSpacing.lgHorizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSpacing.xlHeight,

                    // Koode Logo (Malayalam "കൂടെ") & Tagline
                    const AppLogo(
                      size: 80,
                      showTagline: true,
                    ),

                    AppSpacing.xxlHeight,

                    // Glassmorphism Soft Translucent Form Card
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
                            color: AppColors.white.withAlpha(220),
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
                              ),
                              AppSpacing.mdHeight,

                              // Password Field
                              CustomTextField(
                                controller: _passwordController,
                                labelText: 'Password',
                                hintText: '••••••••',
                                prefixIcon: Icons.lock_outline,
                                obscureText: _obscurePassword,
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
                                  onPressed: () {
                                    // Forgot Password action placeholder
                                  },
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

                              // Primary Login Button (Teal-Green to Aqua Gradient)
                              PrimaryButton(
                                text: 'LOGIN',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.home,
                                  );
                                },
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
                            ],
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
        ],
      ),
    );
  }
}