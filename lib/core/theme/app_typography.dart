import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Roboto';

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static TextTheme get lightTextTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: regular,
        height: 1.12,
        letterSpacing: -0.25,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: regular,
        height: 1.16,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: regular,
        height: 1.22,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: regular,
        height: 1.25,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: regular,
        height: 1.29,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: regular,
        height: 1.33,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: regular,
        height: 1.27,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: medium,
        height: 1.5,
        letterSpacing: 0.15,
        color: AppColors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: medium,
        height: 1.43,
        letterSpacing: 0.1,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: regular,
        height: 1.5,
        letterSpacing: 0.5,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: regular,
        height: 1.43,
        letterSpacing: 0.25,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: regular,
        height: 1.33,
        letterSpacing: 0.4,
        color: AppColors.textPrimary,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: medium,
        height: 1.43,
        letterSpacing: 0.1,
        color: AppColors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: medium,
        height: 1.33,
        letterSpacing: 0.5,
        color: AppColors.textPrimary,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: medium,
        height: 1.45,
        letterSpacing: 0.5,
        color: AppColors.textPrimary,
      ),
    );
  }

  static TextTheme get darkTextTheme {
    return lightTextTheme.copyWith(
      displayLarge: lightTextTheme.displayLarge?.copyWith(
        color: AppColors.textOnBrown,
      ),
      displayMedium: lightTextTheme.displayMedium?.copyWith(
        color: AppColors.textOnBrown,
      ),
      displaySmall: lightTextTheme.displaySmall?.copyWith(
        color: AppColors.textOnBrown,
      ),
      headlineLarge: lightTextTheme.headlineLarge?.copyWith(
        color: AppColors.textOnBrown,
      ),
      headlineMedium: lightTextTheme.headlineMedium?.copyWith(
        color: AppColors.textOnBrown,
      ),
      headlineSmall: lightTextTheme.headlineSmall?.copyWith(
        color: AppColors.textOnBrown,
      ),
      titleLarge: lightTextTheme.titleLarge?.copyWith(
        color: AppColors.textOnBrown,
      ),
      titleMedium: lightTextTheme.titleMedium?.copyWith(
        color: AppColors.textOnBrown,
      ),
      titleSmall: lightTextTheme.titleSmall?.copyWith(
        color: AppColors.textOnBrown,
      ),
      bodyLarge: lightTextTheme.bodyLarge?.copyWith(
        color: AppColors.textOnBrown,
      ),
      bodyMedium: lightTextTheme.bodyMedium?.copyWith(
        color: AppColors.textOnBrown,
      ),
      bodySmall: lightTextTheme.bodySmall?.copyWith(
        color: AppColors.textOnBrown,
      ),
      labelLarge: lightTextTheme.labelLarge?.copyWith(
        color: AppColors.textOnBrown,
      ),
      labelMedium: lightTextTheme.labelMedium?.copyWith(
        color: AppColors.textOnBrown,
      ),
      labelSmall: lightTextTheme.labelSmall?.copyWith(
        color: AppColors.textOnBrown,
      ),
    );
  }

  static TextStyle get cardTitle {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: semiBold,
      height: 1.33,
      letterSpacing: 0,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get cardSubtitle {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: regular,
      height: 1.43,
      letterSpacing: 0.25,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle get buttonPrimary {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: medium,
      height: 1.5,
      letterSpacing: 0.15,
      color: AppColors.buttonPrimaryText,
    );
  }

  static TextStyle get buttonSecondary {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: medium,
      height: 1.5,
      letterSpacing: 0.15,
      color: AppColors.buttonSecondaryText,
    );
  }

  static TextStyle get navigationLabel {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: medium,
      height: 1.33,
      letterSpacing: 0.5,
      color: AppColors.navigationUnselectedText,
    );
  }

  static TextStyle get navigationLabelSelected {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: medium,
      height: 1.33,
      letterSpacing: 0.5,
      color: AppColors.navigationSelectedText,
    );
  }

  static TextStyle get inputLabel {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: medium,
      height: 1.43,
      letterSpacing: 0.1,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get inputHint {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: regular,
      height: 1.5,
      letterSpacing: 0.5,
      color: AppColors.inputHint,
    );
  }

  static TextStyle get appBarTitle {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: medium,
      height: 1.4,
      letterSpacing: 0,
      color: AppColors.appBarText,
    );
  }

  static TextStyle get errorText {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: regular,
      height: 1.33,
      letterSpacing: 0.4,
      color: AppColors.accentError,
    );
  }

  static TextStyle get successText {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: regular,
      height: 1.33,
      letterSpacing: 0.4,
      color: AppColors.accentSuccess,
    );
  }

  static TextStyle get warningText {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: regular,
      height: 1.33,
      letterSpacing: 0.4,
      color: AppColors.accentWarning,
    );
  }

  static TextStyle get infoText {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: regular,
      height: 1.33,
      letterSpacing: 0.4,
      color: AppColors.accentInfo,
    );
  }

  static TextStyle get bodySmall {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: regular,
      height: 1.33,
      letterSpacing: 0.4,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get bodyLarge {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: regular,
      height: 1.5,
      letterSpacing: 0.5,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get bodyMedium {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: regular,
      height: 1.43,
      letterSpacing: 0.25,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get headlineSmall {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      fontWeight: regular,
      height: 1.33,
      letterSpacing: 0,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get titleMedium {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: medium,
      height: 1.5,
      letterSpacing: 0.15,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get labelSmall {
    return const TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      fontWeight: medium,
      height: 1.45,
      letterSpacing: 0.5,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get titleLarge {
    return lightTextTheme.titleLarge!;
  }

  static TextStyle get headlineMedium {
    return lightTextTheme.headlineMedium!;
  }
}
