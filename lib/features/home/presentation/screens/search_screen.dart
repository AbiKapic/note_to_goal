import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../navigations/app_routes.dart';
import '../../../../services/hive_service.dart';
import '../../../../shared/models/note_model.dart';
import '../../../../shared/widgets/note_card.dart';

enum ItemType { goal, success, note }

enum ItemPriority { high, medium, low }

enum ItemStatus { completed, notCompleted }

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useListenable(HiveService.notesListenable());
    final searchQuery = useState('');
    final selectedPriorities = useState<Set<ItemPriority>>({});
    final selectedStatuses = useState<Set<ItemStatus>>({});
    final selectedTypes = useState<Set<ItemType>>({});

    final allNotes = HiveService.getAllNotes();

    ItemPriority notePriorityToItemPriority(PriorityLevel priority) {
      switch (priority) {
        case PriorityLevel.high:
          return ItemPriority.high;
        case PriorityLevel.medium:
          return ItemPriority.medium;
        case PriorityLevel.low:
          return ItemPriority.low;
      }
    }

    ItemStatus noteStatusToItemStatus(Note note) {
      return (note.progressPercent ?? 0) >= 100
          ? ItemStatus.completed
          : ItemStatus.notCompleted;
    }

    ItemType noteTypeToItemType(NoteType type) {
      switch (type) {
        case NoteType.goals:
          return ItemType.goal;
        case NoteType.successes:
          return ItemType.success;
        case NoteType.quickNotes:
        case NoteType.journal:
        case NoteType.habits:
        case NoteType.inspiration:
          return ItemType.note;
      }
    }

    List<Note> filteredItems() {
      return allNotes.where((note) {
        final matchesQuery =
            searchQuery.value.isEmpty ||
            note.title.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ) ||
            note.description.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            );
        final matchesPriority =
            selectedPriorities.value.isEmpty ||
            selectedPriorities.value.contains(
              notePriorityToItemPriority(note.priority),
            );
        final matchesStatus =
            selectedStatuses.value.isEmpty ||
            selectedStatuses.value.contains(noteStatusToItemStatus(note));
        final matchesType =
            selectedTypes.value.isEmpty ||
            selectedTypes.value.contains(noteTypeToItemType(note.type));
        return matchesQuery && matchesPriority && matchesStatus && matchesType;
      }).toList();
    }

    // typeColor and typeIcon are now handled inside the NoteCard

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
                      const SizedBox(height: AppSpacing.sm),
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
                              if (!next.add(ItemPriority.high)) {
                                next.remove(ItemPriority.high);
                              }
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
                              if (!next.add(ItemPriority.medium)) {
                                next.remove(ItemPriority.medium);
                              }
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
                              if (!next.add(ItemPriority.low)) {
                                next.remove(ItemPriority.low);
                              }
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
                              if (!next.add(ItemStatus.completed)) {
                                next.remove(ItemStatus.completed);
                              }
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
                              if (!next.add(ItemStatus.notCompleted)) {
                                next.remove(ItemStatus.notCompleted);
                              }
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
                            label: 'Notes',
                            onTap: () {
                              final next = {...selectedTypes.value};
                              if (!next.add(ItemType.note)) {
                                next.remove(ItemType.note);
                              }
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
                            label: 'Goals',
                            onTap: () {
                              final next = {...selectedTypes.value};
                              if (!next.add(ItemType.goal)) {
                                next.remove(ItemType.goal);
                              }
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
                            label: 'Successes',
                            onTap: () {
                              final next = {...selectedTypes.value};
                              if (!next.add(ItemType.success)) {
                                next.remove(ItemType.success);
                              }
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
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
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
                const SizedBox(width: AppSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search & Discover',
                      style: AppTypography.headlineSmall.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Find your growth journey',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: AppTypography.semiBold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buildSearchBar() {
      final isSearching = useState(false);
      final searchFocusNode = useFocusNode();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Container(
          height: 55, // Compact height for search bar
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 10, // Minimal vertical padding since height is reduced
          ),
          decoration: BoxDecoration(
            color: AppColors.neutralWhite,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSearching.value
                  ? AppColors.primaryBrownVariant
                  : AppColors.secondaryBeigeVariant,
              width: isSearching.value ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: AppSpacing.xs),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 18,
                height: 18,
                child: Icon(
                  Icons.search,
                  color: isSearching.value
                      ? AppColors.primaryBrownVariant
                      : AppColors.neutralMediumGray,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: TextField(
                  focusNode: searchFocusNode,
                  onChanged: (v) {
                    searchQuery.value = v;
                    isSearching.value =
                        v.isNotEmpty || searchFocusNode.hasFocus;
                  },
                  onTap: () => isSearching.value = true,
                  onTapOutside: (_) {
                    if (searchQuery.value.isEmpty) {
                      isSearching.value = false;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color: AppColors.neutralMediumGray,
                      fontWeight: AppTypography.regular,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    filled: true,
                    fillColor: AppColors.neutralWhite,
                  ),
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.medium,
                  ),
                  cursorColor: AppColors.primaryBrownVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              if (searchQuery.value.isNotEmpty || searchFocusNode.hasFocus)
                InkWell(
                  onTap: () {
                    searchQuery.value = '';
                    isSearching.value = false;
                    searchFocusNode.unfocus();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.neutralLightGray.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.close,
                      color: AppColors.neutralMediumGray,
                      size: 16,
                    ),
                  ),
                )
              else
                const SizedBox(width: 0),
              const SizedBox(width: AppSpacing.xs),
              InkWell(
                onTap: () {
                  isSearching.value = false;
                  openFilterSheet();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.leafGreen,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.leafGreen.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: AppColors.neutralWhite,
                    size: 12,
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
        Color c = t == ItemType.goal
            ? AppColors.accentInfo
            : t == ItemType.success
            ? AppColors.accentWarning
            : AppColors.primaryBrown;
        String l = t == ItemType.goal
            ? 'Goals'
            : t == ItemType.success
            ? 'Successes'
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
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: chips,
        ),
      );
    }

    Widget buildItemCard(Note note) {
      return NoteCard(
        note: note,
        showCategoryIcon: true,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.noteDetail,
          arguments: {'noteId': note.id},
        ),
      );
    }

    final results = filteredItems();

    return Scaffold(
      backgroundColor: AppColors.secondaryBeigeDark,
      body: Container(
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
        child: Column(
          children: [
            buildHeader(),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSearchBar(),
                    buildActiveFilters(),
                    const SizedBox(height: AppSpacing.sm),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
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
                    const SizedBox(height: AppSpacing.sm),
                    ...results.map(buildItemCard),
                    const SizedBox(height: AppSpacing.massive),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
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
          const SizedBox(width: AppSpacing.sm),
          InkWell(
            onTap: onRemove,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
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
