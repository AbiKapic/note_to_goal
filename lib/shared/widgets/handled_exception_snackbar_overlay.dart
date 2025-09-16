import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:note_to_goal/core/theme/app_colors.dart';
import 'package:note_to_goal/core/theme/app_typography.dart';
import 'package:note_to_goal/shared/exceptions/handled_exception.dart';

class HandledExceptionSnackbarOverlay extends HookWidget {
  const HandledExceptionSnackbarOverlay({super.key, required this.child});

  final Widget child;

  static BuildContext? _overlayContext;

  static void show(HandledException exception) {
    final context = _overlayContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                color: AppColors.accentError,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                exception.message,
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: AppTypography.medium,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.accentError,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (ctx) {
            _overlayContext = ctx;
            return child;
          },
        ),
      ],
    );
  }
}
