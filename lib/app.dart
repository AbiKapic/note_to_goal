import 'package:flutter/material.dart';
import 'package:note_to_goal/core/theme/app_theme.dart';
import 'package:note_to_goal/navigations/app_pages.dart';
import 'package:note_to_goal/shared/widgets/main_shell.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note to Goal',
      home: const MainShell(),
      routes: AppPages.routes,
      onGenerateRoute: AppPages.createRoute,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
