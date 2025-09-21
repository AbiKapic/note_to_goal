import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../navigations/app_routes.dart';
import '../../../../services/hive_service.dart';
import '../../../../shared/models/note_model.dart';
import '../../../../shared/widgets/cards/index.dart';

class _NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useListenable(HiveService.notesListenable());
    final notesCountByType = useMemoized(
      () => HiveService.getAllNotesCountByType(),
      [HiveService.getAllNotes().length],
    );
    final recentNotesByType = useMemoized(() {
      final Map<NoteType, List<Note>> recentNotes = {};
      for (final type in NoteType.values) {
        recentNotes[type] = HiveService.getNotesByType(type).take(2).toList();
      }
      return recentNotes;
    }, [HiveService.getAllNotes().length]);

    void openAccountPage() {
      Navigator.of(context).pushNamed(AppRoutes.account);
    }

    void openLibraryPage(NoteType type) {
      Navigator.of(
        context,
      ).pushNamed(AppRoutes.library, arguments: {'noteType': type});
    }

    Widget buildHeader() {
      return Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: MediaQuery.of(context).viewPadding.top,
          bottom: 16,
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
              color: Color(0x40000000),
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
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBeigeVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.eco,
                    color: AppColors.primaryBrownLight,
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
                        color: AppColors.primaryBrownLight,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    Text(
                      'Grow your dreams',
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
                    color: AppColors.primaryBrownLight,
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
                      color: AppColors.primaryBrownLight,
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
            colors: [
              AppColors.secondaryBeigeDark,
              AppColors.softCream,
              AppColors.leafGreen,
            ],
            stops: [0.0, 0.5, 1.0],
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
                        color: AppColors.primaryBrownLight,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ready to grow today?',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primaryBrown,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBrown.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.park,
                    color: AppColors.primaryBrownLight,
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
                    color: AppColors.primaryBrownLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buildNewStatCard({
      required NoteType type,
      required String value,
      required String label,
    }) {
      final bool isGoals = type == NoteType.goals;
      final bool isSuccess = type == NoteType.successes;
      final bool isNotes = type == NoteType.quickNotes;

      final Gradient backgroundGradient = isSuccess
          ? LinearGradient(
              colors: [AppColors.neutralWhite, AppColors.accentSuccessLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : LinearGradient(
              colors: isGoals
                  ? [AppColors.accentSuccessDark, AppColors.accentSuccess]
                  : [AppColors.accentSuccess, AppColors.leafGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );

      final BoxBorder border = isSuccess
          ? Border.all(
              color: AppColors.accentSuccess.withValues(alpha: 0.3),
              width: 2,
            )
          : Border.all(color: Colors.transparent, width: 0);

      final Color primaryTextColor = isSuccess
          ? AppColors.accentSuccessDark
          : AppColors.neutralWhite;

      final Color labelTextColor = isSuccess
          ? AppColors.accentSuccess
          : AppColors.neutralWhite.withValues(alpha: 0.8);

      final Widget iconBox = Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: isSuccess
              ? LinearGradient(
                  colors: [
                    AppColors.accentSuccess,
                    AppColors.accentSuccessDark,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSuccess
              ? null
              : AppColors.neutralWhite.withValues(alpha: 0.2),
        ),
        child: Icon(
          isGoals
              ? Icons.my_location
              : isSuccess
              ? Icons.emoji_events
              : Icons.sticky_note_2,
          color: AppColors.neutralWhite,
          size: 16,
        ),
      );

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(16),
          border: border,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              top: isNotes ? null : 6,
              right: isNotes ? null : 6,
              left: isNotes ? 6 : null,
              bottom: isNotes ? 6 : null,
              child: Container(
                width: isSuccess ? 42 : 50,
                height: isSuccess ? 42 : 50,
                decoration: BoxDecoration(
                  color:
                      (isSuccess
                              ? AppColors.accentSuccess
                              : AppColors.neutralWhite)
                          .withValues(alpha: isSuccess ? 0.06 : 0.12),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iconBox,
                const SizedBox(height: 8),
                Text(
                  value,
                  style: AppTypography.headlineMedium.copyWith(
                    color: primaryTextColor,
                    fontWeight: AppTypography.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(
                    color: labelTextColor,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: isGoals
                          ? 24
                          : isSuccess
                          ? 16
                          : 20,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSuccess
                            ? AppColors.accentSuccess
                            : AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: isGoals
                          ? 8
                          : isSuccess
                          ? 8
                          : 6,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSuccess
                            ? AppColors.accentSuccess.withValues(alpha: 0.5)
                            : AppColors.neutralWhite.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: isGoals
                          ? 12
                          : isSuccess
                          ? 12
                          : 10,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSuccess
                            ? AppColors.accentSuccess.withValues(alpha: 0.3)
                            : AppColors.neutralWhite.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(2),
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

    Widget buildStatsSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: buildNewStatCard(
                type: NoteType.goals,
                value: '${notesCountByType[NoteType.goals] ?? 0}',
                label: 'Goals',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: buildNewStatCard(
                type: NoteType.successes,
                value: '${notesCountByType[NoteType.successes] ?? 0}',
                label: 'Success',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: buildNewStatCard(
                type: NoteType.quickNotes,
                value: '${notesCountByType[NoteType.quickNotes] ?? 0}',
                label: 'Notes',
              ),
            ),
          ],
        ),
      );
    }

    Widget buildRecentlyAddedCards() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recently Added',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.primaryBrownLight,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            GoalsCard(
              recentNotes: recentNotesByType[NoteType.goals] ?? [],
              onTap: () => openLibraryPage(NoteType.goals),
            ),
            const SizedBox(height: 16),
            JournalCard(
              recentNotes: recentNotesByType[NoteType.journal] ?? [],
              onTap: () => openLibraryPage(NoteType.journal),
            ),
            const SizedBox(height: 16),
            HabitsCard(
              recentNotes: recentNotesByType[NoteType.habits] ?? [],
              onTap: () => openLibraryPage(NoteType.habits),
            ),
            const SizedBox(height: 16),
            InspirationCard(
              recentNotes: recentNotesByType[NoteType.inspiration] ?? [],
              onTap: () => openLibraryPage(NoteType.inspiration),
            ),
            const SizedBox(height: 16),
            QuickNotesCard(
              recentNotes: recentNotesByType[NoteType.quickNotes] ?? [],
              onTap: () => openLibraryPage(NoteType.quickNotes),
            ),
            const SizedBox(height: 16),
            SuccessesCard(
              recentNotes: recentNotesByType[NoteType.successes] ?? [],
              onTap: () => openLibraryPage(NoteType.successes),
            ),
          ],
        ),
      );
    }

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
          child: ScrollConfiguration(
            behavior: _NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(),
                    buildWelcomeSection(),
                    buildStatsSection(),
                    buildRecentlyAddedCards(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
