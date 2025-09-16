import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/constants/app_constants.dart';

enum AppTextFieldType { text, email, password }

class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.isLoading = false,
    this.type = AppTextFieldType.text,
    this.textInputAction,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.semanticLabel,
    this.autofillHints,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.errorColor,
    this.borderWidth,
    this.boxShadow,
    this.prefixIconColor,
    this.suffixIconColor,
  });

  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String value)? validator;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool isLoading;
  final AppTextFieldType type;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? semanticLabel;
  final Iterable<String>? autofillHints;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  @override
  Widget build(BuildContext context) {
    final localController =
        controller ?? useTextEditingController(text: initialValue);
    final focusNode = useFocusNode();
    final isObscured = useState(type == AppTextFieldType.password);
    final errorText = useState<String?>(null);

    String? builtInValidator(String value) {
      if (type == AppTextFieldType.email && value.isNotEmpty) {
        final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
        if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
      }
      return null;
    }

    void runValidation(String value) {
      final customError = validator?.call(value);
      final builtInError = builtInValidator(value);
      errorText.value = customError ?? builtInError;
    }

    useEffect(() {
      if (initialValue != null && initialValue!.isNotEmpty) {
        runValidation(initialValue!);
      }
      return null;
    }, const []);

    TextInputType resolveKeyboardType() {
      if (keyboardType != null) return keyboardType!;
      switch (type) {
        case AppTextFieldType.email:
          return TextInputType.emailAddress;
        case AppTextFieldType.password:
          return TextInputType.visiblePassword;
        default:
          return TextInputType.text;
      }
    }

    Widget? buildSuffix() {
      final children = <Widget>[];
      if (isLoading) {
        children.add(
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.neutralDarkGray,
              ),
            ),
          ),
        );
      }
      if (type == AppTextFieldType.password) {
        children.add(
          IconButton(
            icon: Icon(
              isObscured.value ? Icons.visibility_off : Icons.visibility,
              size: 20,
              color: suffixIconColor ?? AppColors.neutralDarkGray,
            ),
            onPressed: enabled && !readOnly
                ? () {
                    isObscured.value = !isObscured.value;
                  }
                : null,
            tooltip: isObscured.value ? 'Show password' : 'Hide password',
          ),
        );
      } else if (suffixIcon != null) {
        children.add(
          Icon(
            suffixIcon,
            size: 20,
            color: suffixIconColor ?? AppColors.neutralDarkGray,
          ),
        );
      }
      if (children.isEmpty) return null;
      return Row(mainAxisSize: MainAxisSize.min, children: children);
    }

    InputBorder buildBorder(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppConstants.borderRadiusMedium,
        ),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    final field = AnimatedContainer(
      duration: AppConstants.animationDurationNormal,
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : null,
        border: Border.all(
          color: errorText.value != null
              ? (errorColor ?? AppColors.inputError)
              : (focusNode.hasFocus
                    ? (focusedBorderColor ?? AppColors.inputFocused)
                    : (borderColor ?? AppColors.inputBorder)),
          width: borderWidth ?? 1,
        ),
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: AppSpacing.inputLabelPadding,
              child: Text(label!, style: AppTypography.inputLabel),
            ),
          TextField(
            controller: localController,
            focusNode: focusNode,
            enabled: enabled && !isLoading,
            readOnly: readOnly,
            autofocus: autofocus,
            obscureText: isObscured.value,
            keyboardType: resolveKeyboardType(),
            textInputAction: textInputAction ?? TextInputAction.next,
            maxLines: isObscured.value ? 1 : maxLines,
            minLines: minLines,
            maxLength: maxLength,
            onChanged: (value) {
              runValidation(value);
              onChanged?.call(value);
            },
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: AppTypography.inputHint,
              filled: true,
              fillColor: backgroundColor ?? Colors.white,
              border: buildBorder(Colors.transparent),
              enabledBorder: buildBorder(Colors.transparent),
              focusedBorder: buildBorder(Colors.transparent),
              disabledBorder: buildBorder(Colors.transparent),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      size: 20,
                      color: prefixIconColor ?? AppColors.neutralDarkGray,
                    )
                  : null,
              suffixIcon: buildSuffix(),
              counterText: '',
            ),
            style: const TextStyle(color: Colors.black),
            autofillHints: autofillHints,
          ),
          if (errorText.value != null)
            Padding(
              padding: AppSpacing.inputErrorPadding,
              child: Text(errorText.value!, style: AppTypography.errorText),
            ),
        ],
      ),
    );

    if (semanticLabel != null) {
      return Semantics(
        label: semanticLabel,
        textField: true,
        enabled: enabled,
        child: field,
      );
    }
    return field;
  }
}
