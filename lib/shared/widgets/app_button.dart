import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/constants/app_constants.dart';

enum AppButtonVariant { primary, secondary, outlined, text }

enum AppButtonSize { small, medium, large }

class AppButton extends HookWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.child,
    this.text,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.semanticLabel,
    this.tooltip,
    this.minimumSize,
    this.maximumSize,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.shadowColor,
    this.backgroundGradient,
  }) : assert(
         child != null || text != null || icon != null,
         'Either child, text, or icon must be provided',
       );

  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? child;
  final String? text;
  final IconData? icon;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isDisabled;
  final String? semanticLabel;
  final String? tooltip;
  final Size? minimumSize;
  final Size? maximumSize;
  final double? borderRadius;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final Gradient? backgroundGradient;

  bool get isEnabled => !isDisabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final isPressed = useState(false);
    final isHovered = useState(false);

    double getButtonHeight() {
      switch (size) {
        case AppButtonSize.small:
          return 36;
        case AppButtonSize.medium:
          return AppSpacing.buttonMinimumHeight;
        case AppButtonSize.large:
          return 52;
      }
    }

    EdgeInsetsGeometry getButtonPadding() {
      switch (size) {
        case AppButtonSize.small:
          return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        case AppButtonSize.medium:
          return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
        case AppButtonSize.large:
          return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
      }
    }

    TextStyle getButtonTextStyle() {
      TextStyle baseStyle;
      switch (variant) {
        case AppButtonVariant.primary:
          baseStyle = AppTypography.buttonPrimary;
          break;
        case AppButtonVariant.secondary:
          baseStyle = AppTypography.buttonSecondary;
          break;
        case AppButtonVariant.outlined:
          baseStyle = AppTypography.buttonPrimary.copyWith(
            color: AppColors.buttonOutlinedText,
          );
          break;
        case AppButtonVariant.text:
          baseStyle = AppTypography.buttonPrimary.copyWith(
            color: AppColors.buttonPrimary,
          );
          break;
      }

      double fontSize;
      switch (size) {
        case AppButtonSize.small:
          fontSize = 12;
          break;
        case AppButtonSize.medium:
          fontSize = 14;
          break;
        case AppButtonSize.large:
          fontSize = 16;
          break;
      }

      return baseStyle.copyWith(fontSize: fontSize);
    }

    Color getBackgroundColor() {
      if (backgroundColor != null) return backgroundColor!;
      if (!isEnabled) return AppColors.stateDisabled;

      switch (variant) {
        case AppButtonVariant.primary:
          if (isPressed.value) return AppColors.statePressed;
          if (isHovered.value) return AppColors.stateHover;
          return AppColors.buttonPrimary;
        case AppButtonVariant.secondary:
          if (isPressed.value) return AppColors.secondaryBeigeDark;
          if (isHovered.value) return AppColors.secondaryBeigeLight;
          return AppColors.buttonSecondary;
        case AppButtonVariant.outlined:
          return Colors.transparent;
        case AppButtonVariant.text:
          return Colors.transparent;
      }
    }

    Color getForegroundColor() {
      if (foregroundColor != null) return foregroundColor!;
      if (!isEnabled) return AppColors.textSecondary;

      switch (variant) {
        case AppButtonVariant.primary:
          return AppColors.buttonPrimaryText;
        case AppButtonVariant.secondary:
          return AppColors.buttonSecondaryText;
        case AppButtonVariant.outlined:
          return AppColors.buttonOutlinedText;
        case AppButtonVariant.text:
          return AppColors.buttonPrimary;
      }
    }

    Color getBorderColor() {
      if (borderColor != null) return borderColor!;
      if (!isEnabled) return AppColors.stateDisabled;

      switch (variant) {
        case AppButtonVariant.outlined:
          if (isPressed.value) return AppColors.statePressed;
          if (isHovered.value) return AppColors.stateHover;
          return AppColors.buttonOutlined;
        default:
          return Colors.transparent;
      }
    }

    double getBorderWidth() {
      switch (variant) {
        case AppButtonVariant.outlined:
          return 1.5;
        default:
          return 0;
      }
    }

    double getCurrentElevation() {
      if (elevation != null) return elevation!;
      if (!isEnabled) return 0;

      switch (variant) {
        case AppButtonVariant.primary:
        case AppButtonVariant.secondary:
          if (isPressed.value) return 1;
          if (isHovered.value) return 4;
          return 2;
        default:
          return 0;
      }
    }

    Widget buildContent() {
      if (isLoading) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(getForegroundColor()),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text ?? '',
              style: getButtonTextStyle().copyWith(color: getForegroundColor()),
            ),
          ],
        );
      }

      final List<Widget> contentChildren = [];

      if (leadingIcon != null) {
        contentChildren.add(
          Icon(leadingIcon, size: 20, color: getForegroundColor()),
        );
        if (text != null ||
            child != null ||
            icon != null ||
            trailingIcon != null) {
          contentChildren.add(const SizedBox(width: 8));
        }
      }

      if (icon != null && text == null && child == null) {
        contentChildren.add(Icon(icon, size: 20, color: getForegroundColor()));
      } else if (text != null) {
        contentChildren.add(
          Text(
            text!,
            style: getButtonTextStyle().copyWith(color: getForegroundColor()),
          ),
        );
      } else if (child != null) {
        contentChildren.add(child!);
      }

      if (trailingIcon != null) {
        if (text != null || child != null || icon != null) {
          contentChildren.add(const SizedBox(width: 8));
        }
        contentChildren.add(
          Icon(trailingIcon, size: 20, color: getForegroundColor()),
        );
      }

      if (contentChildren.length == 1) {
        return contentChildren.first;
      }

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: contentChildren,
      );
    }

    Widget button = AnimatedContainer(
      duration: AppConstants.animationDurationNormal,
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        minWidth: minimumSize?.width ?? 0,
        maxWidth: maximumSize?.width ?? double.infinity,
        minHeight: minimumSize?.height ?? getButtonHeight(),
        maxHeight: maximumSize?.height ?? getButtonHeight(),
      ),
      child: Material(
        color: backgroundGradient != null
            ? Colors.transparent
            : getBackgroundColor(),
        elevation: getCurrentElevation(),
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppConstants.borderRadiusMedium,
        ),
        clipBehavior: Clip.antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
            border: Border.all(
              color: getBorderColor(),
              width: getBorderWidth(),
            ),
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppConstants.borderRadiusMedium,
            ),
            color: backgroundGradient == null ? getBackgroundColor() : null,
          ),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            onLongPress: isEnabled ? () {} : null,
            onTapDown: isEnabled ? (_) => isPressed.value = true : null,
            onTapUp: isEnabled ? (_) => isPressed.value = false : null,
            onTapCancel: isEnabled ? () => isPressed.value = false : null,
            onHover: isEnabled ? (hovered) => isHovered.value = hovered : null,
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppConstants.borderRadiusMedium,
            ),
            splashColor: getForegroundColor().withOpacity(0.12),
            highlightColor: getForegroundColor().withOpacity(0.06),
            child: Container(
              padding: getButtonPadding(),
              alignment: Alignment.center,
              child: buildContent(),
            ),
          ),
        ),
      ),
    );

    if (semanticLabel != null || !isEnabled) {
      button = Semantics(
        label: semanticLabel,
        button: true,
        enabled: isEnabled,
        child: button,
      );
    }

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    return button;
  }
}
