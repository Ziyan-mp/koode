import 'package:flutter/material.dart';

/// Design System - Color Palette for Koode
class AppColors {
  AppColors._();

  // Core Brand Colors
  static const Color primary = Color(0xFF0EA5E9); // Soft Sky Blue
  static const Color primaryLight = Color(0xFFE0F2FE);
  static const Color primaryDark = Color(0xFF0284C7);

  static const Color secondary = Color(0xFF06B6D4); // Light Aqua
  static const Color secondaryLight = Color(0xFFCFFAFE);

  static const Color accent = Color(0xFF0D9488); // Teal Green
  static const Color accentLight = Color(0xFFCCFBF1);

  // Background & Surface
  static const Color background = Color(0xFFF0F9FF); // Very Light Sky Blue
  static const Color surface = Color(0xFFFFFFFF); // Pure White Surface
  static const Color card = Color(0xFFFFFFFF); // Card Surface White

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE0F2FE),
      Color(0xFFF8FAFC),
    ],
  );

  // Feedback & Status Colors
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFF87171); // Soft Red
  static const Color info = Color(0xFF38BDF8); // Info Blue

  // Typography Colors
  static const Color textPrimary = Color(0xFF0F172A); // Dark Navy
  static const Color textSecondary = Color(0xFF64748B); // Soft Slate

  // UI Element Colors
  static const Color border = Color(0xFFE2E8F0); // Very Light Grey-Blue
  static const Color divider = Color(0xFFE2E8F0); // Very Light Grey-Blue
  static const Color disabled = Color(0xFFCBD5E1); // Muted Slate
  static const Color grey = Color(0xFF94A3B8); // Soft Grey

  // Utility Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}