import 'package:flutter/material.dart';

/// Design System - Color Palette for Koode
class AppColors {
  AppColors._();

  // Core Brand Colors
  static const Color primary = Color(0xFF00A86B); // Friend's brand green
  static const Color primaryLight = Color(0xFFE0F2FE);
  static const Color primaryDark = Color(0xFF0284C7);

  static const Color secondary = Color(0xFF007AFF); // Friend's blue
  static const Color secondaryLight = Color(0xFFCFFAFE);

  static const Color accent = Color(0xFF0D9488);
  static const Color accentLight = Color(0xFFCCFBF1);

  // Background & Surface
  static const Color background = Color(0xFFE8F3F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE0F2FE),
      Color(0xFFF8FAFC),
    ],
  );

  // Feedback & Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFF87171);
  static const Color info = Color(0xFF38BDF8);

  // Typography Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);

  // UI Element Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFE2E8F0);
  static const Color disabled = Color(0xFFCBD5E1);
  static const Color grey = Color(0xFF94A3B8);

  // Utility Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}