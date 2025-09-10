import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
    required this.title,
    this.onBackTap,
    this.onSettingsTap,
    this.settingsIcon = Icons.settings,
  });

  final String title;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final IconData settingsIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: AppColors.treeBrown.withOpacity(0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (onBackTap != null)
            GestureDetector(
              onTap: onBackTap,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.treeBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.treeBrown,
                  size: 20,
                ),
              ),
            )
          else
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.leafGreen, AppColors.treeBrown],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.grass, color: AppColors.neutralWhite, size: 20),
            ),
          AppSpacing.horizontalSpaceMedium,
          Text(
            title,
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: AppTypography.bold,
              color: AppColors.treeBrown,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSettingsTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.treeBrown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(settingsIcon, color: AppColors.treeBrown, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
