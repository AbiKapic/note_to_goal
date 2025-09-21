import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_to_goal/core/theme/app_theme.dart';
import 'package:note_to_goal/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:note_to_goal/navigations/app_pages.dart';
import 'package:note_to_goal/shared/widgets/handled_exception_snackbar_overlay.dart';

class App extends StatelessWidget {
  App({super.key, required this.apiBaseUrl}) {
    App.configApiBaseUrl = apiBaseUrl.endsWith('/')
        ? apiBaseUrl
        : '$apiBaseUrl/';
  }

  final String apiBaseUrl;

  static late final String configApiBaseUrl;

  @override
  Widget build(BuildContext context) {
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

    return MaterialApp(
      title: 'Note to Goal',
      builder: (context, child) => HandledExceptionSnackbarOverlay(
        child: child ?? const SizedBox.shrink(),
      ),
      home: const AuthWrapper(),
      routes: AppPages.routes,
      onGenerateRoute: AppPages.createRoute,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
