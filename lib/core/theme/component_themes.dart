import 'package:flutter/material.dart';

import '../../shared/constants/app_constants.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

class ComponentThemes {
  ComponentThemes._();

  static CardThemeData get cardTheme {
    return CardThemeData(
      color: AppColors.cardBackground,
      shadowColor: AppColors.cardShadow,
      elevation: 2,
      margin: AppSpacing.cardMargin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        side: BorderSide(color: AppColors.cardBorder.withAlpha(51), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static ButtonThemeData get buttonTheme {
    return const ButtonThemeData(
      minWidth: AppSpacing.touchTargetMinimum,
      height: AppSpacing.buttonMinimumHeight,
      buttonColor: AppColors.buttonPrimary,
    );
  }

  static ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary,
            foregroundColor: AppColors.buttonPrimaryText,
            elevation: 2,
            shadowColor: AppColors.shadow,
            minimumSize: const Size(
              double.infinity,
              AppSpacing.buttonMinimumHeight,
            ),
            padding: AppSpacing.buttonPaddingAll,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.borderRadiusMedium,
              ),
            ),
            textStyle: AppTypography.buttonPrimary,
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) {
                return AppColors.statePressed.withAlpha(26);
              }
              if (states.contains(WidgetState.hovered)) {
                return AppColors.stateHover.withAlpha(26);
              }
              return null;
            }),
          ),
    );
  }

  static TextButtonThemeData get textButtonTheme {
    return TextButtonThemeData(
      style:
          TextButton.styleFrom(
            foregroundColor: AppColors.buttonPrimary,
            minimumSize: const Size(0, AppSpacing.buttonMinimumHeight),
            padding: AppSpacing.buttonPaddingAll,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.borderRadiusMedium,
              ),
            ),
            textStyle: AppTypography.buttonPrimary.copyWith(
              color: AppColors.buttonPrimary,
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) {
                return AppColors.statePressed.withAlpha(26);
              }
              if (states.contains(WidgetState.hovered)) {
                return AppColors.stateHover.withAlpha(26);
              }
              return null;
            }),
          ),
    );
  }

  static OutlinedButtonThemeData get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style:
          OutlinedButton.styleFrom(
            foregroundColor: AppColors.buttonOutlinedText,
            side: BorderSide(color: AppColors.buttonOutlined, width: 1.5),
            minimumSize: const Size(0, AppSpacing.buttonMinimumHeight),
            padding: AppSpacing.buttonPaddingAll,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.borderRadiusMedium,
              ),
            ),
            textStyle: AppTypography.buttonPrimary.copyWith(
              color: AppColors.buttonOutlinedText,
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) {
                return AppColors.statePressed.withAlpha(26);
              }
              if (states.contains(WidgetState.hovered)) {
                return AppColors.stateHover.withAlpha(26);
              }
              return null;
            }),
          ),
    );
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      backgroundColor: AppColors.appBarBackground,
      foregroundColor: AppColors.appBarText,
      elevation: 2,
      shadowColor: AppColors.shadow,
      titleTextStyle: AppTypography.appBarTitle,
      iconTheme: IconThemeData(color: AppColors.appBarIcon, size: 24),
      actionsIconTheme: IconThemeData(color: AppColors.appBarIcon, size: 24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.borderRadiusMedium),
          bottomRight: Radius.circular(AppConstants.borderRadiusMedium),
        ),
      ),
    );
  }

  static BottomNavigationBarThemeData get bottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: AppColors.navigationBackground,
      selectedItemColor: AppColors.leafGreen,
      unselectedItemColor: AppColors.navigationUnselected,
      selectedLabelStyle: AppTypography.navigationLabelSelected,
      unselectedLabelStyle: AppTypography.navigationLabel,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: AppColors.leafGreen, size: 24),
      unselectedIconTheme: IconThemeData(
        color: AppColors.navigationUnselected,
        size: 24,
      ),
    );
  }

  static InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      contentPadding: AppSpacing.inputContentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        borderSide: BorderSide(color: AppColors.inputBorder, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.inputBorder.withAlpha(128),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        borderSide: BorderSide(color: AppColors.inputFocused, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        borderSide: BorderSide(color: AppColors.inputError, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        borderSide: BorderSide(color: AppColors.inputError, width: 2),
      ),
      labelStyle: AppTypography.inputLabel,
      hintStyle: AppTypography.inputHint,
      errorStyle: AppTypography.errorText,
      floatingLabelStyle: AppTypography.inputLabel.copyWith(
        color: AppColors.inputFocused,
      ),
      helperStyle: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
      ),
      prefixIconColor: AppColors.iconSecondary,
      suffixIconColor: AppColors.iconSecondary,
      iconColor: AppColors.iconPrimary,
    );
  }

  static DialogThemeData get dialogTheme {
    return DialogThemeData(
      backgroundColor: AppColors.surfaceBeige,
      elevation: 8,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      titleTextStyle: AppTypography.headlineSmall.copyWith(
        color: AppColors.textPrimary,
      ),
      contentTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }

  static ChipThemeData get chipTheme {
    return ChipThemeData(
      backgroundColor: AppColors.secondaryBeige,
      deleteIconColor: AppColors.iconPrimary,
      disabledColor: AppColors.stateDisabled,
      selectedColor: AppColors.primaryBrownLight,
      secondarySelectedColor: AppColors.secondaryBeigeLight,
      checkmarkColor: AppColors.textOnBrown,
      labelStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textOnBeige,
      ),
      secondaryLabelStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      padding: AppSpacing.chipPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        side: BorderSide(color: AppColors.primaryBrown.withAlpha(51), width: 1),
      ),
    );
  }

  static DividerThemeData get dividerTheme {
    return DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: AppSpacing.md,
      indent: AppSpacing.lg,
      endIndent: AppSpacing.lg,
    );
  }

  static IconThemeData get iconTheme {
    return IconThemeData(color: AppColors.iconPrimary, size: 24, opacity: 1.0);
  }

  static ListTileThemeData get listTileTheme {
    return ListTileThemeData(
      contentPadding: AppSpacing.listItemPadding,
      tileColor: AppColors.surfaceBeige,
      selectedTileColor: AppColors.secondaryBeigeLight,
      selectedColor: AppColors.primaryBrown,
      iconColor: AppColors.iconPrimary,
      textColor: AppColors.textPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      minVerticalPadding: AppSpacing.sm,
      minLeadingWidth: AppSpacing.xl,
      horizontalTitleGap: AppSpacing.sm,
      dense: false,
    );
  }

  static TabBarThemeData get tabBarTheme {
    return TabBarThemeData(
      labelColor: AppColors.primaryBrown,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: AppTypography.buttonPrimary.copyWith(
        color: AppColors.primaryBrown,
        fontSize: 14,
      ),
      unselectedLabelStyle: AppTypography.buttonPrimary.copyWith(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      indicator: BoxDecoration(
        color: AppColors.primaryBrownLight.withAlpha(51),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: AppColors.divider,
    );
  }

  static FloatingActionButtonThemeData get floatingActionButtonTheme {
    return FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryBrown,
      foregroundColor: AppColors.textOnBrown,
      elevation: 6,
      focusElevation: 8,
      hoverElevation: 8,
      disabledElevation: 0,
      highlightElevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      sizeConstraints: BoxConstraints.tightFor(
        width: AppSpacing.fabMinimumSize,
        height: AppSpacing.fabMinimumSize,
      ),
    );
  }

  static SnackBarThemeData get snackBarTheme {
    return SnackBarThemeData(
      backgroundColor: AppColors.surfaceBeigeElevated,
      actionTextColor: AppColors.primaryBrown,
      contentTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    );
  }

  static TooltipThemeData get tooltipTheme {
    return TooltipThemeData(
      textStyle: AppTypography.bodySmall.copyWith(color: AppColors.textOnBrown),
      decoration: BoxDecoration(
        color: AppColors.primaryBrown,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
      ),
      padding: AppSpacing.tooltipPadding,
      margin: AppSpacing.tooltipContentPadding,
      showDuration: AppConstants.animationDurationSlow,
      waitDuration: AppConstants.animationDurationNormal,
    );
  }

  static CheckboxThemeData get checkboxTheme {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBrown;
        }
        return AppColors.secondaryBeige;
      }),
      checkColor: WidgetStateProperty.all(AppColors.textOnBrown),
      side: BorderSide(
        color: AppColors.primaryBrown.withAlpha(128),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
      ),
    );
  }

  static RadioThemeData get radioTheme {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBrown;
        }
        return AppColors.secondaryBeige;
      }),
      overlayColor: WidgetStateProperty.all(
        AppColors.primaryBrown.withAlpha(26),
      ),
    );
  }

  static SwitchThemeData get switchTheme {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBrown;
        }
        return AppColors.secondaryBeige;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBrown.withAlpha(77);
        }
        return AppColors.secondaryBeigeLight;
      }),
      trackOutlineColor: WidgetStateProperty.all(
        AppColors.primaryBrown.withAlpha(51),
      ),
    );
  }
}
