import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_to_goal/shared/models/user_profile_model.dart';

class ProfileService {
  ProfileService._internal();

  static final ProfileService _instance = ProfileService._internal();

  factory ProfileService() => _instance;

  static ProfileService get instance => _instance;

  static const String _boxName = 'user_profiles';
  Box<UserProfile>? _box;

  Future<void> init() async {
    if (_box != null) return; // Already initialized

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(UserProfileAdapter());
    }
    _box = await Hive.openBox<UserProfile>(_boxName);
  }

  Box<UserProfile> get box {
    if (_box == null) {
      throw Exception('ProfileService not initialized. Call init() first.');
    }
    return _box!;
  }

  Future<UserProfile?> getCurrentProfile() async {
    if (_box == null) {
      await init();
    }
    final profiles = box.values.toList();
    if (profiles.isEmpty) return null;

    return profiles.first;
  }

  Future<UserProfile> getOrCreateProfile({
    required String id,
    required String email,
    String? name,
  }) async {
    if (_box == null) {
      await init();
    }
    final existingProfile = await getCurrentProfile();

    if (existingProfile != null) {
      return existingProfile;
    }

    final newProfile = UserProfile.fromAuthUser(
      id: id,
      email: email,
      name: name,
    );

    await saveProfile(newProfile);
    return newProfile;
  }

  Future<void> saveProfile(UserProfile profile) async {
    if (_box == null) {
      await init();
    }
    final updatedProfile = profile.copyWith(updatedAt: DateTime.now());

    await box.clear();
    await box.add(updatedProfile);
  }

  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? location,
    String? bio,
    String? profileImageUrl,
  }) async {
    if (_box == null) {
      await init();
    }
    final currentProfile = await getCurrentProfile();
    if (currentProfile == null) return;

    final updatedProfile = currentProfile.copyWith(
      name: name,
      phoneNumber: phoneNumber,
      location: location,
      bio: bio,
      profileImageUrl: profileImageUrl,
      updatedAt: DateTime.now(),
    );

    await saveProfile(updatedProfile);
  }

  Future<void> clearProfile() async {
    if (_box == null) {
      await init();
    }
    await box.clear();
  }

  ValueListenable<Box<UserProfile>> get listenable {
    if (_box == null) {
      throw Exception('ProfileService not initialized. Call init() first.');
    }
    return box.listenable();
  }
}
