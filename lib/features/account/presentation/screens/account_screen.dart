import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/account_header.dart';
import '../widgets/account_menu_item.dart';
import '../widgets/account_profile_section.dart';

class AccountScreen extends HookWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children: [
              Column(
                children: [
                  AccountHeader(
                    title: 'Account',
                    onBackTap: () => Navigator.of(context).pop(),
                    onSettingsTap: () {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Column(
                        children: [
                          AccountProfileSection(
                            name: 'Sarah Johnson',
                            subtitle: 'Goal achiever since 2024',
                            goalsCount: 24,
                            successCount: 18,
                            notesCount: 156,
                            avatarUrl:
                                'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-5.jpg',
                            onAvatarTap: () {},
                          ),
                          const SizedBox(height: 32),
                          Column(
                            children: [
                              AccountMenuItem(
                                type: AccountMenuItemType.personalInfo,
                                title: 'Personal Information',
                                subtitle: 'Edit your profile details',
                                icon: Icons.person,
                                onTap: () {},
                              ),
                              AccountMenuItem(
                                type: AccountMenuItemType.successOverview,
                                title: 'Success Overview',
                                subtitle: 'Track your achievements',
                                icon: Icons.show_chart,
                                onTap: () {},
                              ),
                              AccountMenuItem(
                                type: AccountMenuItemType.noteForYourself,
                                title: 'Note for Yourself',
                                subtitle: 'Personal reminders & thoughts',
                                icon: Icons.sticky_note_2,
                                onTap: () {},
                              ),
                              AccountMenuItem(
                                type: AccountMenuItemType.notifications,
                                title: 'Notifications',
                                subtitle: 'Manage alerts & reminders',
                                icon: Icons.notifications,
                                onTap: () {},
                              ),
                              AccountMenuItem(
                                type: AccountMenuItemType.signOut,
                                title: 'Sign Out',
                                subtitle: 'Logout from your account',
                                icon: Icons.logout,
                                onTap: () {},
                              ),
                              AccountMenuItem(
                                type: AccountMenuItemType.deleteAccount,
                                title: 'Delete Account',
                                subtitle: 'Permanently remove account',
                                icon: Icons.delete_forever,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 100,
                right: 16,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.network(
                    'https://storage.googleapis.com/uxpilot-auth.appspot.com/4ce53463e4-99ae16824d989071b24d.png',
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
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
