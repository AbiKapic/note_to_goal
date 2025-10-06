import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../models/note_model.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.showCategoryIcon = false,
  });

  final Note note;
  final VoidCallback? onTap;
  final bool showCategoryIcon;

  Color _typeColor(NoteType type) {
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

  IconData _typeIcon(NoteType type) {
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

  Color _priorityColor(PriorityLevel p) {
    switch (p) {
      case PriorityLevel.high:
        return AppColors.accentError;
      case PriorityLevel.medium:
        return AppColors.accentWarning;
      case PriorityLevel.low:
        return AppColors.accentSuccess;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays == 0) return 'Today';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showCategoryIcon)
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _typeColor(note.type).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_typeIcon(note.type), color: _typeColor(note.type)),
              ),
            if (showCategoryIcon) const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          note.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: AppTypography.semiBold,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _priorityColor(note.priority),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            note.priority.name[0].toUpperCase() +
                                note.priority.name.substring(1),
                            style: AppTypography.labelSmall.copyWith(
                              color: _priorityColor(note.priority),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    note.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(note.createdAt),
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      if (note.progressPercent != null)
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
                                      (note.progressPercent!.clamp(0, 100) /
                                          100),
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.accentSuccess,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              '${note.progressPercent}%',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.accentSuccess,
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
}




