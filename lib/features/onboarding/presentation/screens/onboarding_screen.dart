import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../navigations/app_routes.dart';
import '../../../../shared/widgets/app_button.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);

    final onboardingPages = [
      _OnboardingPage(
        title: 'Welcome to NoteToGoal',
        description: 'Transform your everyday notes into achievable goals and track your progress towards success.',
        imagePath: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/7f92239b55-3f9634816c4e2de38030.png',
        backgroundColor: AppColors.warmYellow,
      ),
      _OnboardingPage(
        title: 'Organize Your Thoughts',
        description: 'Create different types of notes - quick notes, journal entries, goals, successes, habits, and inspiration.',
        imagePath: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/4ce53463e4-99ae16824d989071b24d.png',
        backgroundColor: AppColors.softCream,
      ),
      _OnboardingPage(
        title: 'Track Your Progress',
        description: 'Monitor your journey with progress tracking, priority levels, and achievement milestones.',
        imagePath: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-5.jpg',
        backgroundColor: AppColors.leafGreen,
      ),
    ];

    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
      );
      return null;
    }, const []);

    void nextPage() {
      if (currentPage.value < onboardingPages.length - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    }

    void skipToLogin() {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              onboardingPages[currentPage.value].backgroundColor,
              onboardingPages[currentPage.value].backgroundColor.withValues(alpha: 0.8),
              AppColors.neutralWhite,
            ],
            stops: const [0.0, 0.7, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 60),
                    TextButton(
                      onPressed: skipToLogin,
                      child: Text(
                        'Skip',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.treeBrown,
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Page view
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) => currentPage.value = index,
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) => onboardingPages[index],
                ),
              ),
              
              // Bottom section with indicators and button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingPages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage.value == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage.value == index
                                ? AppColors.treeBrown
                                : AppColors.treeBrown.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Action button
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: currentPage.value == onboardingPages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        onPressed: nextPage,
                        leadingIcon: currentPage.value == onboardingPages.length - 1
                            ? Icons.login
                            : Icons.arrow_forward,
                        size: AppButtonSize.large,
                        borderRadius: 28,
                        elevation: 8,
                        foregroundColor: AppColors.textOnBrown,
                        backgroundGradient: const LinearGradient(
                          colors: [AppColors.leafGreen, AppColors.primaryBrown],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        semanticLabel: currentPage.value == onboardingPages.length - 1
                            ? 'Get started button'
                            : 'Next page button',
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
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive sizing
    final imageSize = screenHeight < 600 ? 150.0 : (screenWidth < 400 ? 160.0 : 200.0);
    final titleFontSize = screenWidth < 400 ? 24.0 : 28.0;
    final descriptionFontSize = screenWidth < 400 ? 14.0 : 16.0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight * 0.6, // Ensure minimum height but allow scroll
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.neutralLightGray,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.leafGreen,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.leafGreen, AppColors.treeBrown],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.eco,
                            color: AppColors.textOnBrown,
                            size: imageSize * 0.4,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: screenHeight < 600 ? 32 : 48),
              
              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.treeBrown,
                  fontWeight: AppTypography.bold,
                  fontSize: titleFontSize,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              
              // Description (avoid Flexible inside scroll views to prevent unbounded height errors)
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.treeBrown.withValues(alpha: 0.8),
                  fontSize: descriptionFontSize,
                  height: 1.5,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              SizedBox(height: screenHeight < 600 ? 16 : 24),
            ],
          ),
        ),
      ),
    );
  }
}
