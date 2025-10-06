import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../navigations/app_routes.dart';
import '../../../shared/models/note_model.dart';
import '../app_card.dart';

class InspirationCard extends HookWidget {
  const InspirationCard({super.key, this.recentNotes = const [], this.onTap});

  final List<Note> recentNotes;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      backgroundColor: AppColors.neutralWhite,
      borderColor: AppColors.accentError.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.accentError, Color(0xFFBE185D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.lightbulb,
                      color: AppColors.neutralWhite,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inspiration',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.primaryBrownLight,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                      Text(
                        'Stay motivated',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.neutralMediumGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentError.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  recentNotes.length.toString(),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.accentError,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (recentNotes.isEmpty)
            Text(
              'Quotes and ideas to keep you inspired',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.neutralDarkGray,
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recentNotes.take(2).map((note) {
                final index = recentNotes.indexOf(note);
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < recentNotes.take(2).length - 1 ? 8 : 0,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.noteDetail,
                      arguments: {'noteId': note.id},
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.accentError,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            note.title,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.neutralDarkGray,
                              fontWeight: AppTypography.medium,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
