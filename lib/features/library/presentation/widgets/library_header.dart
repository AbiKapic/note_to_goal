import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({
    super.key,
    required this.title,
    this.onFilterTap,
    this.onSearchTap,
    this.filterIcon = Icons.filter_list,
    this.searchIcon = Icons.search,
  });

  final String title;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSearchTap;
  final IconData filterIcon;
  final IconData searchIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryBeigeDark,
            AppColors.softCream,
            AppColors.leafGreen,
          ],
          stops: [0.0, 0.2, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 6),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryBeigeVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.library_books,
              color: AppColors.primaryBrown,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.headlineSmall.copyWith(
                  fontWeight: AppTypography.bold,
                  color: AppColors.primaryBrown,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Explore your achievements',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primaryBrown,
                  fontWeight: AppTypography.semiBold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (onSearchTap != null)
            GestureDetector(
              onTap: onSearchTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBeigeVariant,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  searchIcon,
                  color: AppColors.primaryBrown,
                  size: 18,
                ),
              ),
            ),
          if (onFilterTap != null) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBeigeVariant,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  filterIcon,
                  color: AppColors.primaryBrown,
                  size: 18,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
