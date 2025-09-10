import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'component_themes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: AppColors.lightTheme.colorScheme,
      textTheme: AppTypography.lightTextTheme,
      primaryColor: AppColors.primaryBrown,
      scaffoldBackgroundColor: AppColors.secondaryBeige,
      cardTheme: ComponentThemes.cardTheme,
      buttonTheme: ComponentThemes.buttonTheme,
      elevatedButtonTheme: ComponentThemes.elevatedButtonTheme,
      textButtonTheme: ComponentThemes.textButtonTheme,
      outlinedButtonTheme: ComponentThemes.outlinedButtonTheme,
      appBarTheme: ComponentThemes.appBarTheme,
      bottomNavigationBarTheme: ComponentThemes.bottomNavigationBarTheme,
      inputDecorationTheme: ComponentThemes.inputDecorationTheme,
      dialogTheme: ComponentThemes.dialogTheme,
      chipTheme: ComponentThemes.chipTheme,
      dividerTheme: ComponentThemes.dividerTheme,
      iconTheme: ComponentThemes.iconTheme,
      listTileTheme: ComponentThemes.listTileTheme,
      tabBarTheme: ComponentThemes.tabBarTheme,
      floatingActionButtonTheme: ComponentThemes.floatingActionButtonTheme,
      snackBarTheme: ComponentThemes.snackBarTheme,
      tooltipTheme: ComponentThemes.tooltipTheme,
      checkboxTheme: ComponentThemes.checkboxTheme,
      radioTheme: ComponentThemes.radioTheme,
      switchTheme: ComponentThemes.switchTheme,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryBrown,
        linearTrackColor: AppColors.secondaryBeigeLight,
        circularTrackColor: AppColors.secondaryBeigeLight,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryBrown,
        inactiveTrackColor: AppColors.secondaryBeigeLight,
        thumbColor: AppColors.primaryBrown,
        overlayColor: AppColors.primaryBrown.withAlpha(51),
        valueIndicatorColor: AppColors.primaryBrown,
        valueIndicatorTextStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textOnBrown,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceBeige,
        modalBackgroundColor: AppColors.surfaceBeige,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        modalElevation: 8,
        shadowColor: AppColors.shadow,
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: AppColors.surfaceBeige,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrown.withAlpha(26),
        indicatorColor: AppColors.primaryBrownLight.withAlpha(51),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.navigationBackground,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrown.withAlpha(26),
        indicatorColor: AppColors.primaryBrownLight.withAlpha(51),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.navigationLabelSelected;
          }
          return AppTypography.navigationLabel;
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: AppColors.navigationSelected, size: 24);
          }
          return IconThemeData(color: AppColors.navigationUnselected, size: 24);
        }),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.surfaceBeige,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrown.withAlpha(26),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceBeige,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrown.withAlpha(26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.surfaceBeige),
          shadowColor: WidgetStateProperty.all(AppColors.shadow),
          surfaceTintColor: WidgetStateProperty.all(
            AppColors.primaryBrown.withAlpha(26),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(AppColors.secondaryBeige),
        shadowColor: WidgetStateProperty.all(AppColors.shadow),
        surfaceTintColor: WidgetStateProperty.all(
          AppColors.primaryBrown.withAlpha(26),
        ),
        elevation: WidgetStateProperty.all(2),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        textStyle: WidgetStateProperty.all(
          AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
        ),
        hintStyle: WidgetStateProperty.all(
          AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
      ),
      searchViewTheme: SearchViewThemeData(
        backgroundColor: AppColors.surfaceBeige,
        surfaceTintColor: AppColors.primaryBrown.withAlpha(26),
        headerHintStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.textSecondary,
        ),
        headerTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        dividerColor: AppColors.divider,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: AppColors.secondaryBeige,
        collapsedBackgroundColor: AppColors.surfaceBeige,
        textColor: AppColors.textPrimary,
        collapsedTextColor: AppColors.textPrimary,
        iconColor: AppColors.iconPrimary,
        collapsedIconColor: AppColors.iconPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dataTableTheme: DataTableThemeData(
        dataRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryBrownLight.withAlpha(26);
          }
          return AppColors.surfaceBeige;
        }),
        dataRowCursor: WidgetStateProperty.all(SystemMouseCursors.click),
        headingRowColor: WidgetStateProperty.all(AppColors.secondaryBeigeLight),
        headingTextStyle: AppTypography.titleMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: AppTypography.semiBold,
        ),
        dataTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        dividerThickness: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: AppColors.darkTheme.colorScheme,
      textTheme: AppTypography.darkTextTheme,
      primaryColor: AppColors.primaryBrownLight,
      scaffoldBackgroundColor: AppColors.surfaceBrown,
      cardTheme: ComponentThemes.cardTheme.copyWith(
        color: AppColors.surfaceBrownLight,
        shadowColor: AppColors.shadow,
      ),
      buttonTheme: ComponentThemes.buttonTheme,
      elevatedButtonTheme: ComponentThemes.elevatedButtonTheme,
      textButtonTheme: ComponentThemes.textButtonTheme,
      outlinedButtonTheme: ComponentThemes.outlinedButtonTheme,
      appBarTheme: ComponentThemes.appBarTheme.copyWith(
        backgroundColor: AppColors.surfaceBrown,
      ),
      bottomNavigationBarTheme: ComponentThemes.bottomNavigationBarTheme
          .copyWith(backgroundColor: AppColors.surfaceBrown),
      inputDecorationTheme: ComponentThemes.inputDecorationTheme.copyWith(
        fillColor: AppColors.surfaceBrownLight,
        enabledBorder: ComponentThemes.inputDecorationTheme.enabledBorder
            ?.copyWith(
              borderSide: BorderSide(
                color: AppColors.primaryBrownLight.withAlpha(128),
                width: 1.5,
              ),
            ),
        focusedBorder: ComponentThemes.inputDecorationTheme.focusedBorder
            ?.copyWith(
              borderSide: BorderSide(
                color: AppColors.primaryBrownLight,
                width: 2,
              ),
            ),
      ),
      dialogTheme: ComponentThemes.dialogTheme.copyWith(
        backgroundColor: AppColors.surfaceBrown,
      ),
      chipTheme: ComponentThemes.chipTheme.copyWith(
        backgroundColor: AppColors.surfaceBrownLight,
      ),
      dividerTheme: ComponentThemes.dividerTheme,
      iconTheme: ComponentThemes.iconTheme,
      listTileTheme: ComponentThemes.listTileTheme.copyWith(
        tileColor: AppColors.surfaceBrown,
        selectedTileColor: AppColors.surfaceBrownLight,
      ),
      tabBarTheme: ComponentThemes.tabBarTheme,
      floatingActionButtonTheme: ComponentThemes.floatingActionButtonTheme,
      snackBarTheme: ComponentThemes.snackBarTheme.copyWith(
        backgroundColor: AppColors.surfaceBrownLight,
      ),
      tooltipTheme: ComponentThemes.tooltipTheme,
      checkboxTheme: ComponentThemes.checkboxTheme,
      radioTheme: ComponentThemes.radioTheme,
      switchTheme: ComponentThemes.switchTheme,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryBrownLight,
        linearTrackColor: AppColors.surfaceBrownLight,
        circularTrackColor: AppColors.surfaceBrownLight,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryBrownLight,
        inactiveTrackColor: AppColors.surfaceBrownLight,
        thumbColor: AppColors.primaryBrownLight,
        overlayColor: AppColors.primaryBrownLight.withAlpha(51),
        valueIndicatorColor: AppColors.primaryBrownLight,
        valueIndicatorTextStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textOnBrown,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceBrown,
        modalBackgroundColor: AppColors.surfaceBrown,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        modalElevation: 8,
        shadowColor: AppColors.shadow,
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: AppColors.surfaceBrown,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrownLight.withAlpha(26),
        indicatorColor: AppColors.primaryBrown.withAlpha(51),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceBrown,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrownLight.withAlpha(26),
        indicatorColor: AppColors.primaryBrown.withAlpha(51),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.navigationLabelSelected;
          }
          return AppTypography.navigationLabel;
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: AppColors.primaryBrownLight, size: 24);
          }
          return IconThemeData(color: AppColors.secondaryBeigeDark, size: 24);
        }),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.surfaceBrown,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrownLight.withAlpha(26),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceBrown,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.primaryBrownLight.withAlpha(26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textOnBrown,
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.surfaceBrown),
          shadowColor: WidgetStateProperty.all(AppColors.shadow),
          surfaceTintColor: WidgetStateProperty.all(
            AppColors.primaryBrownLight.withAlpha(26),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(AppColors.surfaceBrownLight),
        shadowColor: WidgetStateProperty.all(AppColors.shadow),
        surfaceTintColor: WidgetStateProperty.all(
          AppColors.primaryBrownLight.withAlpha(26),
        ),
        elevation: WidgetStateProperty.all(2),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        textStyle: WidgetStateProperty.all(
          AppTypography.bodyMedium.copyWith(color: AppColors.textOnBrown),
        ),
        hintStyle: WidgetStateProperty.all(
          AppTypography.bodyMedium.copyWith(
            color: AppColors.secondaryBeigeDark,
          ),
        ),
      ),
      searchViewTheme: SearchViewThemeData(
        backgroundColor: AppColors.surfaceBrown,
        surfaceTintColor: AppColors.primaryBrownLight.withAlpha(26),
        headerHintStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.secondaryBeigeDark,
        ),
        headerTextStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.textOnBrown,
        ),
        dividerColor: AppColors.divider,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: AppColors.surfaceBrownLight,
        collapsedBackgroundColor: AppColors.surfaceBrown,
        textColor: AppColors.textOnBrown,
        collapsedTextColor: AppColors.textOnBrown,
        iconColor: AppColors.primaryBrownLight,
        collapsedIconColor: AppColors.primaryBrownLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dataTableTheme: DataTableThemeData(
        dataRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryBrownLight.withAlpha(26);
          }
          return AppColors.surfaceBrown;
        }),
        dataRowCursor: WidgetStateProperty.all(SystemMouseCursors.click),
        headingRowColor: WidgetStateProperty.all(AppColors.surfaceBrownLight),
        headingTextStyle: AppTypography.titleMedium.copyWith(
          color: AppColors.textOnBrown,
          fontWeight: AppTypography.semiBold,
        ),
        dataTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textOnBrown,
        ),
        dividerThickness: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
      ),
    );
  }

  static ColorScheme getLightColorScheme() {
    return AppColors.lightTheme.colorScheme;
  }

  static ColorScheme getDarkColorScheme() {
    return AppColors.darkTheme.colorScheme;
  }

  static TextTheme getLightTextTheme() {
    return AppTypography.lightTextTheme;
  }

  static TextTheme getDarkTextTheme() {
    return AppTypography.darkTextTheme;
  }

  static ThemeData getThemeForBrightness(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }
}
