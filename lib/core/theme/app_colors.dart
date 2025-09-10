import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryBrown = Color(0xFF8B4513);
  static const Color primaryBrownLight = Color(0xFFA0522D);
  static const Color primaryBrownDark = Color(0xFF654321);
  static const Color primaryBrownVariant = Color(0xFFCD853F);

  static const Color secondaryBeige = Color(0xFFF5F5DC);
  static const Color secondaryBeigeLight = Color(0xFFFAEBD7);
  static const Color secondaryBeigeDark = Color(0xFFE6E6D2);
  static const Color secondaryBeigeVariant = Color(0xFFF0E68C);

  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralOffWhite = Color(0xFFF8F8F8);
  static const Color neutralLightGray = Color(0xFFE5E5E5);
  static const Color neutralMediumGray = Color(0xFFB0B0B0);
  static const Color neutralDarkGray = Color(0xFF666666);
  static const Color neutralBlack = Color(0xFF333333);

  static const Color accentSuccess = Color(0xFF4CAF50);
  static const Color accentSuccessLight = Color(0xFF81C784);
  static const Color accentSuccessDark = Color(0xFF388E3C);
  static const Color accentWarning = Color(0xFFFF9800);
  static const Color accentWarningLight = Color(0xFFFFB74D);
  static const Color accentWarningDark = Color(0xFFF57C00);
  static const Color accentError = Color(0xFFF44336);
  static const Color accentErrorLight = Color(0xFFEF5350);
  static const Color accentErrorDark = Color(0xFFD32F2F);
  static const Color accentInfo = Color(0xFF2196F3);
  static const Color accentInfoLight = Color(0xFF64B5F6);
  static const Color accentInfoDark = Color(0xFF1976D2);

  static const Color surfaceBeige = Color(0xFFF5F5DC);
  static const Color surfaceBeigeElevated = Color(0xFFFAEBD7);
  static const Color surfaceBeigeModal = Color(0xFFF0E68C);
  static const Color surfaceBrown = Color(0xFF8B4513);
  static const Color surfaceBrownLight = Color(0xFFA0522D);

  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFFB0B0B0);
  static const Color textOnBrown = Color(0xFFFFFFFF);
  static const Color textOnBeige = Color(0xFF333333);

  static const Color stateHover = Color(0xFFCD853F);
  static const Color statePressed = Color(0xFFA0522D);
  static const Color stateDisabled = Color(0xFFE5E5E5);
  static const Color stateFocus = Color(0xFF8B4513);

  static const Color cardBackground = Color(0xFFFAEBD7);
  static const Color cardBorder = Color(0xFFCD853F);
  static const Color cardShadow = Color(0x1A8B4513);

  static const Color buttonPrimary = Color(0xFF8B4513);
  static const Color buttonPrimaryText = Color(0xFFFFFFFF);
  static const Color buttonSecondary = Color(0xFFF5F5DC);
  static const Color buttonSecondaryText = Color(0xFF333333);
  static const Color buttonOutlined = Color(0xFFCD853F);
  static const Color buttonOutlinedText = Color(0xFF8B4513);

  static const Color navigationBackground = Color(0xFFFFFFFF);
  static const Color navigationSelected = Color(0xFF8B4513);
  static const Color navigationUnselected = Color(0xFFB0B0B0);
  static const Color navigationSelectedText = Color(0xFF8B4513);
  static const Color navigationUnselectedText = Color(0xFF666666);

  static const Color inputBackground = Color(0xFFFAEBD7);
  static const Color inputBorder = Color(0xFFCD853F);
  static const Color inputFocused = Color(0xFF8B4513);
  static const Color inputError = Color(0xFFF44336);
  static const Color inputHint = Color(0xFFB0B0B0);

  static const Color appBarBackground = Color(0xFF8B4513);
  static const Color appBarText = Color(0xFFFFFFFF);
  static const Color appBarIcon = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFE5E5E5);

  static const Color iconPrimary = Color(0xFF8B4513);
  static const Color iconSecondary = Color(0xFF666666);
  static const Color iconDisabled = Color(0xFFB0B0B0);

  static const Color shadow = Color(0x1A8B4513);

  // HTML Design Colors
  static const Color treeBrown = Color(0xFF8B5A3C);
  static const Color leafGreen = Color(0xFF7FB069);
  static const Color warmYellow = Color(0xFFFFF3B8);
  static const Color softCream = Color(0xFFFDF6E3);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryBrown,
        primaryContainer: primaryBrownLight,
        secondary: secondaryBeige,
        secondaryContainer: secondaryBeigeLight,
        surface: surfaceBeige,
        surfaceContainerHighest: surfaceBeigeElevated,
        error: accentError,
        onPrimary: textOnBrown,
        onSecondary: textOnBeige,
        onSurface: textPrimary,
        onError: neutralWhite,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: primaryBrownLight,
        primaryContainer: primaryBrown,
        secondary: secondaryBeigeDark,
        secondaryContainer: secondaryBeige,
        surface: surfaceBrown,
        surfaceContainerHighest: surfaceBrownLight,
        error: accentErrorLight,
        onPrimary: textOnBrown,
        onSecondary: textOnBeige,
        onSurface: textOnBrown,
        onError: neutralWhite,
      ),
    );
  }
}
