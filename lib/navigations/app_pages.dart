import 'package:flutter/material.dart';

import '../features/account/presentation/screens/account_screen.dart';
import '../features/auth/presentation/widgets/auth_wrapper.dart';
import '../features/create/presentation/screens/create_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/search_screen.dart';
import '../features/library/presentation/screens/library_screen.dart';
import '../features/note_detail/presentation/screens/note_detail_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  static Map<String, Widget Function(BuildContext)> get routes => {
    AppRoutes.onboarding: (_) => const OnboardingScreen(),
    AppRoutes.home: (_) => const HomeScreen(),
    AppRoutes.search: (_) => const SearchScreen(),
    AppRoutes.create: (_) => const CreateScreen(),
    AppRoutes.library: (_) => const LibraryScreen(),
    AppRoutes.account: (_) => const AccountScreen(),
    // Wrap login with AuthWrapper to provide AuthBloc and handle auth navigation
    AppRoutes.login: (_) => const AuthWrapper(),
    AppRoutes.noteDetail: (_) => const NoteDetailScreen(),
  };

  static Route<dynamic> createRoute(RouteSettings settings) {
    final WidgetBuilder? builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    return MaterialPageRoute(
      builder: (_) => const Scaffold(body: SizedBox.shrink()),
      settings: settings,
    );
  }
}
