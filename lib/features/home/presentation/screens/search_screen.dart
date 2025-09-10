import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

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

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchQuery = useState('');
    final selectedPriorities = useState<Set<ItemPriority>>({});
    final selectedStatuses = useState<Set<ItemStatus>>({});
    final selectedTypes = useState<Set<ItemType>>({});

    final items = useMemoized(
      () => <GrowthItem>[
        GrowthItem(
          id: '1',
          title: 'Learn Spanish Fluently',
          description:
              'Complete 30 lessons per month and practice conversation daily',
          type: ItemType.goal,
          priority: ItemPriority.high,
          status: ItemStatus.notCompleted,
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          progressPercent: 50,
        ),
        GrowthItem(
          id: '2',
          title: 'Learn React Native',
          description: 'Complete 5 tutorials by end of week',
          type: ItemType.goal,
          priority: ItemPriority.medium,
          status: ItemStatus.notCompleted,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          progressPercent: 60,
        ),
        GrowthItem(
          id: '3',
          title: 'Completed Marathon',
          description:
              'Successfully ran my first 42km marathon in under 4 hours!',
          type: ItemType.success,
          priority: ItemPriority.medium,
          status: ItemStatus.completed,
          timestamp: DateTime.now().subtract(const Duration(days: 7)),
        ),
        GrowthItem(
          id: '4',
          title: 'Morning Routine Ideas',
          description:
              'Meditation, journaling, exercise, and healthy breakfast ideas',
          type: ItemType.note,
          priority: ItemPriority.low,
          status: ItemStatus.notCompleted,
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
        ),
        GrowthItem(
          id: '5',
          title: 'Mobile App Development',
          description: 'Build a habit tracking app with gamification features',
          type: ItemType.note,
          priority: ItemPriority.high,
          status: ItemStatus.notCompleted,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        GrowthItem(
          id: '6',
          title: 'Read 12 Books This Year',
          description: 'Complete 1 book per month with monthly reviews',
          type: ItemType.goal,
          priority: ItemPriority.medium,
          status: ItemStatus.notCompleted,
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
          progressPercent: 25,
        ),
      ],
    );

    List<GrowthItem> filteredItems() {
      return items.where((i) {
        final matchesQuery =
            searchQuery.value.isEmpty ||
            i.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            i.description.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            );
        final matchesPriority =
            selectedPriorities.value.isEmpty ||
            selectedPriorities.value.contains(i.priority);
        final matchesStatus =
            selectedStatuses.value.isEmpty ||
            selectedStatuses.value.contains(i.status);
        final matchesType =
            selectedTypes.value.isEmpty || selectedTypes.value.contains(i.type);
        return matchesQuery && matchesPriority && matchesStatus && matchesType;
      }).toList();
    }

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

    Color priorityDot(ItemPriority p) {
      switch (p) {
        case ItemPriority.high:
          return AppColors.accentError;
        case ItemPriority.medium:
          return AppColors.accentWarning;
        case ItemPriority.low:
          return AppColors.accentSuccess;
      }
    }

    String priorityLabel(ItemPriority p) {
      switch (p) {
        case ItemPriority.high:
          return 'High';
        case ItemPriority.medium:
          return 'Medium';
        case ItemPriority.low:
          return 'Low';
      }
    }

    String statusLabel(ItemStatus s) {
      switch (s) {
        case ItemStatus.completed:
          return 'Completed';
        case ItemStatus.notCompleted:
          return 'Not Completed';
      }
    }

    void openFilterSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.neutralWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) {
          Widget buildFilterButton({
            required bool selected,
            required Widget leading,
            required String label,
            required VoidCallback onTap,
            Color? selectedBorder,
          }) {
            return InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primaryBrown
                      : AppColors.neutralWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected
                        ? (selectedBorder ?? AppColors.primaryBrown)
                        : AppColors.neutralLightGray,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    leading,
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        label,
                        style: AppTypography.bodyMedium.copyWith(
                          color: selected
                              ? AppColors.neutralWhite
                              : AppColors.textSecondary,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                    ),
                    Icon(
                      selected ? Icons.check : Icons.add,
                      size: 18,
                      color: selected
                          ? AppColors.neutralWhite
                          : AppColors.neutralMediumGray,
                    ),
                  ],
                ),
              ),
            );
          }

          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, controller) {
              return SingleChildScrollView(
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.neutralLightGray,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Text(
                        'Add Filter',
                        style: AppTypography.headlineSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Select multiple filters to refine your search',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      Text(
                        'Filter by Priority',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Column(
                        children: [
                          buildFilterButton(
                            selected: selectedPriorities.value.contains(
                              ItemPriority.high,
                            ),
                            leading: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.accentError,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            label: 'High Priority',
                            onTap: () {
                              final next = {...selectedPriorities.value};
                              if (!next.add(ItemPriority.high))
                                next.remove(ItemPriority.high);
                              selectedPriorities.value = next;
                            },
                            selectedBorder: AppColors.accentError,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          buildFilterButton(
                            selected: selectedPriorities.value.contains(
                              ItemPriority.medium,
                            ),
                            leading: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.accentWarning,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            label: 'Medium Priority',
                            onTap: () {
                              final next = {...selectedPriorities.value};
                              if (!next.add(ItemPriority.medium))
                                next.remove(ItemPriority.medium);
                              selectedPriorities.value = next;
                            },
                            selectedBorder: AppColors.accentWarning,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          buildFilterButton(
                            selected: selectedPriorities.value.contains(
                              ItemPriority.low,
                            ),
                            leading: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.accentSuccess,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            label: 'Low Priority',
                            onTap: () {
                              final next = {...selectedPriorities.value};
                              if (!next.add(ItemPriority.low))
                                next.remove(ItemPriority.low);
                              selectedPriorities.value = next;
                            },
                            selectedBorder: AppColors.accentSuccess,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        'Filter by Status',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Column(
                        children: [
                          buildFilterButton(
                            selected: selectedStatuses.value.contains(
                              ItemStatus.completed,
                            ),
                            leading: const Icon(
                              Icons.check_circle,
                              color: AppColors.accentSuccess,
                            ),
                            label: 'Completed',
                            onTap: () {
                              final next = {...selectedStatuses.value};
                              if (!next.add(ItemStatus.completed))
                                next.remove(ItemStatus.completed);
                              selectedStatuses.value = next;
                            },
                            selectedBorder: AppColors.accentSuccess,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          buildFilterButton(
                            selected: selectedStatuses.value.contains(
                              ItemStatus.notCompleted,
                            ),
                            leading: const Icon(
                              Icons.access_time,
                              color: AppColors.accentWarning,
                            ),
                            label: 'Not Completed',
                            onTap: () {
                              final next = {...selectedStatuses.value};
                              if (!next.add(ItemStatus.notCompleted))
                                next.remove(ItemStatus.notCompleted);
                              selectedStatuses.value = next;
                            },
                            selectedBorder: AppColors.accentWarning,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        'Filter by Type',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Column(
                        children: [
                          buildFilterButton(
                            selected: selectedTypes.value.contains(
                              ItemType.note,
                            ),
                            leading: const Icon(
                              Icons.edit,
                              color: AppColors.primaryBrown,
                            ),
                            label: 'Note',
                            onTap: () {
                              final next = {...selectedTypes.value};
                              if (!next.add(ItemType.note))
                                next.remove(ItemType.note);
                              selectedTypes.value = next;
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          buildFilterButton(
                            selected: selectedTypes.value.contains(
                              ItemType.goal,
                            ),
                            leading: const Icon(
                              Icons.my_location,
                              color: AppColors.accentInfo,
                            ),
                            label: 'Goal',
                            onTap: () {
                              final next = {...selectedTypes.value};
                              if (!next.add(ItemType.goal))
                                next.remove(ItemType.goal);
                              selectedTypes.value = next;
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          buildFilterButton(
                            selected: selectedTypes.value.contains(
                              ItemType.success,
                            ),
                            leading: const Icon(
                              Icons.emoji_events,
                              color: AppColors.accentWarning,
                            ),
                            label: 'Success',
                            onTap: () {
                              final next = {...selectedTypes.value};
                              if (!next.add(ItemType.success))
                                next.remove(ItemType.success);
                              selectedTypes.value = next;
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                selectedPriorities.value = {};
                                selectedStatuses.value = {};
                                selectedTypes.value = {};
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Apply Filters'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
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
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryBeigeVariant,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBrown,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search & Discover',
                        style: AppTypography.headlineSmall.copyWith(
                          color: AppColors.textOnBrown,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Find your growth journey',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.secondaryBeigeDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget buildSearchBar() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
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
          child: Row(
            children: [
              const SizedBox(width: 12),
              const Icon(Icons.search, color: AppColors.neutralMediumGray),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (v) => searchQuery.value = v,
                  decoration: const InputDecoration(
                    hintText: 'Search goals, notes, successes...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: openFilterSheet,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBrown,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: AppColors.neutralWhite,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildActiveFilters() {
      final hasFilters =
          selectedPriorities.value.isNotEmpty ||
          selectedStatuses.value.isNotEmpty ||
          selectedTypes.value.isNotEmpty;
      if (!hasFilters) return const SizedBox.shrink();
      List<Widget> chips = [];
      for (final p in selectedPriorities.value) {
        chips.add(
          _FilterChip(
            label: priorityLabel(p),
            color: priorityDot(p),
            onRemove: () {
              final next = {...selectedPriorities.value};
              next.remove(p);
              selectedPriorities.value = next;
            },
          ),
        );
      }
      for (final s in selectedStatuses.value) {
        chips.add(
          _FilterChip(
            label: statusLabel(s),
            color: s == ItemStatus.completed
                ? AppColors.accentSuccess
                : AppColors.accentWarning,
            onRemove: () {
              final next = {...selectedStatuses.value};
              next.remove(s);
              selectedStatuses.value = next;
            },
          ),
        );
      }
      for (final t in selectedTypes.value) {
        Color c = typeColor(t);
        String l = t == ItemType.goal
            ? 'Goals'
            : t == ItemType.success
            ? 'Success'
            : 'Notes';
        chips.add(
          _FilterChip(
            label: l,
            color: c,
            onRemove: () {
              final next = {...selectedTypes.value};
              next.remove(t);
              selectedTypes.value = next;
            },
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(spacing: 8, runSpacing: 8, children: chips),
      );
    }

    Widget buildItemCard(GrowthItem item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: typeColor(item.type).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(typeIcon(item.type), color: typeColor(item.type)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.titleMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: AppTypography.semiBold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: priorityDot(item.priority),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              priorityLabel(item.priority),
                              style: AppTypography.labelSmall.copyWith(
                                color: priorityDot(item.priority),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.type == ItemType.goal
                              ? 'Goal'
                              : item.type == ItemType.success
                              ? 'Success'
                              : 'Note',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        if (item.type == ItemType.goal &&
                            item.progressPercent != null)
                          Row(
                            children: [
                              Container(
                                width: 64,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.neutralLightGray,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width:
                                        64 *
                                        (item.progressPercent!.clamp(0, 100) /
                                            100),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: AppColors.accentSuccess,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${item.progressPercent}%',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.accentSuccess,
                                ),
                              ),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Icon(
                                item.status == ItemStatus.completed
                                    ? Icons.check_circle
                                    : Icons.bookmark,
                                size: 14,
                                color: item.status == ItemStatus.completed
                                    ? AppColors.accentSuccess
                                    : AppColors.primaryBrown,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.status == ItemStatus.completed
                                    ? 'Completed'
                                    : 'Saved',
                                style: AppTypography.labelSmall.copyWith(
                                  color: item.status == ItemStatus.completed
                                      ? AppColors.accentSuccess
                                      : AppColors.primaryBrown,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final results = filteredItems();

    return Scaffold(
      backgroundColor: AppColors.secondaryBeigeDark,
      body: Column(
        children: [
          buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSearchBar(),
                  buildActiveFilters(),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Growth Items',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: AppTypography.semiBold,
                          ),
                        ),
                        Text(
                          '${results.length} items',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.neutralDarkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...results.map(buildItemCard),
                  const SizedBox(height: 88),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.color,
    required this.onRemove,
  });

  final String label;
  final Color color;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: color,
              fontWeight: AppTypography.semiBold,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onRemove,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.close,
                size: 12,
                color: AppColors.neutralWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
