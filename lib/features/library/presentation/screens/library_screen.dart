import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/library_header.dart';
import '../widgets/library_section.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  void _handleSectionTap(LibrarySectionType type) {
    switch (type) {
      case LibrarySectionType.completed:
        // Navigate to completed goals screen
        break;
      case LibrarySectionType.favorites:
        // Navigate to favorites screen
        break;
      case LibrarySectionType.failed:
        // Navigate to failed goals screen
        break;
      case LibrarySectionType.notes:
        // Navigate to all notes screen
        break;
    }
  }

  void _handleFilterTap() {
    // Handle filter button tap
  }

  void _handleSearchTap() {
    // Handle search button tap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmYellow,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.warmYellow,
                AppColors.softCream,
                AppColors.leafGreen.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Header
                    LibraryHeader(
                      title: 'Library',
                      onFilterTap: _handleFilterTap,
                      onSearchTap: _handleSearchTap,
                    ),

                    // Top Navigation Bar (similar to bottom navigation but horizontal)
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
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

                    // Main Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section Title
                          Text(
                            'Your Library',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: AppColors.treeBrown,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          AppSpacing.verticalSpaceMedium,

                          // Library Sections
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

                          // Stats Overview
                          AppSpacing.verticalSpaceLarge,
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.treeBrown.withOpacity(0.2),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Library Statistics',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppColors.treeBrown,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                AppSpacing.verticalSpaceMedium,
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

                    // Bottom Decoration
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.eco,
                        size: 48,
                        color: AppColors.treeBrown.withOpacity(0.2),
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? color : AppColors.treeBrown.withOpacity(0.5),
            ),
            AppSpacing.verticalSpaceTiny,
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? color
                    : AppColors.treeBrown.withOpacity(0.5),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 10,
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
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        AppSpacing.verticalSpaceTiny,
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
