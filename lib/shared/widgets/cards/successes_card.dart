import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/note_model.dart';
import '../app_card.dart';

class SuccessesCard extends HookWidget {
  const SuccessesCard({super.key, this.recentNotes = const [], this.onTap});

  final List<Note> recentNotes;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      backgroundColor: AppColors.neutralWhite,
      borderColor: AppColors.accentSuccess.withValues(alpha: 0.3),
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
                        colors: [AppColors.accentSuccess, Color(0xFF059669)],
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
                      Icons.emoji_events,
                      color: AppColors.neutralWhite,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Successes',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.primaryBrownLight,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                      Text(
                        'Celebrate wins',
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
                  color: AppColors.accentSuccess.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  recentNotes.length.toString(),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.accentSuccess,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Track and celebrate your achievements',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.neutralDarkGray,
            ),
          ),
        ],
      ),
    );
  }
}
