import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/constants/app_constants.dart';

enum AppCardVariant { elevated, outlined, filled }

class AppCard extends HookWidget {
  const AppCard({
    super.key,
    this.variant = AppCardVariant.elevated,
    this.padding = AppSpacing.cardPadding,
    this.margin = AppSpacing.cardMargin,
    this.borderRadius = AppConstants.borderRadiusMedium,
    this.elevation = 2,
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
    this.onTap,
    this.onLongPress,
    this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.content,
    this.actions,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.semanticLabel,
  });

  final AppCardVariant variant;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? content;
  final List<Widget>? actions;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final isPressed = useState(false);

    Color getBackgroundColor() {
      if (backgroundColor != null) return backgroundColor!;
      switch (variant) {
        case AppCardVariant.elevated:
        case AppCardVariant.outlined:
          return AppColors.cardBackground;
        case AppCardVariant.filled:
          return AppColors.secondaryBeigeLight;
      }
    }

    Color getBorderColor() {
      if (borderColor != null) return borderColor!;
      switch (variant) {
        case AppCardVariant.elevated:
          return AppColors.cardBorder.withOpacity(0.2);
        case AppCardVariant.outlined:
          return AppColors.cardBorder;
        case AppCardVariant.filled:
          return AppColors.cardBorder.withOpacity(0.3);
      }
    }

    double getElevation() {
      if (isPressed.value) return elevation * 0.5;
      if (isHovered.value) return elevation * 1.5;
      return elevation;
    }

    Color getShadowColor() {
      return shadowColor ?? AppColors.cardShadow;
    }

    Widget buildContent() {
      if (child != null) {
        return child!;
      }

      final List<Widget> children = [];

      if (title != null ||
          subtitle != null ||
          leading != null ||
          trailing != null) {
        children.add(
          Row(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (leading != null) ...[
                leading!,
                AppSpacing.horizontalSpaceSmall,
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    if (title != null) title!,
                    if (subtitle != null) ...[
                      AppSpacing.verticalSpaceTiny,
                      subtitle!,
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                AppSpacing.horizontalSpaceSmall,
                trailing!,
              ],
            ],
          ),
        );
      }

      if (content != null) {
        if (children.isNotEmpty) {
          children.add(AppSpacing.verticalSpaceMedium);
        }
        children.add(content!);
      }

      if (actions != null && actions!.isNotEmpty) {
        if (children.isNotEmpty) {
          children.add(AppSpacing.verticalSpaceMedium);
        }
        children.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions!.map((action) {
              return Padding(
                padding: EdgeInsets.only(left: AppSpacing.sm),
                child: action,
              );
            }).toList(),
          ),
        );
      }

      return Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      );
    }

    Widget card = Container(
      margin: margin,
      child: Material(
        color: getBackgroundColor(),
        elevation: getElevation(),
        shadowColor: getShadowColor(),
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          onHover: (hovered) => isHovered.value = hovered,
          onTapDown: (_) => isPressed.value = true,
          onTapUp: (_) => isPressed.value = false,
          onTapCancel: () => isPressed.value = false,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: AppColors.primaryBrown.withOpacity(0.1),
          highlightColor: AppColors.primaryBrown.withOpacity(0.05),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              border: Border.all(
                color: getBorderColor(),
                width: variant == AppCardVariant.outlined ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: buildContent(),
          ),
        ),
      ),
    );

    if (semanticLabel != null) {
      card = Semantics(
        label: semanticLabel,
        button: onTap != null,
        child: card,
      );
    }

    return AnimatedContainer(
      duration: AppConstants.animationDurationNormal,
      curve: Curves.easeInOut,
      child: card,
    );
  }
}
