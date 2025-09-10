import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AccountProfileSection extends StatelessWidget {
  const AccountProfileSection({
    super.key,
    required this.name,
    required this.subtitle,
    required this.goalsCount,
    required this.successCount,
    required this.notesCount,
    this.avatarUrl,
    this.onAvatarTap,
  });

  final String name;
  final String subtitle;
  final int goalsCount;
  final int successCount;
  final int notesCount;
  final String? avatarUrl;
  final VoidCallback? onAvatarTap;

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: AppTypography.bold,
            color: color,
          ),
        ),
        AppSpacing.verticalSpaceTiny,
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 32,
      color: AppColors.treeBrown.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
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
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.neutralWhite, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: avatarUrl != null
                      ? Image.network(
                          avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.softCream,
                              child: Icon(
                                Icons.account_circle,
                                size: 48,
                                color: AppColors.treeBrown.withOpacity(0.5),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.softCream,
                          child: Icon(
                            Icons.account_circle,
                            size: 48,
                            color: AppColors.treeBrown.withOpacity(0.5),
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: GestureDetector(
                  onTap: onAvatarTap,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.leafGreen, AppColors.treeBrown],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.neutralWhite,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSpaceLarge,
          Text(
            name,
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: AppTypography.bold,
              color: AppColors.treeBrown,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalSpaceSmall,
          Text(
            subtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem(
                goalsCount.toString(),
                'Goals',
                AppColors.leafGreen,
              ),
              AppSpacing.horizontalSpaceLarge,
              _buildDivider(),
              AppSpacing.horizontalSpaceLarge,
              _buildStatItem(
                successCount.toString(),
                'Success',
                AppColors.treeBrown,
              ),
              AppSpacing.horizontalSpaceLarge,
              _buildDivider(),
              AppSpacing.horizontalSpaceLarge,
              _buildStatItem(
                notesCount.toString(),
                'Notes',
                Colors.yellow[600]!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
