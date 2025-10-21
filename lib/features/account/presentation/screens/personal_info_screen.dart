import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../services/profile_service.dart';
import '../../../../shared/models/user_profile_model.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../widgets/account_header.dart';

class PersonalInfoScreen extends HookWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentProfile = useState<UserProfile?>(null);
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final locationController = useTextEditingController();
    final bioController = useTextEditingController();

    final isEditing = useState(false);
    final isSaving = useState(false);
    final isLoading = useState(true);

    Future<void> loadProfile() async {
      try {
        final profile = await ProfileService.instance.getCurrentProfile();
        if (profile != null) {
          currentProfile.value = profile;
          nameController.text = profile.name;
          emailController.text = profile.email;
          phoneController.text = profile.phoneNumber ?? '';
          locationController.text = profile.location ?? '';
          bioController.text = profile.bio ?? '';
        }
      } catch (e) {
        print('Error loading profile: $e');
      } finally {
        isLoading.value = false;
      }
    }

    useEffect(() {
      loadProfile();
      return null;
    }, []);

    void toggleEdit() {
      isEditing.value = !isEditing.value;
    }

    Future<void> saveChanges() async {
      if (isSaving.value) return;

      isSaving.value = true;

      try {
        await ProfileService.instance.updateProfile(
          name: nameController.text.trim(),
          phoneNumber: phoneController.text.trim().isEmpty
              ? null
              : phoneController.text.trim(),
          location: locationController.text.trim().isEmpty
              ? null
              : locationController.text.trim(),
          bio: bioController.text.trim().isEmpty
              ? null
              : bioController.text.trim(),
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.accentSuccess),
                  const SizedBox(width: 8),
                  Text(
                    'Profile updated successfully!',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.neutralWhite,
            ),
          );

          isEditing.value = false;
          await loadProfile(); // Reload profile to get updated data
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update profile: $e'),
              backgroundColor: AppColors.accentError,
            ),
          );
        }
      } finally {
        isSaving.value = false;
      }
    }

    Widget buildInfoCard({
      required String title,
      required IconData icon,
      required TextEditingController controller,
      int maxLines = 1,
    }) {
      return Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(20),
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
                  child: Icon(icon, size: 18, color: AppColors.leafGreen),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.treeBrown,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isEditing.value)
              AppTextField(
                controller: controller,
                type: AppTextFieldType.text,
                maxLines: maxLines,
                backgroundColor: AppColors.neutralWhite,
                borderRadius: 12,
                borderColor: AppColors.neutralLightGray,
                focusedBorderColor: AppColors.leafGreen,
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.softCream.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.neutralLightGray,
                    width: 1,
                  ),
                ),
                child: Text(
                  controller.text,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    if (isLoading.value) {
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
          child: const SafeArea(
            child: Center(
              child: CircularProgressIndicator(color: AppColors.leafGreen),
            ),
          ),
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
                title: 'Personal Information',
                onBackTap: () => Navigator.of(context).pop(),
                onSettingsTap: toggleEdit,
                settingsIcon: isEditing.value ? Icons.close : Icons.edit,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Profile picture section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.treeBrown.withValues(alpha: 0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow.withValues(alpha: 0.1),
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
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.neutralWhite,
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.shadow.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child:
                                        currentProfile.value?.profileImageUrl !=
                                            null
                                        ? Image.network(
                                            currentProfile
                                                .value!
                                                .profileImageUrl!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    color: AppColors.softCream,
                                                    child: Icon(
                                                      Icons.account_circle,
                                                      size: 60,
                                                      color: AppColors.treeBrown
                                                          .withValues(
                                                            alpha: 0.5,
                                                          ),
                                                    ),
                                                  );
                                                },
                                          )
                                        : Container(
                                            color: AppColors.softCream,
                                            child: Icon(
                                              Icons.account_circle,
                                              size: 60,
                                              color: AppColors.treeBrown
                                                  .withValues(alpha: 0.5),
                                            ),
                                          ),
                                  ),
                                ),
                                if (isEditing.value)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          // Handle image change
                                        },
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.leafGreen,
                                                AppColors.treeBrown,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.shadow
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 6,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: AppColors.neutralWhite,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Profile Picture',
                              style: AppTypography.titleMedium.copyWith(
                                color: AppColors.treeBrown,
                                fontWeight: AppTypography.semiBold,
                              ),
                            ),
                            if (isEditing.value)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Tap camera icon to update',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Information fields
                      buildInfoCard(
                        title: 'Full Name',
                        icon: Icons.person,
                        controller: nameController,
                      ),
                      buildInfoCard(
                        title: 'Email Address',
                        icon: Icons.email,
                        controller: emailController,
                      ),
                      buildInfoCard(
                        title: 'Phone Number',
                        icon: Icons.phone,
                        controller: phoneController,
                      ),
                      buildInfoCard(
                        title: 'Location',
                        icon: Icons.location_on,
                        controller: locationController,
                      ),
                      buildInfoCard(
                        title: 'Bio',
                        icon: Icons.description,
                        controller: bioController,
                        maxLines: 3,
                      ),

                      if (isEditing.value) ...[
                        const SizedBox(height: 32),
                        AppButton(
                          onPressed: isSaving.value ? null : saveChanges,
                          text: 'Save Changes',
                          leadingIcon: Icons.save,
                          isLoading: isSaving.value,
                          size: AppButtonSize.large,
                          borderRadius: 28,
                          elevation: 8,
                          foregroundColor: AppColors.textOnBrown,
                          backgroundGradient: const LinearGradient(
                            colors: [
                              AppColors.leafGreen,
                              AppColors.primaryBrown,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ],

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
