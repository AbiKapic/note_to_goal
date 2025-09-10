import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/create_content.dart';

class CreateScreen extends HookWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void openAccountSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.neutralWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.neutralLightGray,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                AppSpacing.verticalSpaceLarge,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.secondaryBeigeLight,
                    ),
                    AppSpacing.horizontalSpaceMedium,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Growing since 2024',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceLarge,
                _SheetItem(
                  icon: Icons.notifications,
                  color: Colors.blue,
                  label: 'Notifications',
                ),
                _SheetItem(
                  icon: Icons.settings,
                  color: Colors.purple,
                  label: 'Settings',
                ),
                _SheetItem(
                  icon: Icons.show_chart,
                  color: Colors.green,
                  label: 'Progress',
                ),
                _SheetItem(
                  icon: Icons.help,
                  color: Colors.orange,
                  label: 'Help & Support',
                ),
                AppSpacing.verticalSpaceLarge,
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.secondaryBeige,
                      foregroundColor: AppColors.textPrimary,
                    ),
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void openSearchSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.neutralWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) {
          final controller = TextEditingController();
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.neutralLightGray,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                AppSpacing.verticalSpaceLarge,
                Text(
                  'Search Your Growth',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                AppSpacing.verticalSpaceMedium,
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Search goals, notes, successes...',
                  ),
                ),
                AppSpacing.verticalSpaceLarge,
                Wrap(
                  spacing: 8,
                  children: const [
                    _QuickFilter(
                      label: 'Goals',
                      icon: Icons.track_changes,
                      color: Colors.green,
                    ),
                    _QuickFilter(
                      label: 'Success',
                      icon: Icons.emoji_events,
                      color: Colors.amber,
                    ),
                    _QuickFilter(
                      label: 'Notes',
                      icon: Icons.edit,
                      color: Colors.teal,
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceLarge,
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.secondaryBeige,
                      foregroundColor: AppColors.textPrimary,
                    ),
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryBeige,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.primaryBrown,
                    AppColors.primaryBrownVariant,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _CircleIconButton(
                        icon: Icons.arrow_back,
                        background: AppColors.secondaryBeigeVariant.withOpacity(
                          0.6,
                        ),
                        foreground: AppColors.primaryBrown,
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      AppSpacing.horizontalSpaceMedium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create New',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.textOnBrown,
                                  fontWeight: AppTypography.bold,
                                ),
                          ),
                          Text(
                            'Plant your idea',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textOnBrown.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _CircleIconButton(
                        icon: Icons.search,
                        background: AppColors.secondaryBeigeVariant.withOpacity(
                          0.6,
                        ),
                        foreground: AppColors.primaryBrown,
                        onTap: openSearchSheet,
                      ),
                      AppSpacing.horizontalSpaceSmall,
                      _CircleIconButton(
                        icon: Icons.person,
                        background: AppColors.secondaryBeigeVariant.withOpacity(
                          0.6,
                        ),
                        foreground: AppColors.primaryBrown,
                        onTap: openAccountSheet,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(child: CreateContent()),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends HookWidget {
  const _CircleIconButton({
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, color: foreground, size: 18),
      ),
    );
  }
}

class _SheetItem extends HookWidget {
  const _SheetItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            AppSpacing.horizontalSpaceMedium,
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: AppTypography.medium,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.neutralMediumGray),
          ],
        ),
      ),
    );
  }
}

class _QuickFilter extends HookWidget {
  const _QuickFilter({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(label, style: AppTypography.bodySmall.copyWith(color: color)),
        ],
      ),
    );
  }
}
