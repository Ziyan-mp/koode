import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design System - Elevation & Shadows
class AppShadows {
  AppShadows._();

  static const List<BoxShadow> light = [
    BoxShadow(
      color: Color(0x0C0E7490),
      blurRadius: 10,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x180EA5E9),
      blurRadius: 20,
      spreadRadius: 0,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> heavy = [
    BoxShadow(
      color: Color(0x220D9488),
      blurRadius: 30,
      spreadRadius: 0,
      offset: Offset(0, 10),
    ),
  ];

  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: AppColors.accent.withAlpha(80),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}
