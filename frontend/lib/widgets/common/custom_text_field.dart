import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_radius.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;

  // Keyboard / focus behavior
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.textSecondary,
              )
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.mediumBorderRadius,
          borderSide: BorderSide(
            color: AppColors.border,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mediumBorderRadius,
          borderSide: BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mediumBorderRadius,
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mediumBorderRadius,
          borderSide: BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mediumBorderRadius,
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}