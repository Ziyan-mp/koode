import 'package:flutter/material.dart';
import '../config/app_routes.dart';
import '../screens/admin/auth/admin_forgot_password_screen.dart';
import '../screens/admin/auth/admin_login_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/complaints/create_complaint_screen.dart';
import '../screens/home/student_main_screen.dart';
import '../screens/profile/about_koode_screen.dart';
import '../screens/profile/privacy_policy_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.adminLogin:
        return MaterialPageRoute(builder: (_) => const AdminLoginScreen());
      case AppRoutes.adminForgotPassword:
        return MaterialPageRoute(builder: (_) => const AdminForgotPasswordScreen());
      case AppRoutes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case AppRoutes.aboutKoode:
        return MaterialPageRoute(builder: (_) => const AboutKoodeScreen());
      case AppRoutes.createComplaint:
        final category = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => CreateComplaintScreen(selectedCategory: category),
        );
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const StudentMainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
