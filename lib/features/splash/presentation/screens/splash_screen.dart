import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../../../services/image_preloader_service.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

    useEffect(() {
      final preloader = ImagePreloaderService();
      preloader
          .clearCache()
          .then((_) {
            return preloader.preloadImages(context, _getOnboardingImageUrls());
          })
          .then((_) {
            isLoading.value = false;
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen(),
                ),
              );
            }
          });
      return null;
    }, []);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.leafGreen, AppColors.treeBrown],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neutralWhite,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.eco, color: AppColors.leafGreen, size: 60),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'NoteToGoal',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.neutralWhite,
                  fontWeight: AppTypography.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (isLoading.value)
                const CircularProgressIndicator(
                  color: AppColors.neutralWhite,
                  strokeWidth: 2,
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getOnboardingImageUrls() {
    return [
      'https://storage.googleapis.com/uxpilot-auth.appspot.com/7f92239b55-3f9634816c4e2de38030.png',
      'https://storage.googleapis.com/uxpilot-auth.appspot.com/4ce53463e4-99ae16824d989071b24d.png',
      'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400&h=400&fit=crop&crop=center',
    ];
  }
}
