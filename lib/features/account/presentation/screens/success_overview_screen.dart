import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../services/hive_service.dart';
import '../../../../shared/models/note_model.dart';
import '../../../../shared/widgets/note_card.dart';
import '../widgets/account_header.dart';

class SuccessOverviewScreen extends HookWidget {
  const SuccessOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useListenable(HiveService.notesListenable());
    
    final allNotes = HiveService.getAllNotes();
    final successNotes = HiveService.getNotesByType(NoteType.successes);
    final goalNotes = HiveService.getNotesByType(NoteType.goals);
    
    final totalNotes = allNotes.length;
    final completedGoals = goalNotes.where((note) => (note.progressPercent ?? 0) >= 100).length;
    final averageProgress = goalNotes.isNotEmpty 
        ? goalNotes.map((note) => note.progressPercent ?? 0).reduce((a, b) => a + b) / goalNotes.length
        : 0.0;

    Widget buildStatCard({
      required String title,
      required String value,
      required IconData icon,
      required Color color,
      String? subtitle,
    }) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.neutralWhite.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 22, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: AppTypography.headlineMedium.copyWith(
                  color: color,
                  fontWeight: AppTypography.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: AppTypography.medium,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    Widget buildProgressChart() {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.treeBrown.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.accentSuccess.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.trending_up,
                    size: 18,
                    color: AppColors.accentSuccess,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Goal Progress Overview',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.treeBrown,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Progress bar
            Row(
              children: [
                Text(
                  'Average Progress',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${averageProgress.toStringAsFixed(1)}%',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.accentSuccess,
                    fontWeight: AppTypography.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.neutralLightGray,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 88) * (averageProgress.clamp(0, 100) / 100),
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.leafGreen, AppColors.accentSuccess],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            Text(
              'You\'re making great progress! Keep pushing towards your goals.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildRecentSuccesses() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Recent Successes',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.treeBrown,
                fontWeight: AppTypography.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (successNotes.isEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.neutralWhite.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.treeBrown.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.warmYellow.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      size: 32,
                      color: AppColors.treeBrown.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No successes recorded yet',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.treeBrown,
                      fontWeight: AppTypography.semiBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start celebrating your wins by adding success entries!',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          else
            ...successNotes.take(5).map((note) => NoteCard(
              note: note,
              showCategoryIcon: false,
              onTap: () {
                // Navigate to note detail
              },
            )),
        ],
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.warmYellow,
              AppColors.softCream,
              AppColors.leafGreen,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AccountHeader(
                title: 'Success Overview',
                onBackTap: () => Navigator.of(context).pop(),
                onSettingsTap: () {},
                settingsIcon: Icons.analytics,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      
                      // Statistics cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                buildStatCard(
                                  title: 'Total Notes',
                                  value: totalNotes.toString(),
                                  icon: Icons.note,
                                  color: AppColors.accentInfo,
                                ),
                                const SizedBox(width: 16),
                                buildStatCard(
                                  title: 'Completed Goals',
                                  value: completedGoals.toString(),
                                  icon: Icons.flag,
                                  color: AppColors.accentSuccess,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                buildStatCard(
                                  title: 'Success Stories',
                                  value: successNotes.length.toString(),
                                  icon: Icons.emoji_events,
                                  color: AppColors.accentWarning,
                                ),
                                const SizedBox(width: 16),
                                buildStatCard(
                                  title: 'Active Goals',
                                  value: (goalNotes.length - completedGoals).toString(),
                                  icon: Icons.trending_up,
                                  color: AppColors.leafGreen,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Progress chart
                      if (goalNotes.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: buildProgressChart(),
                        ),
                        const SizedBox(height: 32),
                      ],
                      
                      // Recent successes
                      buildRecentSuccesses(),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
