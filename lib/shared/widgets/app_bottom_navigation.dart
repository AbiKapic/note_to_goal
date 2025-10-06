import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/constants/app_constants.dart';

class AppBottomNavigationItem {
  const AppBottomNavigationItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeCount,
    this.tooltip,
    this.semanticLabel,
  });

  final IconData icon;
  final String label;
  final IconData? activeIcon;
  final int? badgeCount;
  final String? tooltip;
  final String? semanticLabel;
}

class AppBottomNavigation extends HookWidget {
  const AppBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.showLabels = true,
    this.showUnselectedLabels = true,
    this.elevation = 0,
    this.height = 80.0,
    this.borderRadius = 0.0,
    this.semanticLabel,
  }) : assert(
         items.length >= 2 && items.length <= 5,
         'Bottom navigation should have between 2 and 5 items',
       );

  final List<AppBottomNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool showLabels;
  final bool showUnselectedLabels;
  final double elevation;
  final double height;
  final double borderRadius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final previousIndex = useState(currentIndex);
    final isAnimating = useState(false);

    useEffect(() {
      if (previousIndex.value != currentIndex) {
        isAnimating.value = true;
        Future.delayed(AppConstants.animationDurationNormal, () {
          isAnimating.value = false;
          previousIndex.value = currentIndex;
        });
      }
      return null;
    }, [currentIndex]);

    Widget buildBadge(int? count) {
      if (count == null || count == 0) return const SizedBox.shrink();

      return Positioned(
        top: 2,
        right: 2,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
            maxWidth: 24,
            maxHeight: 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.accentError,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: backgroundColor ?? AppColors.navigationBackground,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              count > 99 ? '99+' : count.toString(),
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.neutralWhite,
                fontSize: 10,
                fontWeight: AppTypography.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    Widget buildNavItem(int index) {
      final item = items[index];
      final isSelected = index == currentIndex;
      final wasPreviouslySelected = index == previousIndex.value;

      final Color iconColor = isSelected
          ? AppColors.leafGreen
          : AppColors.neutralDarkGray.withValues(alpha: 0.7);
      final Color labelColor = isSelected
          ? AppColors.leafGreen
          : AppColors.neutralDarkGray.withValues(alpha: 0.7);

      final TextStyle labelStyle = isSelected
          ? AppTypography.navigationLabelSelected
          : AppTypography.navigationLabel;

      final IconData displayIcon = isSelected && item.activeIcon != null
          ? item.activeIcon!
          : item.icon;

      final double iconSize = 24;
      final double itemHeight = height - 16;

      Widget iconWidget = AnimatedContainer(
        duration: AppConstants.animationDurationNormal,
        curve: Curves.easeInOut,
        child: Icon(displayIcon, size: iconSize, color: iconColor),
      );

      if (item.badgeCount != null && item.badgeCount! > 0) {
        iconWidget = Stack(
          clipBehavior: Clip.none,
          children: [iconWidget, buildBadge(item.badgeCount)],
        );
      }

      Widget labelWidget = const SizedBox.shrink();
      if (showLabels) {
        if (isSelected || showUnselectedLabels) {
          labelWidget = AnimatedDefaultTextStyle(
            duration: AppConstants.animationDurationNormal,
            curve: Curves.easeInOut,
            style: labelStyle.copyWith(color: labelColor),
            child: Text(
              item.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      }

      Widget content = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          if (labelWidget != const SizedBox.shrink()) ...[
            const SizedBox(height: 2),
            labelWidget,
          ],
        ],
      );

      if (isAnimating.value) {
        final double scale = isSelected
            ? 1.1
            : wasPreviouslySelected
            ? 0.9
            : 1.0;
        content = AnimatedScale(
          duration: AppConstants.animationDurationNormal,
          curve: Curves.easeInOut,
          scale: scale,
          child: content,
        );
      }

      return Expanded(
        child: Semantics(
          selected: isSelected,
          label: item.semanticLabel ?? item.label,
          button: true,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(16),
              splashColor: isSelected
                  ? AppColors.neutralBlack.withValues(alpha: 0.12)
                  : AppColors.neutralDarkGray.withValues(alpha: 0.08),
              highlightColor: isSelected
                  ? AppColors.neutralBlack.withValues(alpha: 0.08)
                  : AppColors.neutralDarkGray.withValues(alpha: 0.04),
              splashFactory: InkRipple.splashFactory,
              child: Container(
                height: itemHeight,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.neutralBlack.withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.neutralBlack.withValues(
                                  alpha: 0.15,
                                ),
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Icon(displayIcon, size: 24, color: iconColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: AppTypography.bodySmall.copyWith(
                        color: labelColor,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 11,
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget navigationBar = SafeArea(
      top: false,
      child: Container(
        height: height,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.neutralWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: const Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, -2),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (index) => buildNavItem(index)),
        ),
      ),
    );

    if (semanticLabel != null) {
      navigationBar = Semantics(label: semanticLabel, child: navigationBar);
    }

    return AnimatedContainer(
      duration: AppConstants.animationDurationNormal,
      curve: Curves.easeInOut,
      child: navigationBar,
    );
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.type = BottomNavigationBarType.fixed,
    this.elevation = 8,
    this.iconSize = 24,
    this.selectedFontSize = 12,
    this.unselectedFontSize = 12,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final BottomNavigationBarType type;
  final double elevation;
  final double iconSize;
  final double selectedFontSize;
  final double unselectedFontSize;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutralWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, -1),
            spreadRadius: 1,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        selectedItemColor: selectedItemColor ?? AppColors.leafGreen,
        unselectedItemColor:
            unselectedItemColor ??
            AppColors.neutralDarkGray.withValues(alpha: 0.7),
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        type: type,
        elevation: 0,
        iconSize: iconSize,
        selectedFontSize: selectedFontSize,
        unselectedFontSize: unselectedFontSize,
        selectedLabelStyle:
            selectedLabelStyle ??
            AppTypography.navigationLabelSelected.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              letterSpacing: 0.3,
              color: AppColors.leafGreen,
            ),
        unselectedLabelStyle:
            unselectedLabelStyle ??
            AppTypography.navigationLabel.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              letterSpacing: 0.3,
              color: AppColors.neutralDarkGray.withValues(alpha: 0.7),
            ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            activeIcon: Icon(Icons.home_rounded, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_rounded, size: 28),
            activeIcon: Icon(Icons.add_circle_rounded, size: 28),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 28),
            activeIcon: Icon(Icons.person_rounded, size: 28),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
