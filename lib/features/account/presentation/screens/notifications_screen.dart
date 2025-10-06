import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/account_header.dart';

class NotificationsScreen extends HookWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pushNotifications = useState(true);
    final emailNotifications = useState(false);
    final goalReminders = useState(true);
    final successCelebrations = useState(true);
    final weeklyProgress = useState(true);
    final habitReminders = useState(false);

    Widget buildNotificationTile({
      required String title,
      required String description,
      required bool value,
      required ValueChanged<bool> onChanged,
      required IconData icon,
      Color? iconColor,
    }) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.treeBrown.withValues(alpha: 0.2),
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onChanged(!value),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppColors.leafGreen).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: iconColor ?? AppColors.leafGreen,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.treeBrown,
                            fontWeight: AppTypography.semiBold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: value,
                    onChanged: onChanged,
                    activeColor: AppColors.leafGreen,
                    activeTrackColor: AppColors.leafGreen.withValues(alpha: 0.3),
                    inactiveThumbColor: AppColors.neutralMediumGray,
                    inactiveTrackColor: AppColors.neutralLightGray,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget buildSectionHeader(String title) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          title,
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.treeBrown,
            fontWeight: AppTypography.bold,
          ),
        ),
      );
    }

    Widget buildNotificationPreview() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.leafGreen.withValues(alpha: 0.1),
              AppColors.warmYellow.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.leafGreen.withValues(alpha: 0.3),
            width: 1,
          ),
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
                    color: AppColors.leafGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.preview,
                    size: 18,
                    color: AppColors.leafGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Notification Preview',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.treeBrown,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.neutralWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.leafGreen, AppColors.treeBrown],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.eco,
                      color: AppColors.neutralWhite,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NoteToGoal',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.treeBrown,
                            fontWeight: AppTypography.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Time to check your goal progress! 🌱',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'now',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                title: 'Notifications',
                onBackTap: () => Navigator.of(context).pop(),
                onSettingsTap: () {},
                settingsIcon: Icons.tune,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      
                      buildNotificationPreview(),
                      
                      buildSectionHeader('General Notifications'),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            buildNotificationTile(
                              title: 'Push Notifications',
                              description: 'Receive notifications directly on your device',
                              value: pushNotifications.value,
                              onChanged: (value) => pushNotifications.value = value,
                              icon: Icons.notifications,
                              iconColor: AppColors.accentInfo,
                            ),
                            buildNotificationTile(
                              title: 'Email Notifications',
                              description: 'Get updates via email',
                              value: emailNotifications.value,
                              onChanged: (value) => emailNotifications.value = value,
                              icon: Icons.email,
                              iconColor: AppColors.accentWarning,
                            ),
                          ],
                        ),
                      ),
                      
                      buildSectionHeader('Goal & Progress'),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            buildNotificationTile(
                              title: 'Goal Reminders',
                              description: 'Daily reminders to work on your goals',
                              value: goalReminders.value,
                              onChanged: (value) => goalReminders.value = value,
                              icon: Icons.my_location,
                              iconColor: AppColors.leafGreen,
                            ),
                            buildNotificationTile(
                              title: 'Success Celebrations',
                              description: 'Celebrate when you achieve milestones',
                              value: successCelebrations.value,
                              onChanged: (value) => successCelebrations.value = value,
                              icon: Icons.emoji_events,
                              iconColor: AppColors.accentWarning,
                            ),
                            buildNotificationTile(
                              title: 'Weekly Progress Report',
                              description: 'Summary of your weekly achievements',
                              value: weeklyProgress.value,
                              onChanged: (value) => weeklyProgress.value = value,
                              icon: Icons.trending_up,
                              iconColor: AppColors.accentSuccess,
                            ),
                          ],
                        ),
                      ),
                      
                      buildSectionHeader('Habits & Routines'),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            buildNotificationTile(
                              title: 'Habit Reminders',
                              description: 'Reminders for your daily habits',
                              value: habitReminders.value,
                              onChanged: (value) => habitReminders.value = value,
                              icon: Icons.calendar_today,
                              iconColor: AppColors.treeBrown,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Info card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.accentInfo.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.accentInfo.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.accentInfo,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'You can customize notification times and frequency in your device settings.',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
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
