import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

enum LibrarySectionType { completed, favorites, failed, notes }

class LibrarySection extends StatelessWidget {
  const LibrarySection({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.count,
    this.onTap,
    this.iconColor,
    this.titleColor,
    this.borderColor,
  });

  final LibrarySectionType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final int? count;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Color? borderColor;

  Color _getIconColor() {
    if (iconColor != null) return iconColor!;
    switch (type) {
      case LibrarySectionType.completed:
        return AppColors.accentSuccess;
      case LibrarySectionType.favorites:
        return AppColors.accentWarning;
      case LibrarySectionType.failed:
        return AppColors.accentError;
      case LibrarySectionType.notes:
        return AppColors.leafGreen;
    }
  }

  Color _getTitleColor() {
    if (titleColor != null) return titleColor!;
    return AppColors.treeBrown;
  }

  Color _getBackgroundColor() {
    switch (type) {
      case LibrarySectionType.completed:
        return AppColors.accentSuccess.withValues(alpha: 0.1);
      case LibrarySectionType.favorites:
        return AppColors.accentWarning.withValues(alpha: 0.1);
      case LibrarySectionType.failed:
        return AppColors.accentError.withValues(alpha: 0.1);
      case LibrarySectionType.notes:
        return AppColors.leafGreen.withValues(alpha: 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondaryBeigeVariant),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
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
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 24, color: _getIconColor()),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: AppTypography.semiBold,
                              color: _getTitleColor(),
                            ),
                          ),
                          if (count != null) ...[
                            const SizedBox(width: AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: _getIconColor().withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                count.toString(),
                                style: AppTypography.bodySmall.copyWith(
                                  fontWeight: AppTypography.semiBold,
                                  color: _getIconColor(),
                                ),
                              ),
                            ),
                          ],
                        ],
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
