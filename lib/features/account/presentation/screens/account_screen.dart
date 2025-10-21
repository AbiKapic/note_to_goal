import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../features/auth/bloc/auth_bloc.dart';
import '../../../../features/auth/bloc/auth_event.dart';
import '../../../../features/auth/bloc/auth_state.dart';
import '../../../../services/hive_service.dart';
import '../../../../services/profile_service.dart';
import '../../../../shared/models/note_model.dart';
import '../../../../shared/models/user_profile_model.dart';
import 'notifications_screen.dart';
import 'personal_info_screen.dart';
import 'success_overview_screen.dart';

class _NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

class AccountScreen extends HookWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useListenable(HiveService.notesListenable());
    useListenable(ProfileService.instance.listenable);

    final isSigningOut = useState(false);
    final notesCountByType = useMemoized(
      () => HiveService.getAllNotesCountByType(),
      [HiveService.getAllNotes().length],
    );
    final goalNotes = HiveService.getNotesByType(NoteType.goals);
    final completedGoals = goalNotes
        .where((note) => (note.progressPercent ?? 0) >= 100)
        .length;

    final currentProfile = useState<UserProfile?>(null);

    Future<void> loadProfile() async {
      try {
        final profile = await ProfileService.instance.getCurrentProfile();
        currentProfile.value = profile;
      } catch (e) {
        print('Error loading profile: $e');
      }
    }

    useEffect(() {
      loadProfile();
      return null;
    }, []);

    void handleSignOut() {
      if (isSigningOut.value) return;

      final authBloc = context.read<AuthBloc>();
      isSigningOut.value = true;
      authBloc.add(const AuthLogoutRequested());
    }

    Widget buildStatItem(String value, String label, IconData icon) {
      return Column(
        children: [
          Icon(icon, color: AppColors.neutralWhite, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.neutralWhite,
              fontWeight: AppTypography.bold,
            ),
          ),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.neutralWhite.withValues(alpha: 0.8),
            ),
          ),
        ],
      );
    }

    Widget buildMenuCard({
      required String title,
      required String subtitle,
      required IconData icon,
      required VoidCallback onTap,
      bool isLoading = false,
      bool isDestructive = false,
    }) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDestructive
                ? AppColors.accentError.withValues(alpha: 0.2)
                : AppColors.treeBrown.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.accentError.withValues(alpha: 0.1)
                      : AppColors.leafGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isDestructive
                      ? AppColors.accentError
                      : AppColors.leafGreen,
                  size: 20,
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
                        color: isDestructive
                            ? AppColors.accentError
                            : AppColors.primaryBrownLight,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.leafGreen,
                  ),
                )
              else
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
            ],
          ),
        ),
      );
    }

    Widget buildHeader() {
      return Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: MediaQuery.of(context).viewPadding.top,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.secondaryBeigeDark,
              AppColors.softCream,
              AppColors.leafGreen,
            ],
            stops: [0.0, 0.2, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 6),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBeigeVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primaryBrownLight,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account',
                      style: AppTypography.headlineSmall.copyWith(
                        color: AppColors.primaryBrownLight,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    Text(
                      'Manage your profile',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: AppTypography.semiBold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBeigeVariant,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: AppColors.primaryBrownLight,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBeigeVariant,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.primaryBrownLight,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buildProfileSection() {
      return Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryBrownLight,
                  AppColors.treeBrown,
                  AppColors.leafGreen,
                ],
                stops: [0.0, 0.6, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: -30,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: AppColors.neutralWhite.withValues(
                                  alpha: 0.3,
                                ),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(38),
                              child:
                                  currentProfile.value?.profileImageUrl != null
                                  ? Image.network(
                                      currentProfile.value!.profileImageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: AppColors.neutralWhite
                                                  .withValues(alpha: 0.1),
                                              child: Icon(
                                                Icons.person,
                                                color: AppColors.neutralWhite,
                                                size: 40,
                                              ),
                                            );
                                          },
                                    )
                                  : Container(
                                      color: AppColors.neutralWhite.withValues(
                                        alpha: 0.1,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.neutralWhite,
                                        size: 40,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentProfile.value?.name ?? 'User',
                                  style: AppTypography.headlineMedium.copyWith(
                                    color: AppColors.neutralWhite,
                                    fontWeight: AppTypography.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currentProfile.value?.email ??
                                      'user@email.com',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.neutralWhite.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.neutralWhite.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    'Member since ${currentProfile.value?.createdAt.year ?? DateTime.now().year}',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.neutralWhite,
                                      fontWeight: AppTypography.semiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.neutralWhite.withValues(
                              alpha: 0.2,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildStatItem(
                              '${notesCountByType[NoteType.goals] ?? 0}',
                              'Goals',
                              Icons.my_location,
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: AppColors.neutralWhite.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            buildStatItem(
                              '$completedGoals',
                              'Completed',
                              Icons.emoji_events,
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: AppColors.neutralWhite.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            buildStatItem(
                              '${notesCountByType[NoteType.quickNotes] ?? 0}',
                              'Notes',
                              Icons.sticky_note_2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildMenuSection() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Settings',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.primaryBrownLight,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            buildMenuCard(
              title: 'Personal Information',
              subtitle: 'Edit your profile details',
              icon: Icons.person,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PersonalInfoScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              title: 'Success Overview',
              subtitle: 'Track your achievements',
              icon: Icons.show_chart,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SuccessOverviewScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              title: 'Notifications',
              subtitle: 'Manage alerts & reminders',
              icon: Icons.notifications,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              title: 'Note for Yourself',
              subtitle: 'Personal reminders & thoughts',
              icon: Icons.sticky_note_2,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Personal notes feature coming soon!'),
                    backgroundColor: AppColors.leafGreen,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Account Actions',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.primaryBrownLight,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            buildMenuCard(
              title: 'Sign Out',
              subtitle: 'Logout from your account',
              icon: Icons.logout,
              onTap: handleSignOut,
              isLoading: isSigningOut.value,
              isDestructive: true,
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              title: 'Delete Account',
              subtitle: 'Permanently remove account',
              icon: Icons.delete_forever,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete Account'),
                    content: Text(
                      'Are you sure you want to permanently delete your account? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Account deletion feature coming soon',
                              ),
                              backgroundColor: AppColors.accentError,
                            ),
                          );
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              isDestructive: true,
            ),
          ],
        ),
      );
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
        backgroundColor: AppColors.secondaryBeigeDark,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryBeigeLight,
                  AppColors.neutralWhite,
                  AppColors.accentSuccessLight,
                ],
                stops: [0.0, 0.2, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ScrollConfiguration(
              behavior: _NoGlowScrollBehavior(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 120,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(),
                      buildProfileSection(),
                      buildMenuSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
