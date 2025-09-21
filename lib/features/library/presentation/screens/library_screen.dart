import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/library_header.dart';
import '../widgets/library_section.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  void _handleSectionTap(LibrarySectionType type) {
    switch (type) {
      case LibrarySectionType.completed:
        break;
      case LibrarySectionType.favorites:
        break;
      case LibrarySectionType.failed:
        break;
      case LibrarySectionType.notes:
        break;
    }
  }

  void _handleFilterTap() {}

  void _handleSearchTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBeigeDark,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryBeigeLight,
                AppColors.neutralWhite,
                AppColors.accentSuccessLight,
              ],
              stops: [0.0, 0.2, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    LibraryHeader(
                      title: 'Library',
                      onFilterTap: _handleFilterTap,
                      onSearchTap: _handleSearchTap,
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.lg,
                      ),
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.secondaryBeigeVariant,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildTopNavItem(
                            context: context,
                            icon: Icons.check_circle,
                            label: 'Completed',
                            isSelected: true,
                            color: AppColors.accentSuccess,
                          ),
                          _buildTopNavItem(
                            context: context,
                            icon: Icons.favorite,
                            label: 'Favorites',
                            isSelected: false,
                            color: AppColors.accentWarning,
                          ),
                          _buildTopNavItem(
                            context: context,
                            icon: Icons.cancel,
                            label: 'Failed',
                            isSelected: false,
                            color: AppColors.accentError,
                          ),
                          _buildTopNavItem(
                            context: context,
                            icon: Icons.note,
                            label: 'Notes',
                            isSelected: false,
                            color: AppColors.leafGreen,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Library',
                            style: AppTypography.titleLarge.copyWith(
                              color: AppColors.primaryBrown,
                              fontWeight: AppTypography.semiBold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          Column(
                            children: [
                              LibrarySection(
                                type: LibrarySectionType.completed,
                                title: 'Completed Goals',
                                subtitle:
                                    'Goals you have successfully achieved',
                                icon: Icons.check_circle,
                                count: 24,
                                onTap: () => _handleSectionTap(
                                  LibrarySectionType.completed,
                                ),
                              ),
                              LibrarySection(
                                type: LibrarySectionType.favorites,
                                title: 'Favorite Goals',
                                subtitle: 'Goals you have marked as favorites',
                                icon: Icons.favorite,
                                count: 8,
                                onTap: () => _handleSectionTap(
                                  LibrarySectionType.favorites,
                                ),
                              ),
                              LibrarySection(
                                type: LibrarySectionType.failed,
                                title: 'Failed Goals',
                                subtitle: 'Goals that were not completed',
                                icon: Icons.cancel,
                                count: 5,
                                onTap: () => _handleSectionTap(
                                  LibrarySectionType.failed,
                                ),
                              ),
                              LibrarySection(
                                type: LibrarySectionType.notes,
                                title: 'All Notes',
                                subtitle: 'Personal notes and reminders',
                                icon: Icons.note,
                                count: 156,
                                onTap: () =>
                                    _handleSectionTap(LibrarySectionType.notes),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.xl),
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.secondaryBeigeVariant,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Library Statistics',
                                  style: AppTypography.titleMedium.copyWith(
                                    color: AppColors.primaryBrown,
                                    fontWeight: AppTypography.semiBold,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStatItem(
                                      context,
                                      '24',
                                      'Completed',
                                      AppColors.accentSuccess,
                                    ),
                                    _buildStatItem(
                                      context,
                                      '8',
                                      'Favorites',
                                      AppColors.accentWarning,
                                    ),
                                    _buildStatItem(
                                      context,
                                      '5',
                                      'Failed',
                                      AppColors.accentError,
                                    ),
                                    _buildStatItem(
                                      context,
                                      '156',
                                      'Notes',
                                      AppColors.leafGreen,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: AppSpacing.massive,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.eco,
                        size: 48,
                        color: AppColors.primaryBrown.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? color
                  : AppColors.primaryBrown.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected
                    ? color
                    : AppColors.primaryBrown.withValues(alpha: 0.5),
                fontWeight: isSelected
                    ? AppTypography.semiBold
                    : AppTypography.regular,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: AppTypography.bold,
            color: color,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
