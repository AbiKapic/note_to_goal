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
            child: Icon(
              Icons.library_books,
              color: AppColors.neutralWhite,
              size: 20,
            ),
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
          if (onSearchTap != null)
            GestureDetector(
              onTap: onSearchTap,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.treeBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(searchIcon, color: AppColors.treeBrown, size: 20),
              ),
            ),
          if (onFilterTap != null) ...[
            AppSpacing.horizontalSpaceSmall,
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.treeBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(filterIcon, color: AppColors.treeBrown, size: 20),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
