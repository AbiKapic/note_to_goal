class AppConstants {
  static const String appName = 'Note to Goal';

  static const int defaultPageSize = 20;
  static const int maxRetryCount = 3;
  static const Duration defaultTimeout = Duration(seconds: 30);

  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusExtraLarge = 16.0;

  static const double spacingExtraSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingExtraLarge = 32.0;

  static const Duration animationDurationFast = Duration(milliseconds: 150);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  static const String routeHome = '/';
  static const String routeCreate = '/create';
  static const String routeAccount = '/account';
  static const String routeSettings = '/settings';
  static const String routeProfile = '/profile';

  static const int navigationTabHome = 0;
  static const int navigationTabCreate = 1;
  static const int navigationTabAccount = 2;

  static const String screenTitleHome = 'Home';
  static const String screenTitleCreate = 'Create';
  static const String screenTitleAccount = 'Account';

  static const String greetingMorning = 'Good Morning!';
  static const String greetingAfternoon = 'Good Afternoon!';
  static const String greetingEvening = 'Good Evening!';
  static const String greetingSubtitle = 'Ready to turn your notes into goals?';

  static const String activitySectionTitle = 'Recent Activity';

  static const String statsGoalsLabel = 'Goals';
  static const String statsSuccessLabel = 'Success';
  static const String statsNotesLabel = 'Notes';

  static const String activityTypeGoal = 'GOAL';
  static const String activityTypeSuccess = 'SUCCESS';
  static const String activityTypeNote = 'NOTE';

  static const String timeAgoFormat = '%s ago';
  static const String timeAgoJustNow = 'Just now';

  static const String placeholderComingSoon = 'Coming Soon';

  static const String errorGeneric = 'An unexpected error occurred';
  static const String errorNetwork = 'Network connection failed';
  static const String errorTimeout = 'Request timed out';
  static const String errorUnauthorized = 'Authentication required';
}
