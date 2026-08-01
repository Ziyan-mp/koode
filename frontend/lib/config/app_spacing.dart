import 'package:flutter/material.dart';

/// Design System - Spacing System
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // EdgeInsets Shortcuts
  static const EdgeInsets xsPadding = EdgeInsets.all(xs);
  static const EdgeInsets smPadding = EdgeInsets.all(sm);
  static const EdgeInsets mdPadding = EdgeInsets.all(md);
  static const EdgeInsets lgPadding = EdgeInsets.all(lg);
  static const EdgeInsets xlPadding = EdgeInsets.all(xl);

  // Horizontal Padding
  static const EdgeInsets smHorizontal = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets mdHorizontal = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets lgHorizontal = EdgeInsets.symmetric(horizontal: lg);

  // Vertical Padding
  static const EdgeInsets smVertical = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets mdVertical = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets lgVertical = EdgeInsets.symmetric(vertical: lg);

  // SizedBox Helpers
  static const Widget xsHeight = SizedBox(height: xs);
  static const Widget smHeight = SizedBox(height: sm);
  static const Widget mdHeight = SizedBox(height: md);
  static const Widget lgHeight = SizedBox(height: lg);
  static const Widget xlHeight = SizedBox(height: xl);
  static const Widget xxlHeight = SizedBox(height: xxl);

  static const Widget xsWidth = SizedBox(width: xs);
  static const Widget smWidth = SizedBox(width: sm);
  static const Widget mdWidth = SizedBox(width: md);
  static const Widget lgWidth = SizedBox(width: lg);
  static const Widget xlWidth = SizedBox(width: xl);
  static const Widget xxlWidth = SizedBox(width: xxl);
}
