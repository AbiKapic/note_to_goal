import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

enum AccountMenuItemType {
  personalInfo,
  successOverview,
  noteForYourself,
  notifications,
  signOut,
  deleteAccount,
}

class AccountMenuItem extends StatelessWidget {
  const AccountMenuItem({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.titleColor,
    this.borderColor,
    this.isLoading = false,
  });

  final AccountMenuItemType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Color? borderColor;
  final bool isLoading;

  Color _getIconColor() {
    if (iconColor != null) return iconColor!;
    switch (type) {
      case AccountMenuItemType.personalInfo:
        return AppColors.leafGreen;
      case AccountMenuItemType.successOverview:
        return AppColors.treeBrown;
      case AccountMenuItemType.noteForYourself:
        return Colors.yellow[600]!;
      case AccountMenuItemType.notifications:
        return Colors.blue[600]!;
      case AccountMenuItemType.signOut:
        return Colors.orange[600]!;
      case AccountMenuItemType.deleteAccount:
        return Colors.red[600]!;
    }
  }

  Color _getTitleColor() {
    if (titleColor != null) return titleColor!;
    switch (type) {
      case AccountMenuItemType.signOut:
        return Colors.orange[600]!;
      case AccountMenuItemType.deleteAccount:
        return Colors.red[600]!;
      default:
        return AppColors.treeBrown;
    }
  }

  Color _getBorderColor() {
    if (borderColor != null) return borderColor!;
    switch (type) {
      case AccountMenuItemType.signOut:
        return Colors.orange.withValues(alpha: 0.2);
      case AccountMenuItemType.deleteAccount:
        return Colors.red.withValues(alpha: 0.2);
      default:
        return AppColors.treeBrown.withValues(alpha: 0.2);
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case AccountMenuItemType.personalInfo:
        return AppColors.leafGreen.withValues(alpha: 0.2);
      case AccountMenuItemType.successOverview:
        return AppColors.treeBrown.withValues(alpha: 0.2);
      case AccountMenuItemType.noteForYourself:
        return AppColors.warmYellow.withValues(alpha: 0.6);
      case AccountMenuItemType.notifications:
        return Colors.blue.withValues(alpha: 0.1);
      case AccountMenuItemType.signOut:
        return Colors.orange.withValues(alpha: 0.1);
      case AccountMenuItemType.deleteAccount:
        return Colors.red.withValues(alpha: 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _getBorderColor(), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: _getIconColor().withValues(alpha: 0.1),
          highlightColor: _getIconColor().withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Icon(icon, size: 24, color: _getIconColor()),
                ),
                AppSpacing.horizontalSpaceLarge,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: AppTypography.semiBold,
                          color: _getTitleColor(),
                        ),
                      ),
                      AppSpacing.verticalSpaceTiny,
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.treeBrown.withValues(alpha: 0.5),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
