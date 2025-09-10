import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../navigations/app_routes.dart';

enum ItemType { goal, success, note }

enum ItemPriority { high, medium, low }

enum ItemStatus { completed, notCompleted }

class GrowthItem {
  const GrowthItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.status,
    required this.timestamp,
    this.progressPercent,
  });

  final String id;
  final String title;
  final String description;
  final ItemType type;
  final ItemPriority priority;
  final ItemStatus status;
  final DateTime timestamp;
  final int? progressPercent;
}

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  Color typeColor(ItemType type) {
    switch (type) {
      case ItemType.goal:
        return AppColors.accentInfo;
      case ItemType.success:
        return AppColors.accentWarning;
      case ItemType.note:
        return AppColors.primaryBrown;
    }
  }

  IconData typeIcon(ItemType type) {
    switch (type) {
      case ItemType.goal:
        return Icons.my_location;
      case ItemType.success:
        return Icons.emoji_events;
      case ItemType.note:
        return Icons.edit;
    }
  }

  Color getBorderColor(ItemType type) {
    switch (type) {
      case ItemType.goal:
        return AppColors.accentInfo;
      case ItemType.success:
        return AppColors.accentWarning;
      case ItemType.note:
        return AppColors.primaryBrown;
    }
  }

  String getTypeLabel(ItemType type) {
    switch (type) {
      case ItemType.goal:
        return 'GOAL';
      case ItemType.success:
        return 'SUCCESS';
      case ItemType.note:
        return 'NOTE';
    }
  }

  String getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = useMemoized(
      () => <GrowthItem>[
        GrowthItem(
          id: '1',
          title: 'Learn React Native',
          description: 'Complete 5 tutorials by end of week',
          type: ItemType.goal,
          priority: ItemPriority.high,
          status: ItemStatus.notCompleted,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          progressPercent: 60,
        ),
        GrowthItem(
          id: '2',
          title: 'Completed Morning Workout',
          description: '30 minutes cardio session',
          type: ItemType.success,
          priority: ItemPriority.medium,
          status: ItemStatus.completed,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GrowthItem(
          id: '3',
          title: 'Project Ideas',
          description:
              'Mobile app for habit tracking with gamification features and social connectivity',
          type: ItemType.note,
          priority: ItemPriority.low,
          status: ItemStatus.notCompleted,
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    );

    Widget buildStatCard({
      required IconData icon,
      required Color iconColor,
      required String value,
      required String label,
    }) {
      return Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: AppTypography.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.neutralDarkGray,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildActivityCard(GrowthItem item) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(color: getBorderColor(item.type), width: 4),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: typeColor(item.type).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        typeIcon(item.type),
                        color: typeColor(item.type),
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getTypeLabel(item.type),
                      style: AppTypography.labelSmall.copyWith(
                        color: typeColor(item.type),
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                  ],
                ),
                Text(
                  getTimeAgo(item.timestamp),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.neutralMediumGray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.neutralDarkGray,
              ),
            ),
            if (item.type == ItemType.goal && item.progressPercent != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.neutralLightGray,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width *
                              0.4 *
                              (item.progressPercent! / 100),
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.accentSuccess,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${item.progressPercent}%',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.accentSuccess,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    }

    void openAccountPage() {
      Navigator.of(context).pushNamed(AppRoutes.account);
    }

    Widget buildHeader() {
      return Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 16,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBrown, AppColors.primaryBrownVariant],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBeigeVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.eco,
                    color: AppColors.primaryBrown,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NoteToGoal',
                      style: AppTypography.headlineSmall.copyWith(
                        color: AppColors.textOnBrown,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    Text(
                      'Grow your dreams',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.secondaryBeigeDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBeigeVariant,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: AppColors.primaryBrown,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: openAccountPage,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBeigeVariant,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primaryBrown,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buildWelcomeSection() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.secondaryBeigeLight, AppColors.secondaryBeige],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning!',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ready to grow today?',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primaryBrownDark,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBrown.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.nature,
                    color: AppColors.primaryBrown,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accentSuccess,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '3 goals in progress',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primaryBrown,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buildStatsSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: buildStatCard(
                icon: Icons.my_location,
                iconColor: AppColors.accentInfo,
                value: '12',
                label: 'Goals',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: buildStatCard(
                icon: Icons.star,
                iconColor: AppColors.accentWarning,
                value: '8',
                label: 'Success',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: buildStatCard(
                icon: Icons.edit,
                iconColor: AppColors.primaryBrown,
                value: '24',
                label: 'Notes',
              ),
            ),
          ],
        ),
      );
    }

    Widget buildRecentActivity() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) => buildActivityCard(item)),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryBeigeDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 80,
            ), // Account for bottom nav
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                buildWelcomeSection(),
                buildStatsSection(),
                buildRecentActivity(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
