import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:note_to_goal/core/bloc/base_state.dart';
import 'package:note_to_goal/core/theme/app_colors.dart';
import 'package:note_to_goal/core/theme/app_typography.dart';
import 'package:note_to_goal/features/auth/bloc/auth_bloc.dart';
import 'package:note_to_goal/features/auth/bloc/auth_event.dart';
import 'package:note_to_goal/features/auth/bloc/auth_state.dart';
import 'package:note_to_goal/features/auth/presentation/screens/login_screen.dart';
import 'package:note_to_goal/shared/widgets/handled_exception_snackbar_overlay.dart';
import 'package:note_to_goal/shared/widgets/main_shell.dart';

class AuthWrapper extends HookWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return HandledExceptionSnackbarOverlay(
      child: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
        child: const _AuthGate(),
      ),
    );
  }
}

class _AuthGate extends HookWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    useEffect(() {
      bloc.add(const AuthSessionCheckRequested());
      return null;
    }, const []);

    return BlocBuilder<AuthBloc, BaseState<AuthUser>>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const _AuthLoadingView();
        }
        if (state is AuthAuthenticated) {
          return const MainShell();
        }
        if (state is AuthUnauthenticated) {
          return const LoginScreen();
        }
        if (state is AuthError) {
          return _AuthErrorView(
            message: state.message,
            onRetry: () => bloc.add(const AuthSessionCheckRequested()),
          );
        }
        return const _AuthLoadingView();
      },
    );
  }
}

class _AuthLoadingView extends StatelessWidget {
  const _AuthLoadingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralOffWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.secondaryBeigeVariant,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.eco,
                color: AppColors.primaryBrown,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'NoteToGoal',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: AppTypography.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: AppColors.primaryBrown),
          ],
        ),
      ),
    );
  }
}

class _AuthErrorView extends StatelessWidget {
  const _AuthErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralOffWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.neutralDarkGray,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBrown,
                  foregroundColor: AppColors.textOnBrown,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
