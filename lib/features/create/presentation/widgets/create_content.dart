import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../services/hive_service.dart';
import '../../../../shared/models/note_model.dart';
import '../../../../shared/widgets/app_button.dart';

enum CreateType { quickNotes, successes, goals, journal, habits, inspiration }

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

    NoteType mapCreateTypeToNoteType(CreateType createType) {
      switch (createType) {
        case CreateType.quickNotes:
          return NoteType.quickNotes;
        case CreateType.successes:
          return NoteType.successes;
        case CreateType.goals:
          return NoteType.goals;
        case CreateType.journal:
          return NoteType.journal;
        case CreateType.habits:
          return NoteType.habits;
        case CreateType.inspiration:
          return NoteType.inspiration;
      }
    }

    PriorityLevel mapPriorityLevelToNotePriority(PriorityLevel? priority) {
      switch (priority) {
        case PriorityLevel.high:
          return PriorityLevel.high;
        case PriorityLevel.medium:
          return PriorityLevel.medium;
        case PriorityLevel.low:
          return PriorityLevel.low;
        default:
          return PriorityLevel.medium;
      }
    }

    void onSave() async {
      final type = selectedType.value;
      final title = titleController.text.trim();
      final description = descriptionController.text.trim();

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

      try {
        // Map CreateType to NoteType
        final noteType = mapCreateTypeToNoteType(type);
        final priority = mapPriorityLevelToNotePriority(selectedPriority.value);

        final note = Note(
          id: const Uuid().v4(),
          title: title,
          description: description,
          type: noteType,
          priority: priority,
          createdAt: DateTime.now(),
          progressPercent: type == CreateType.goals
              ? int.tryParse(progressValueController.text)
              : null,
          progressUnit: type == CreateType.goals ? unitValue.value : null,
        );

        await HiveService.addNote(note);

        if (context.mounted) {
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

          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to save note. Please try again.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          );
        }
      }
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
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _TypeButton(
                      label: 'Quick Notes',
                      icon: Icons.note,
                      active: selectedType.value == CreateType.quickNotes,
                      activeBorderColor: AppColors.accentInfo,
                      gradient: const LinearGradient(
                        colors: [AppColors.accentInfo, Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => selectedType.value = CreateType.quickNotes,
                    ),
                  ),
                  AppSpacing.horizontalSpaceSmall,
                  Expanded(
                    child: _TypeButton(
                      label: 'Successes',
                      icon: Icons.emoji_events,
                      active: selectedType.value == CreateType.successes,
                      activeBorderColor: AppColors.accentSuccess,
                      gradient: const LinearGradient(
                        colors: [AppColors.accentSuccess, Color(0xFF059669)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => selectedType.value = CreateType.successes,
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalSpaceSmall,
              Row(
                children: [
                  Expanded(
                    child: _TypeButton(
                      label: 'Goals',
                      icon: Icons.my_location,
                      active: selectedType.value == CreateType.goals,
                      activeBorderColor: AppColors.accentWarning,
                      gradient: const LinearGradient(
                        colors: [AppColors.accentWarning, Color(0xFF7C3AED)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => selectedType.value = CreateType.goals,
                    ),
                  ),
                  AppSpacing.horizontalSpaceSmall,
                  Expanded(
                    child: _TypeButton(
                      label: 'Journal',
                      icon: Icons.book,
                      active: selectedType.value == CreateType.journal,
                      activeBorderColor: AppColors.accentError,
                      gradient: const LinearGradient(
                        colors: [AppColors.accentError, Color(0xFFEA580C)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => selectedType.value = CreateType.journal,
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalSpaceSmall,
              Row(
                children: [
                  Expanded(
                    child: _TypeButton(
                      label: 'Habits',
                      icon: Icons.calendar_today,
                      active: selectedType.value == CreateType.habits,
                      activeBorderColor: AppColors.leafGreen,
                      gradient: const LinearGradient(
                        colors: [AppColors.leafGreen, Color(0xFF0D9488)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => selectedType.value = CreateType.habits,
                    ),
                  ),
                  AppSpacing.horizontalSpaceSmall,
                  Expanded(
                    child: _TypeButton(
                      label: 'Inspiration',
                      icon: Icons.lightbulb,
                      active: selectedType.value == CreateType.inspiration,
                      activeBorderColor: AppColors.accentError,
                      gradient: const LinearGradient(
                        colors: [AppColors.accentError, Color(0xFFBE185D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => selectedType.value = CreateType.inspiration,
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.verticalSpaceLarge,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.neutralWhite,
                  AppColors.secondaryBeigeLight.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryBrown.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBrown.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.title,
                        size: 14,
                        color: AppColors.primaryBrown,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Text(
                      'Title',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceSmall,
                TextField(
                  controller: titleController,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.neutralMediumGray,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Give it a meaningful name...',
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color: AppColors.neutralMediumGray,
                    ),
                    filled: true,
                    fillColor: AppColors.neutralWhite.withValues(alpha: 0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.neutralMediumGray.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.neutralMediumGray.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.neutralMediumGray,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalSpaceSmall,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.neutralWhite,
                  AppColors.secondaryBeigeLight.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryBrown.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBrown.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.description,
                        size: 14,
                        color: AppColors.primaryBrown,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Text(
                      'Description',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceSmall,
                TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.neutralMediumGray,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Tell us more about it...',
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color: AppColors.neutralMediumGray,
                    ),
                    filled: true,
                    fillColor: AppColors.neutralWhite.withValues(alpha: 0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.neutralMediumGray.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.neutralMediumGray.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.neutralMediumGray,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (selectedType.value == CreateType.goals) ...[
            AppSpacing.verticalSpaceSmall,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.neutralWhite,
                    AppColors.accentSuccessLight.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.accentSuccessDark.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.accentSuccessDark.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.trending_up,
                          size: 14,
                          color: AppColors.accentSuccessDark,
                        ),
                      ),
                      AppSpacing.horizontalSpaceSmall,
                      Text(
                        'Target Progress',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.primaryBrown,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: progressValueController,
                          keyboardType: TextInputType.number,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.neutralMediumGray,
                          ),
                          decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: AppTypography.bodyMedium.copyWith(
                              color: AppColors.neutralMediumGray,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.accentSuccessDark.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.accentSuccessDark.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.accentSuccessDark,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.horizontalSpaceSmall,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentSuccessDark.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.accentSuccessDark.withValues(
                                alpha: 0.2,
                              ),
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: unitValue.value,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.neutralMediumGray,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.neutralWhite,
                  AppColors.secondaryBeigeLight.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryBrown.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBrown.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.flag,
                        size: 14,
                        color: AppColors.primaryBrown,
                      ),
                    ),
                    AppSpacing.horizontalSpaceSmall,
                    Text(
                      'Priority',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                  ],
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
    required this.gradient,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final Color activeBorderColor;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite,
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
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.neutralWhite, size: 20),
            ),
            AppSpacing.verticalSpaceSmall,
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: AppTypography.medium,
              ),
              textAlign: TextAlign.center,
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
