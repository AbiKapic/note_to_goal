import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/auth/bloc/auth_bloc.dart';
import '../../../../features/auth/bloc/auth_event.dart';
import '../../../../features/auth/bloc/auth_state.dart';
import '../widgets/account_header.dart';
import '../widgets/account_menu_item.dart';
import '../widgets/account_profile_section.dart';

class AccountScreen extends HookWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSigningOut = useState(false);

    void handleSignOut() {
      if (isSigningOut.value) return;

      final authBloc = context.read<AuthBloc>();
      isSigningOut.value = true;
      authBloc.add(const AuthLogoutRequested());
    }

    return BlocListener<AuthBloc, BaseState<AuthUser>>(
      listener: (context, state) {
        if (state is AuthLoading && isSigningOut.value) {
        } else if (state is AuthUnauthenticated && isSigningOut.value) {
          isSigningOut.value = false;
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } else if (state is AuthError && isSigningOut.value) {
          isSigningOut.value = false;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
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
                                  onTap: handleSignOut,
                                  isLoading: isSigningOut.value,
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
      ),
    );
  }
}
