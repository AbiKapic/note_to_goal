import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../features/create/presentation/screens/create_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/search_screen.dart';
import '../../features/library/presentation/screens/library_screen.dart';
import '../../navigations/app_routes.dart';
import 'app_bottom_navigation.dart';

class MainShell extends HookWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    final navigationItems = [
      AppBottomNavigationItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: 'Home',
        semanticLabel: 'Navigate to home screen',
      ),
      AppBottomNavigationItem(
        icon: Icons.search_outlined,
        activeIcon: Icons.search,
        label: 'Search',
        semanticLabel: 'Navigate to search screen',
      ),
      AppBottomNavigationItem(
        icon: Icons.add,
        activeIcon: Icons.add,
        label: 'Create',
        semanticLabel: 'Navigate to create screen',
      ),
      AppBottomNavigationItem(
        icon: Icons.library_books_outlined,
        activeIcon: Icons.library_books,
        label: 'Library',
        semanticLabel: 'Navigate to library screen',
      ),
    ];

    final screens = const [
      HomeScreen(key: PageStorageKey<String>(AppRoutes.home)),
      SearchScreen(key: PageStorageKey<String>(AppRoutes.search)),
      CreateScreen(key: PageStorageKey<String>(AppRoutes.create)),
      LibraryScreen(key: PageStorageKey<String>(AppRoutes.library)),
    ];

    void onTabTap(int index) {
      currentIndex.value = index;
    }

    return Scaffold(
      body: IndexedStack(index: currentIndex.value, children: screens),
      bottomNavigationBar: SafeArea(
        child: AppBottomNavigation(
          items: navigationItems,
          currentIndex: currentIndex.value,
          onTap: onTabTap,
          semanticLabel: 'Main navigation',
        ),
      ),
    );
  }
}
