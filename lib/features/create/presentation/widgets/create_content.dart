import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';

enum CreateType { goal, success, note }

enum PriorityLevel { high, medium, low }

class CreateContent extends HookWidget {
  const CreateContent({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedType = useState<CreateType?>(null);
    final selectedPriority = useState<PriorityLevel?>(null);
    final progressValueController = useTextEditingController();
    final unitValue = useState<String>('days');

    void onSave() {
      final type = selectedType.value;
      final title = titleController.text.trim();
      if (type == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select a type',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        );
        return;
      }
      if (title.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please enter a title',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.spa, color: AppColors.primaryBrown),
              const SizedBox(width: 8),
              Text(
                'Item saved successfully! 🌱',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryBeigeLight,
                  AppColors.secondaryBeige,
                ],
              ),
              border: Border.all(
                color: AppColors.primaryBrown.withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.lightbulb,
                    size: 32,
                    color: AppColors.primaryBrown.withValues(alpha: 0.25),
                  ),
                ),
                Text(
                  "What's Growing?",
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.primaryBrown,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
                AppSpacing.verticalSpaceTiny,
                Text(
                  'Every great achievement starts with an idea',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primaryBrownVariant,
                  ),
                ),
                AppSpacing.verticalSpaceSmall,
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.accentSuccessDark,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Text(
                      'Ready to create something amazing',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primaryBrown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.verticalSpaceLarge,
          Text(
            'Choose Type',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primaryBrown,
              fontWeight: AppTypography.semiBold,
            ),
          ),
          AppSpacing.verticalSpaceSmall,
          Row(
            children: [
              Expanded(
                child: _TypeButton(
                  label: 'Goal',
                  icon: Icons.track_changes,
                  active: selectedType.value == CreateType.goal,
                  activeBorderColor: AppColors.accentSuccessDark,
                  background: Colors.white,
                  indicatorBackground: Colors.green.withValues(alpha: 0.2),
                  indicatorColor: Colors.green.shade700,
                  onTap: () => selectedType.value = CreateType.goal,
                ),
              ),
              AppSpacing.horizontalSpaceSmall,
              Expanded(
                child: _TypeButton(
                  label: 'Success',
                  icon: Icons.emoji_events,
                  active: selectedType.value == CreateType.success,
                  activeBorderColor: Colors.amber.shade600,
                  background: Colors.white,
                  indicatorBackground: Colors.amber.withValues(alpha: 0.2),
                  indicatorColor: Colors.amber.shade700,
                  onTap: () => selectedType.value = CreateType.success,
                ),
              ),
              AppSpacing.horizontalSpaceSmall,
              Expanded(
                child: _TypeButton(
                  label: 'Note',
                  icon: Icons.edit,
                  active: selectedType.value == CreateType.note,
                  activeBorderColor: Colors.teal.shade600,
                  background: Colors.white,
                  indicatorBackground: Colors.teal.withValues(alpha: 0.2),
                  indicatorColor: Colors.teal.shade700,
                  onTap: () => selectedType.value = CreateType.note,
                ),
              ),
            ],
          ),
          AppSpacing.verticalSpaceLarge,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.secondaryBeigeDark.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.primaryBrown,
                    fontWeight: AppTypography.medium,
                  ),
                ),
                AppSpacing.verticalSpaceSmall,
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Give it a meaningful name...',
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalSpaceSmall,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.secondaryBeigeDark.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.primaryBrown,
                    fontWeight: AppTypography.medium,
                  ),
                ),
                AppSpacing.verticalSpaceSmall,
                TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Tell us more about it...',
                  ),
                ),
              ],
            ),
          ),
          if (selectedType.value == CreateType.goal) ...[
            AppSpacing.verticalSpaceSmall,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.secondaryBeigeDark.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Target Progress',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.primaryBrown,
                      fontWeight: AppTypography.medium,
                    ),
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: progressValueController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: '0'),
                        ),
                      ),
                      AppSpacing.horizontalSpaceSmall,
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: unitValue.value,
                          items: const [
                            DropdownMenuItem(
                              value: 'days',
                              child: Text('Days'),
                            ),
                            DropdownMenuItem(
                              value: 'weeks',
                              child: Text('Weeks'),
                            ),
                            DropdownMenuItem(
                              value: 'tasks',
                              child: Text('Tasks'),
                            ),
                            DropdownMenuItem(
                              value: 'hours',
                              child: Text('Hours'),
                            ),
                            DropdownMenuItem(
                              value: 'pages',
                              child: Text('Pages'),
                            ),
                          ],
                          onChanged: (v) => unitValue.value = v ?? 'days',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          AppSpacing.verticalSpaceSmall,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.secondaryBeigeDark.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Priority',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.primaryBrown,
                    fontWeight: AppTypography.medium,
                  ),
                ),
                AppSpacing.verticalSpaceSmall,
                Row(
                  children: [
                    Expanded(
                      child: _PriorityButton(
                        label: 'High',
                        color: Colors.red.shade600,
                        background: Colors.red.shade50,
                        active: selectedPriority.value == PriorityLevel.high,
                        onTap: () =>
                            selectedPriority.value = PriorityLevel.high,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Expanded(
                      child: _PriorityButton(
                        label: 'Medium',
                        color: Colors.amber.shade700,
                        background: Colors.amber.shade50,
                        active: selectedPriority.value == PriorityLevel.medium,
                        onTap: () =>
                            selectedPriority.value = PriorityLevel.medium,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Expanded(
                      child: _PriorityButton(
                        label: 'Low',
                        color: Colors.green.shade700,
                        background: Colors.green.shade50,
                        active: selectedPriority.value == PriorityLevel.low,
                        onTap: () => selectedPriority.value = PriorityLevel.low,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.verticalSpaceLarge,
          AppButton(
            onPressed: onSave,
            text: 'Save & Grow',
            leadingIcon: Icons.check,
          ),
          AppSpacing.verticalSpaceLarge,
        ],
      ),
    );
  }
}

class _TypeButton extends HookWidget {
  const _TypeButton({
    required this.label,
    required this.icon,
    required this.active,
    required this.activeBorderColor,
    required this.background,
    required this.indicatorBackground,
    required this.indicatorColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final Color activeBorderColor;
  final Color background;
  final Color indicatorBackground;
  final Color indicatorColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? activeBorderColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: indicatorBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: indicatorColor, size: 22),
            ),
            AppSpacing.verticalSpaceSmall,
            Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: AppTypography.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityButton extends HookWidget {
  const _PriorityButton({
    required this.label,
    required this.color,
    required this.background,
    required this.active,
    required this.onTap,
  });

  final String label;
  final Color color;
  final Color background;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? color.withValues(alpha: 0.6) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 10, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: color,
                  fontWeight: AppTypography.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
