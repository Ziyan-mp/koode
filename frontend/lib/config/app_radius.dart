import 'package:flutter/material.dart';

/// Design System - Border Radius Constants
class AppRadius {
  AppRadius._();

  static const double small = 10.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 30.0;
  static const double pill = 999.0;

  // Radius Objects
  static const Radius smallRadiusObj = Radius.circular(small);
  static const Radius mediumRadiusObj = Radius.circular(medium);
  static const Radius largeRadiusObj = Radius.circular(large);
  static const Radius extraLargeRadiusObj = Radius.circular(extraLarge);
  static const Radius pillRadiusObj = Radius.circular(pill);

  // BorderRadius Helpers
  static const BorderRadius smallBorderRadius = BorderRadius.all(smallRadiusObj);
  static const BorderRadius mediumBorderRadius = BorderRadius.all(mediumRadiusObj);
  static const BorderRadius largeBorderRadius = BorderRadius.all(largeRadiusObj);
  static const BorderRadius extraLargeBorderRadius = BorderRadius.all(extraLargeRadiusObj);
  static const BorderRadius pillBorderRadius = BorderRadius.all(pillRadiusObj);
}
