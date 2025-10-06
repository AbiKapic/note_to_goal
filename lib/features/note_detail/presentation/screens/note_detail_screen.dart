import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../services/hive_service.dart';
import '../../../../shared/models/note_model.dart';

class NoteDetailScreen extends HookWidget {
  const NoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useListenable(HiveService.notesListenable());

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final noteId = args != null ? args['noteId'] as String? : null;
    final note = noteId != null ? HiveService.getNoteById(noteId) : null;

    Color typeColor(NoteType type) {
      switch (type) {
        case NoteType.goals:
          return AppColors.accentInfo;
        case NoteType.successes:
          return AppColors.accentWarning;
        case NoteType.quickNotes:
        case NoteType.journal:
        case NoteType.habits:
        case NoteType.inspiration:
          return AppColors.primaryBrown;
      }
    }

    IconData typeIcon(NoteType type) {
      switch (type) {
        case NoteType.goals:
          return Icons.my_location;
        case NoteType.successes:
          return Icons.emoji_events;
        case NoteType.quickNotes:
        case NoteType.journal:
        case NoteType.habits:
        case NoteType.inspiration:
          return Icons.edit;
      }
    }

    if (note == null) {
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
              stops: const [0.0, 0.2, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _Header(
                  title: 'Note not found',
                  onBack: () => Navigator.maybePop(context),
                  icon: Icons.error_outline,
                  iconColor: AppColors.accentError,
                  showActions: false,
                ),
                const SizedBox(height: AppSpacing.massive),
                const Icon(
                  Icons.search_off,
                  color: AppColors.neutralMediumGray,
                  size: 48,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'The note you are looking for does not exist.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
            stops: const [0.0, 0.2, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                title: note.title,
                onBack: () => Navigator.maybePop(context),
                icon: typeIcon(note.type),
                iconColor: typeColor(note.type),
                isFavorite: note.isFavorite,
                isDisliked: note.isDisliked,
                onToggleFavorite: () => HiveService.toggleNoteFavorite(note.id),
                onToggleDisliked: () => HiveService.toggleNoteDisliked(note.id),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: typeColor(
                                note.type,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: typeColor(note.type)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  typeIcon(note.type),
                                  size: 14,
                                  color: typeColor(note.type),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  note.type.name,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: typeColor(note.type),
                                    fontWeight: AppTypography.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.neutralLightGray.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              note.priority.name.toUpperCase(),
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: AppTypography.semiBold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(note.createdAt),
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        note.description,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.medium,
                          height: 1.5,
                        ),
                      ),
                      if (note.progressPercent != null) ...[
                        const SizedBox(height: AppSpacing.xl),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppColors.neutralLightGray,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        (note.progressPercent!.clamp(0, 100) /
                                        100),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.accentSuccess,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              '${note.progressPercent}%',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.accentSuccess,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays == 0) return 'Today';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.onBack,
    required this.icon,
    required this.iconColor,
    this.isFavorite,
    this.isDisliked,
    this.onToggleFavorite,
    this.onToggleDisliked,
    this.showActions = true,
  });

  final String title;
  final VoidCallback onBack;
  final IconData icon;
  final Color iconColor;
  final bool? isFavorite;
  final bool? isDisliked;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onToggleDisliked;
  final bool showActions;

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
        children: [
          InkWell(
            onTap: onBack,
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: AppTypography.bold,
              ),
            ),
          ),
          if (showActions) ...[
            const SizedBox(width: AppSpacing.md),
            InkWell(
              onTap: onToggleFavorite,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.neutralWhite,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  (isFavorite ?? false)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: (isFavorite ?? false)
                      ? AppColors.accentError
                      : AppColors.primaryBrown,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            InkWell(
              onTap: onToggleDisliked,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.neutralWhite,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  (isDisliked ?? false)
                      ? Icons.thumb_down
                      : Icons.thumb_down_alt_outlined,
                  color: (isDisliked ?? false)
                      ? AppColors.accentError
                      : AppColors.primaryBrown,
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
