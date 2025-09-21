import 'package:flutter/material.dart';

import '../features/account/presentation/screens/account_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/create/presentation/screens/create_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/search_screen.dart';
import '../features/library/presentation/screens/library_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  static Map<String, Widget Function(BuildContext)> get routes => {
    AppRoutes.home: (_) => const HomeScreen(),
    AppRoutes.search: (_) => const SearchScreen(),
    AppRoutes.create: (_) => const CreateScreen(),
    AppRoutes.library: (_) => const LibraryScreen(),
    AppRoutes.account: (_) => const AccountScreen(),
    AppRoutes.login: (_) => const LoginScreen(),
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
